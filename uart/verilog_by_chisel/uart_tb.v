//////////////////////////////////////////////////////////////
//  uart testbench
//
//  uart_tx.v as transmitter, uart_rx.v as reveicer
//  test data transmission
//////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module uart_tb;
    
    parameter BIT_RATE =        115200;     // bit rate in bit/s
    parameter CLK_FREQ_TX =     10_000_000; // tx clock frequency in Hz
    parameter CLK_FREQ_RX =     16_000_000; // rx_clock frequency in Hz
    parameter PAYLOAD_BITS =    8;          // number of bits to be transmitted

    parameter TTX = 100;    // tx clk period
    parameter TRX = 62.5;   // rx clk period

    reg clk_tx, clk_rx;
    reg reset_n_tx, reset_n_rx;
    reg i_tx_trig;
    reg [PAYLOAD_BITS-1:0] i_data;
    wire tx_done, rx_done;
    wire tx_busy;
    wire interface_data;
    wire [PAYLOAD_BITS-1:0] o_data;

    UART_tx #(BIT_RATE, CLK_FREQ_TX, PAYLOAD_BITS) u_uart_tx (
        .clock(clk_tx), .reset(reset_n_tx),
        .io_i_tx_trig(i_tx_trig),
        .io_i_data(i_data),
        .io_o_tx_busy(tx_busy),
        .io_o_tx_done(tx_done),
        .io_o_serial_data(interface_data)
    );

    UART_rx #(BIT_RATE, CLK_FREQ_RX, PAYLOAD_BITS) u_uart_rx (
        .clock(clk_rx), .reset(reset_n_rx),
        .io_i_serial_data(interface_data),
        .io_o_rx_done(rx_done),
        .io_o_data(o_data)
    );

    `ifdef VERDI_INSPECT
        initial begin
            $fsdbDumpfile("x.fsdb");
            $fsdbDumpvars;
        end
    `endif

    // Tx
    initial begin
        clk_tx = 1;
        reset_n_tx = 1;
        $display($time, "  simulation starts");

        #100.5 reset_n_tx = 0;
        $display($time, "  coming out of tx reset");

        // send 3 bytes consecutively
        send_data(8'hab);        
        send_data(8'hcd);        
        send_data(8'hef);        
    end

    // Rx
    initial begin
        clk_rx = 1;
        reset_n_rx = 1;
        $display($time, "  simulation starts");

        #63 reset_n_rx = 0;
        $display($time, "  coming out of rx reset");

        // wait for 3 bytes transmission done
        repeat(3) @(posedge rx_done);
        #500;

        $display($time, "  simulation completes");
        $finish;
    end

    task send_data;
        input [PAYLOAD_BITS-1:0] data;
        begin
            i_data = data;
            #TTX i_tx_trig = 1'b1;
            #TTX i_tx_trig = 1'b0;
            @(negedge tx_busy);
        end
    endtask

    // 10MHz tx clk
    always #50 clk_tx = ~clk_tx;
    // 16MHz rx clk
    always #31.25 clk_rx = ~clk_rx;

endmodule