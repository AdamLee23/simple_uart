////////////////////////////////////////////////////////////////////////
//  UART receiver
//
//  o_rx_done set 1 for 1 cycle when all bits are received
//  async active low reset_n
////////////////////////////////////////////////////////////////////////

module uart_rx #(
    parameter BIT_RATE =        115200,         // bit rate in bit/s
    parameter CLK_FREQ =        10_000_000,     // clock frequency in Hz
    parameter PAYLOAD_BITS =    8               // number of bits to be transmitted
) ( 
    input                           clk,
    input                           reset_n,
    input                           i_serial_data,
    output  reg                     o_rx_done,
    output  reg [PAYLOAD_BITS-1:0]  o_data
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
    
    // synchronizer
    reg r_serial_data_0;
    reg r_serial_data;

    reg [1:0]  r_state;
    reg [1:0]  r_next_state;

    reg start_bit_mid;  // are we at the middle of the start bit?
    reg data_bit_mid;   // are we at the middle of a data bit?
    reg stop_bit_mid;   // are we at the middle of the stop bit?

    // fsm next state logic
    always @ (*) begin
        r_next_state = IDLE;
        case (r_state)

            IDLE: if (r_serial_data == 1'b0) begin 
                r_next_state = START_BIT;   // data bit low detected, go to START_BIT
            end else begin
                r_next_state = IDLE;
            end

            START_BIT: if (start_bit_mid == 1'b1) begin
                // check if r_serial_data is still 1'b0; if not, treat as noise and return to IDLE
                if (r_serial_data == 1'b0) begin
                    r_next_state = DATA_BITS;
                end else begin
                    r_next_state = IDLE;
                end
            end else begin
                r_next_state = START_BIT;
            end

            DATA_BITS: if (r_bit_cnter == PAYLOAD_BITS) begin
                r_next_state = STOP_BIT;    // all bits are transmitted, go to STOP_BIT
            end else begin
                r_next_state = DATA_BITS;
            end

            STOP_BIT: begin
                if (stop_bit_mid == 1'b1) begin
                    r_next_state = IDLE;    // we are at the middle of stop bit, transmission completed
                end else begin
                    r_next_state = STOP_BIT;
                end
            end 

        endcase
    end

    // fsm output logic
    always @ (*) begin
        start_bit_mid = 1'b0;
        data_bit_mid =  1'b0;
        stop_bit_mid =  1'b0;
        case (r_state)

            START_BIT: begin
                start_bit_mid = r_clk_cnter == CLKS_PER_BIT / 2;
            end

            DATA_BITS: begin
                data_bit_mid =  r_clk_cnter == CLKS_PER_BIT;
            end

            STOP_BIT: begin
                stop_bit_mid =  r_clk_cnter == CLKS_PER_BIT;
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

    // input serial data synchronized to clk domain
    always @ (posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            r_serial_data_0 <= 1'b0;
            r_serial_data <= 1'b0;
        end else begin
            r_serial_data_0 <= i_serial_data;
            r_serial_data <= r_serial_data_0;
        end
    end

    // grab data bit when in middle of data bit
    always @ (posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            o_data <= {PAYLOAD_BITS{1'b0}};
        end else if (data_bit_mid == 1'b1) begin
            o_data[r_bit_cnter] <= r_serial_data;
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
                    // disable counters when in IDLE
                    r_clk_cnter <= {CLK_CNTER_BW{1'b0}};
                    r_bit_cnter <= {BIT_CNTER_BW{1'b0}};
                end

                // r_clk_cnter counting from 0 to CLKS_PER_BIT / 2
                START_BIT: if (r_clk_cnter < CLKS_PER_BIT / 2) begin
                    r_clk_cnter <= r_clk_cnter + 1'b1;
                end else begin
                    r_clk_cnter <= {CLK_CNTER_BW{1'b0}};
                end

                DATA_BITS: begin
                    // r_clk_cnter counting from 0 to CLKS_PER_BIT
                    if (r_clk_cnter < CLKS_PER_BIT) begin
                        r_clk_cnter <= r_clk_cnter + 1'b1;
                    end else begin
                        r_clk_cnter <= {CLK_CNTER_BW{1'b0}};
                    end
                    // at the middle of each data bit, r_bit_cnter adds 1. until PAYLOAD_BITS
                    if (data_bit_mid == 1'b1) begin
                        if (r_bit_cnter < PAYLOAD_BITS) begin
                            r_bit_cnter <= r_bit_cnter + 1'b1;
                        end else begin
                            r_bit_cnter <= {BIT_CNTER_BW{1'b0}};
                        end
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

    // when at the middle of stop bit, rx done
    always @ (posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            o_rx_done <= 1'b0;
        end else begin
            o_rx_done <= stop_bit_mid;
        end
    end

endmodule