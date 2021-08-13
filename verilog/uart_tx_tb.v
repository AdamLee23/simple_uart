`timescale 1ns / 1ps

module uart_tx_tb();
    
    parameter BIT_RATE =        115200;         // bit rate in bit/s
    parameter CLK_FREQ =        10_000_000;     // clock frequency in Hz
    parameter PAYLOAD_BITS =    8;              // number of bits to be transmitted

    real BIT_RATE_REAL = BIT_RATE;
    real BIT_RATE_P = 1_000_000_000 * 1 / BIT_RATE_REAL;   // bit rate period in nanoseconds
    real WAIT_TIME = BIT_RATE_P * (2 + PAYLOAD_BITS);

    reg clk, reset_n;
    reg i_tx_trig;
    reg [PAYLOAD_BITS-1:0] i_data;
    wire o_tx_busy, o_tx_done;
    wire o_serial_data;

    uart_tx #(BIT_RATE, CLK_FREQ, PAYLOAD_BITS) u_uart_tx (
        .clk(clk), .reset_n(reset_n),
        .i_tx_trig(i_tx_trig),
        .i_data(i_data),
        .o_tx_busy(o_tx_busy),
        .o_tx_done(o_tx_done),
        .o_serial_data(o_serial_data)
    );

    initial begin
         clk = 1;
         reset_n = 0;
         i_tx_trig = 1'b0;
         #100.05 reset_n = 1;

        send_data(8'b0101_0101);
        send_data(8'b1001_1001);

        $finish;
    end

    task send_data;
        input [7:0] data;
        begin
            i_data = data;
            #100 i_tx_trig = 1'b1;
            fork
                #100 i_tx_trig = 1'b0;
                #WAIT_TIME;
            join
            #500;
        end
    endtask

    `ifdef VERDI_INSPECT
        initial begin
            $fsdbDumpfile("x.fsdb");
            $fsdbDumpvars;
        end
    `endif  

    // 10MHz clk
    always #50 clk = ~clk;

endmodule