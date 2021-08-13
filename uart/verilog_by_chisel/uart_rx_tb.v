`timescale 1ns / 1ps

module uart_rx_tb();
    
    parameter BIT_RATE =        115200;         // bit rate in bit/s
    parameter CLK_FREQ =        16_000_000;     // clock frequency in Hz
    parameter PAYLOAD_BITS =    8;              // number of bits to be transmitted

    integer i;
    real BIT_RATE_REAL = BIT_RATE;
    real BIT_RATE_P = 1_000_000_000 * 1 / BIT_RATE_REAL;   // bit rate period in nanoseconds

    reg clk, reset;
    reg i_serial_data;
    wire o_rx_done;
    wire [PAYLOAD_BITS-1:0] o_data;

    UART_rx #(BIT_RATE, CLK_FREQ, PAYLOAD_BITS) u_uart_rx (
        .clock(clk), .reset(reset),
        .io_i_serial_data(i_serial_data),
        .io_o_rx_done(o_rx_done),
        .io_o_data(o_data)
    );

    initial begin
         clk = 1;
         reset = 1;
         #63 reset = 0;

        i_serial_data = 1'b1;
        #125;
        send_8_bits(8'b0001_0110);  // 8'h16
        send_8_bits(8'b0011_0010);  // 8'h32
        send_8_bits(8'b1010_1111);  // 8'haf

        $finish;
    end

    task send_8_bits;
        input [7:0] data;
        begin
            i_serial_data = 1'b0;
            for (i=0; i<8; i=i+1) begin
                #BIT_RATE_P i_serial_data = data[i];
            end
            #BIT_RATE_P i_serial_data = 1'b1;
            #BIT_RATE_P;
        end
    endtask

    `ifdef VERDI_INSPECT
        initial begin
            $fsdbDumpfile("x.fsdb");
            $fsdbDumpvars;
        end
    `endif  

    // 16MHz clk
    always #31.25 clk = ~clk;

endmodule