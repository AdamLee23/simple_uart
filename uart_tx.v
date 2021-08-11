////////////////////////////////////////////////////////////////////////
//  UART transmitter
//
//  set i_tx_trig 1 for 1 cycle to trigger a transmission
//  o_tx_busy set 1 when transmitting
//  o_tx_done set 1 for 1 cycle when all bits are transmitted
//  async active low reset_n
////////////////////////////////////////////////////////////////////////

module uart_tx #(
    parameter BIT_RATE =        115200,         // bit rate in bit/s
    parameter CLK_FREQ =        10_000_000,     // clock frequency in Hz
    parameter PAYLOAD_BITS =    8               // number of bits to be transmitted
) ( 
    input                           clk,
    input                           reset_n,
    input                           i_tx_trig,
    input       [PAYLOAD_BITS-1:0]  i_data,
    output  reg                     o_tx_busy,
    output  reg                     o_tx_done,
    output  reg                     o_serial_data
);

    localparam CLKS_PER_BIT =   CLK_FREQ / BIT_RATE;          // clocks per bit (CPB)
    localparam CLK_CNTER_BW =   $clog2(CLKS_PER_BIT) + 1;     // bit width for clk_cnter
    localparam BIT_CNTER_BW =   $clog2(PAYLOAD_BITS) + 1;     // bit width for bit_cnter

    // fsm states
    localparam IDLE =       2'b00;
    localparam START_BIT =  2'b01;
    localparam DATA_BITS =  2'b11;
    localparam STOP_BIT =   2'b10;

    reg     [CLK_CNTER_BW-1:0]  r_clk_cnter;  // counting clk edges
    reg     [BIT_CNTER_BW-1:0]  r_bit_cnter;  // counting bits transmitted

    // registered input data
    reg [PAYLOAD_BITS-1:0] r_i_data;

    reg [1:0]  r_state;
    reg [1:0]  r_next_state;

    reg start_bit_init; // are we at the head of the start bit?
    reg data_bit_init;  // are we at the head of a data bit?
    reg stop_bit_init;  // are we at the head of the stop bit?
    reg stop_bit_end;   // are we at the tail of the stop bit?
    reg busy;           // are we busy transmitting bits?

    // fsm next state logic
    always @ (*) begin
        r_next_state = IDLE;
        case (r_state)

            // trigger signal set 1, start a transmission
            IDLE: if (i_tx_trig == 1'b1) begin
                r_next_state = START_BIT;
            end else begin
                r_next_state = IDLE;
            end

            // we should transmit the first data bit, go to DATA_BITS
            START_BIT: if (data_bit_init == 1'b1) begin
                r_next_state = DATA_BITS;
            end else begin
                r_next_state = START_BIT;
            end

            // we should transmit the stop bit, go to STOP_BIT
            DATA_BITS: if (stop_bit_init == 1'b1) begin
                r_next_state = STOP_BIT;
            end else begin
                r_next_state = DATA_BITS;
            end

            // stop bit transmitted, go back to IDLE
            STOP_BIT: begin
                if (stop_bit_end == 1'b1) begin
                    r_next_state = IDLE;
                end else begin
                    r_next_state = STOP_BIT;
                end
            end 

        endcase
    end

    // fsm output logic
    always @ (*) begin
        start_bit_init = 1'b0;
        data_bit_init =  1'b0;
        stop_bit_init =  1'b0;
        stop_bit_end =   1'b0;
        busy =  1'b1;
        case (r_state)

            // transmit start bit when trigger signal set 1
            IDLE: begin
                start_bit_init = i_tx_trig == 1'b1;
                busy = 1'b0;
            end

            // start bit lasts for 1 CLKS_PER_BIT
            START_BIT: begin
                data_bit_init = r_clk_cnter == CLKS_PER_BIT;
            end

            DATA_BITS: begin
                if (r_bit_cnter < PAYLOAD_BITS) begin
                    data_bit_init = r_clk_cnter == CLKS_PER_BIT;
                end else begin
                    // all data bits transmitted, transmit stop bit
                    stop_bit_init = r_clk_cnter == CLKS_PER_BIT;
                end
            end

            // stop bit lasts for 1 CLKS_PER_BIT
            STOP_BIT: begin
                stop_bit_end =  r_clk_cnter == CLKS_PER_BIT;
            end

        endcase
    end

    always @ (posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            r_state <= IDLE;
        end else begin
            r_state <= r_next_state;
        end
    end

    // register input data at the beginning of transmission
    always @ (posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            r_i_data <= {PAYLOAD_BITS{1'b0}};
        end else if (start_bit_init) begin
            r_i_data <= i_data;
        end
    end

    // update data bit when necessary
    always @ (posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            o_serial_data <= {PAYLOAD_BITS{1'b0}};
        end else begin
            if (start_bit_init == 1'b1) begin
            // start bit
            o_serial_data <= 1'b0;
            end else if (data_bit_init == 1'b1) begin
            // data bit
            o_serial_data <= r_i_data[r_bit_cnter];
            end else if (stop_bit_init == 1'b1) begin
            // stop bit
            o_serial_data <= 1'b1;
            end
        end
    end

    // r_clk_cnter and r_bit_cnter control
    always @ (posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            r_clk_cnter <= {CLK_CNTER_BW{1'b0}};
            r_bit_cnter <= {BIT_CNTER_BW{1'b0}};
        end else begin
            case (r_state)

                IDLE: begin
                    r_clk_cnter <= {CLK_CNTER_BW{1'b0}};
                    r_bit_cnter <= {BIT_CNTER_BW{1'b0}};
                end

                // r_clk_cnter counting from 0 to CLKS_PER_BIT
                START_BIT: begin
                    if (r_clk_cnter < CLKS_PER_BIT) begin
                        r_clk_cnter <= r_clk_cnter + 1'b1;
                    end else begin
                        r_clk_cnter <= {CLK_CNTER_BW{1'b0}};
                    end
                    // at the head of the first data bit, r_bit_cnter adds 1 (0 -> 1)
                    if (data_bit_init == 1'b1) begin
                        r_bit_cnter <= r_bit_cnter + 1'b1;
                    end
                end

                // r_clk_cnter counting from 0 to CLKS_PER_BIT
                DATA_BITS: begin
                    if (r_clk_cnter < CLKS_PER_BIT) begin
                        r_clk_cnter <= r_clk_cnter + 1'b1;
                    end else begin
                        r_clk_cnter <= {CLK_CNTER_BW{1'b0}};
                    end
                    // at the head of each data bit, r_bit_cnter adds 1 (1 -> 2, 2 -> 3, ... , PAYLOAD_BITS-1 -> PAYLOAD_BITS)
                    if (data_bit_init == 1'b1) begin
                        r_bit_cnter <= r_bit_cnter + 1'b1;
                    end else if (stop_bit_init == 1'b1) begin
                        r_bit_cnter <= {BIT_CNTER_BW{1'b0}};    // reset r_bit_cnter when at head of stop bit
                    end
                end

                // r_clk_cnter counting from 0 to CLKS_PER_BIT
                STOP_BIT: if (r_clk_cnter < CLKS_PER_BIT) begin
                    r_clk_cnter <= r_clk_cnter + 1'b1;
                end else begin
                    r_clk_cnter <= {CLK_CNTER_BW{1'b0}};
                end

            endcase
        end
    end

    always @ (posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            o_tx_done <= 1'b0;
            o_tx_busy <= 1'b0;
        end else begin
            o_tx_done <= stop_bit_end;  // tx done at the tail of stop bit
            o_tx_busy <= busy;
        end
    end

endmodule