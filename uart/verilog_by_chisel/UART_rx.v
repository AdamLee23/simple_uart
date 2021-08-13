module UART_rx(
  input        clock,
  input        reset,
  input        io_i_serial_data,
  output       io_o_rx_done,
  output [7:0] io_o_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [8:0] clkCnterReg; // @[UART_rx.scala 25:28]
  reg [3:0] bitCnterReg; // @[UART_rx.scala 26:28]
  reg  outDataReg_0; // @[UART_rx.scala 28:27]
  reg  outDataReg_1; // @[UART_rx.scala 28:27]
  reg  outDataReg_2; // @[UART_rx.scala 28:27]
  reg  outDataReg_3; // @[UART_rx.scala 28:27]
  reg  outDataReg_4; // @[UART_rx.scala 28:27]
  reg  outDataReg_5; // @[UART_rx.scala 28:27]
  reg  outDataReg_6; // @[UART_rx.scala 28:27]
  reg  outDataReg_7; // @[UART_rx.scala 28:27]
  reg  outRxDoneReg; // @[UART_rx.scala 29:29]
  reg [1:0] stateReg; // @[UART_rx.scala 30:25]
  reg  serialDataReg_REG; // @[UART_rx.scala 33:38]
  reg  serialDataReg; // @[UART_rx.scala 33:30]
  wire [3:0] io_o_data_lo = {outDataReg_3,outDataReg_2,outDataReg_1,outDataReg_0}; // @[Cat.scala 30:58]
  wire [3:0] io_o_data_hi = {outDataReg_7,outDataReg_6,outDataReg_5,outDataReg_4}; // @[Cat.scala 30:58]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = ~serialDataReg; // @[UART_rx.scala 45:27]
  wire  _T_2 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire [8:0] _clkCnterReg_T_1 = clkCnterReg + 9'h1; // @[UART_rx.scala 53:36]
  wire [1:0] _GEN_1 = _T_1 ? 2'h2 : 2'h0; // @[UART_rx.scala 58:42 UART_rx.scala 59:20 UART_rx.scala 62:20]
  wire  _T_5 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_6 = clkCnterReg < 9'h8a; // @[UART_rx.scala 67:25]
  wire  _GEN_4 = 3'h0 == bitCnterReg[2:0] ? serialDataReg : outDataReg_0; // @[UART_rx.scala 73:33 UART_rx.scala 73:33 UART_rx.scala 28:27]
  wire  _GEN_5 = 3'h1 == bitCnterReg[2:0] ? serialDataReg : outDataReg_1; // @[UART_rx.scala 73:33 UART_rx.scala 73:33 UART_rx.scala 28:27]
  wire  _GEN_6 = 3'h2 == bitCnterReg[2:0] ? serialDataReg : outDataReg_2; // @[UART_rx.scala 73:33 UART_rx.scala 73:33 UART_rx.scala 28:27]
  wire  _GEN_7 = 3'h3 == bitCnterReg[2:0] ? serialDataReg : outDataReg_3; // @[UART_rx.scala 73:33 UART_rx.scala 73:33 UART_rx.scala 28:27]
  wire  _GEN_8 = 3'h4 == bitCnterReg[2:0] ? serialDataReg : outDataReg_4; // @[UART_rx.scala 73:33 UART_rx.scala 73:33 UART_rx.scala 28:27]
  wire  _GEN_9 = 3'h5 == bitCnterReg[2:0] ? serialDataReg : outDataReg_5; // @[UART_rx.scala 73:33 UART_rx.scala 73:33 UART_rx.scala 28:27]
  wire  _GEN_10 = 3'h6 == bitCnterReg[2:0] ? serialDataReg : outDataReg_6; // @[UART_rx.scala 73:33 UART_rx.scala 73:33 UART_rx.scala 28:27]
  wire  _GEN_11 = 3'h7 == bitCnterReg[2:0] ? serialDataReg : outDataReg_7; // @[UART_rx.scala 73:33 UART_rx.scala 73:33 UART_rx.scala 28:27]
  wire [3:0] _bitCnterReg_T_1 = bitCnterReg + 4'h1; // @[UART_rx.scala 75:38]
  wire [3:0] _GEN_12 = bitCnterReg < 4'h8 ? _bitCnterReg_T_1 : 4'h0; // @[UART_rx.scala 74:44 UART_rx.scala 75:23 UART_rx.scala 77:23]
  wire [8:0] _GEN_13 = clkCnterReg < 9'h8a ? _clkCnterReg_T_1 : 9'h0; // @[UART_rx.scala 67:41 UART_rx.scala 68:21 UART_rx.scala 70:21]
  wire  _GEN_14 = clkCnterReg < 9'h8a ? outDataReg_0 : _GEN_4; // @[UART_rx.scala 67:41 UART_rx.scala 28:27]
  wire  _GEN_15 = clkCnterReg < 9'h8a ? outDataReg_1 : _GEN_5; // @[UART_rx.scala 67:41 UART_rx.scala 28:27]
  wire  _GEN_16 = clkCnterReg < 9'h8a ? outDataReg_2 : _GEN_6; // @[UART_rx.scala 67:41 UART_rx.scala 28:27]
  wire  _GEN_17 = clkCnterReg < 9'h8a ? outDataReg_3 : _GEN_7; // @[UART_rx.scala 67:41 UART_rx.scala 28:27]
  wire  _GEN_18 = clkCnterReg < 9'h8a ? outDataReg_4 : _GEN_8; // @[UART_rx.scala 67:41 UART_rx.scala 28:27]
  wire  _GEN_19 = clkCnterReg < 9'h8a ? outDataReg_5 : _GEN_9; // @[UART_rx.scala 67:41 UART_rx.scala 28:27]
  wire  _GEN_20 = clkCnterReg < 9'h8a ? outDataReg_6 : _GEN_10; // @[UART_rx.scala 67:41 UART_rx.scala 28:27]
  wire  _GEN_21 = clkCnterReg < 9'h8a ? outDataReg_7 : _GEN_11; // @[UART_rx.scala 67:41 UART_rx.scala 28:27]
  wire [3:0] _GEN_22 = clkCnterReg < 9'h8a ? bitCnterReg : _GEN_12; // @[UART_rx.scala 67:41 UART_rx.scala 26:28]
  wire [1:0] _GEN_23 = bitCnterReg == 4'h8 ? 2'h3 : 2'h2; // @[UART_rx.scala 80:44 UART_rx.scala 81:18 UART_rx.scala 83:18]
  wire  _T_10 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_25 = _T_6 ? 2'h3 : 2'h0; // @[UART_rx.scala 87:41 UART_rx.scala 89:18 UART_rx.scala 94:18]
  wire  _GEN_26 = _T_6 ? outRxDoneReg : 1'h1; // @[UART_rx.scala 87:41 UART_rx.scala 29:29 UART_rx.scala 93:22]
  wire [8:0] _GEN_27 = _T_10 ? _GEN_13 : clkCnterReg; // @[Conditional.scala 39:67 UART_rx.scala 25:28]
  wire [1:0] _GEN_28 = _T_10 ? _GEN_25 : stateReg; // @[Conditional.scala 39:67 UART_rx.scala 30:25]
  wire  _GEN_29 = _T_10 ? _GEN_26 : outRxDoneReg; // @[Conditional.scala 39:67 UART_rx.scala 29:29]
  assign io_o_rx_done = outRxDoneReg; // @[UART_rx.scala 36:16]
  assign io_o_data = {io_o_data_hi,io_o_data_lo}; // @[Cat.scala 30:58]
  always @(posedge clock) begin
    if (reset) begin // @[UART_rx.scala 25:28]
      clkCnterReg <= 9'h0; // @[UART_rx.scala 25:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      clkCnterReg <= 9'h0; // @[UART_rx.scala 42:19]
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (clkCnterReg < 9'h45) begin // @[UART_rx.scala 52:47]
        clkCnterReg <= _clkCnterReg_T_1; // @[UART_rx.scala 53:21]
      end else begin
        clkCnterReg <= 9'h0; // @[UART_rx.scala 57:21]
      end
    end else if (_T_5) begin // @[Conditional.scala 39:67]
      clkCnterReg <= _GEN_13;
    end else begin
      clkCnterReg <= _GEN_27;
    end
    if (reset) begin // @[UART_rx.scala 26:28]
      bitCnterReg <= 4'h0; // @[UART_rx.scala 26:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      bitCnterReg <= 4'h0; // @[UART_rx.scala 43:19]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (_T_5) begin // @[Conditional.scala 39:67]
        bitCnterReg <= _GEN_22;
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_0 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_5) begin // @[Conditional.scala 39:67]
          outDataReg_0 <= _GEN_14;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_1 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_5) begin // @[Conditional.scala 39:67]
          outDataReg_1 <= _GEN_15;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_2 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_5) begin // @[Conditional.scala 39:67]
          outDataReg_2 <= _GEN_16;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_3 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_5) begin // @[Conditional.scala 39:67]
          outDataReg_3 <= _GEN_17;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_4 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_5) begin // @[Conditional.scala 39:67]
          outDataReg_4 <= _GEN_18;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_5 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_5) begin // @[Conditional.scala 39:67]
          outDataReg_5 <= _GEN_19;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_6 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_5) begin // @[Conditional.scala 39:67]
          outDataReg_6 <= _GEN_20;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_7 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_5) begin // @[Conditional.scala 39:67]
          outDataReg_7 <= _GEN_21;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 29:29]
      outRxDoneReg <= 1'h0; // @[UART_rx.scala 29:29]
    end else if (_T) begin // @[Conditional.scala 40:58]
      outRxDoneReg <= 1'h0; // @[UART_rx.scala 40:20]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (!(_T_5)) begin // @[Conditional.scala 39:67]
        outRxDoneReg <= _GEN_29;
      end
    end
    if (reset) begin // @[UART_rx.scala 30:25]
      stateReg <= 2'h0; // @[UART_rx.scala 30:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (~serialDataReg) begin // @[UART_rx.scala 45:40]
        stateReg <= 2'h1; // @[UART_rx.scala 46:18]
      end else begin
        stateReg <= 2'h0; // @[UART_rx.scala 48:18]
      end
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (clkCnterReg < 9'h45) begin // @[UART_rx.scala 52:47]
        stateReg <= 2'h1; // @[UART_rx.scala 54:18]
      end else begin
        stateReg <= _GEN_1;
      end
    end else if (_T_5) begin // @[Conditional.scala 39:67]
      stateReg <= _GEN_23;
    end else begin
      stateReg <= _GEN_28;
    end
    serialDataReg_REG <= io_i_serial_data; // @[UART_rx.scala 33:38]
    serialDataReg <= serialDataReg_REG; // @[UART_rx.scala 33:30]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  clkCnterReg = _RAND_0[8:0];
  _RAND_1 = {1{`RANDOM}};
  bitCnterReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  outDataReg_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  outDataReg_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  outDataReg_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  outDataReg_3 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  outDataReg_4 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  outDataReg_5 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  outDataReg_6 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  outDataReg_7 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  outRxDoneReg = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  stateReg = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  serialDataReg_REG = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  serialDataReg = _RAND_13[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
