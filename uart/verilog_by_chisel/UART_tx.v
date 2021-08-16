module UART_tx(
  input        clock,
  input        reset,
  input        io_i_tx_trig,
  input  [7:0] io_i_data,
  output       io_o_tx_busy,
  output       io_o_tx_done,
  output       io_o_serial_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] clkCnterReg; // @[UART_tx.scala 25:28]
  reg [3:0] bitCnterReg; // @[UART_tx.scala 26:28]
  reg [7:0] inDataReg; // @[UART_tx.scala 28:26]
  reg  outDataReg; // @[UART_tx.scala 29:27]
  reg  outTxBusyReg; // @[UART_tx.scala 30:29]
  reg  outTxDoneReg; // @[UART_tx.scala 31:29]
  reg [1:0] stateReg; // @[UART_tx.scala 32:25]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _GEN_0 = io_i_tx_trig ? 1'h0 : outDataReg; // @[UART_tx.scala 46:38 UART_tx.scala 47:20 UART_tx.scala 29:27]
  wire  _T_2 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_3 = clkCnterReg < 8'h56; // @[UART_tx.scala 56:25]
  wire [7:0] _clkCnterReg_T_1 = clkCnterReg + 8'h1; // @[UART_tx.scala 57:36]
  wire [3:0] _bitCnterReg_T_1 = bitCnterReg + 4'h1; // @[UART_tx.scala 61:36]
  wire [7:0] _outDataReg_T = inDataReg >> bitCnterReg; // @[UART_tx.scala 63:32]
  wire [7:0] _GEN_3 = clkCnterReg < 8'h56 ? _clkCnterReg_T_1 : 8'h0; // @[UART_tx.scala 56:41 UART_tx.scala 57:21 UART_tx.scala 60:21]
  wire  _GEN_6 = clkCnterReg < 8'h56 ? outDataReg : _outDataReg_T[0]; // @[UART_tx.scala 56:41 UART_tx.scala 29:27 UART_tx.scala 63:20]
  wire  _T_4 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _GEN_7 = bitCnterReg < 4'h8 ? _outDataReg_T[0] : 1'h1; // @[UART_tx.scala 73:44 UART_tx.scala 75:22 UART_tx.scala 81:22]
  wire [3:0] _GEN_8 = bitCnterReg < 4'h8 ? _bitCnterReg_T_1 : 4'h0; // @[UART_tx.scala 73:44 UART_tx.scala 76:23 UART_tx.scala 79:23]
  wire [1:0] _GEN_9 = bitCnterReg < 4'h8 ? 2'h2 : 2'h3; // @[UART_tx.scala 73:44 UART_tx.scala 77:20 UART_tx.scala 82:20]
  wire [1:0] _GEN_11 = _T_3 ? 2'h2 : _GEN_9; // @[UART_tx.scala 68:41 UART_tx.scala 70:18]
  wire  _GEN_12 = _T_3 ? outDataReg : _GEN_7; // @[UART_tx.scala 68:41 UART_tx.scala 29:27]
  wire [3:0] _GEN_13 = _T_3 ? bitCnterReg : _GEN_8; // @[UART_tx.scala 68:41 UART_tx.scala 26:28]
  wire  _T_7 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_15 = _T_3 ? 2'h3 : 2'h0; // @[UART_tx.scala 87:41 UART_tx.scala 89:18 UART_tx.scala 93:18]
  wire  _GEN_16 = _T_3 ? outTxDoneReg : 1'h1; // @[UART_tx.scala 87:41 UART_tx.scala 31:29 UART_tx.scala 92:22]
  wire [7:0] _GEN_17 = _T_7 ? _GEN_3 : clkCnterReg; // @[Conditional.scala 39:67 UART_tx.scala 25:28]
  wire [1:0] _GEN_18 = _T_7 ? _GEN_15 : stateReg; // @[Conditional.scala 39:67 UART_tx.scala 32:25]
  wire  _GEN_19 = _T_7 ? _GEN_16 : outTxDoneReg; // @[Conditional.scala 39:67 UART_tx.scala 31:29]
  wire  _GEN_22 = _T_4 ? _GEN_12 : outDataReg; // @[Conditional.scala 39:67 UART_tx.scala 29:27]
  wire  _GEN_28 = _T_2 ? _GEN_6 : _GEN_22; // @[Conditional.scala 39:67]
  wire  _GEN_33 = _T ? _GEN_0 : _GEN_28; // @[Conditional.scala 40:58]
  assign io_o_tx_busy = outTxBusyReg; // @[UART_tx.scala 35:16]
  assign io_o_tx_done = outTxDoneReg; // @[UART_tx.scala 36:16]
  assign io_o_serial_data = outDataReg; // @[UART_tx.scala 34:20]
  always @(posedge clock) begin
    if (reset) begin // @[UART_tx.scala 25:28]
      clkCnterReg <= 8'h0; // @[UART_tx.scala 25:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      clkCnterReg <= 8'h0; // @[UART_tx.scala 43:19]
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      clkCnterReg <= _GEN_3;
    end else if (_T_4) begin // @[Conditional.scala 39:67]
      clkCnterReg <= _GEN_3;
    end else begin
      clkCnterReg <= _GEN_17;
    end
    if (reset) begin // @[UART_tx.scala 26:28]
      bitCnterReg <= 4'h0; // @[UART_tx.scala 26:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      bitCnterReg <= 4'h0; // @[UART_tx.scala 44:19]
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (!(clkCnterReg < 8'h56)) begin // @[UART_tx.scala 56:41]
        bitCnterReg <= _bitCnterReg_T_1; // @[UART_tx.scala 61:21]
      end
    end else if (_T_4) begin // @[Conditional.scala 39:67]
      bitCnterReg <= _GEN_13;
    end
    if (reset) begin // @[UART_tx.scala 28:26]
      inDataReg <= 8'h0; // @[UART_tx.scala 28:26]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_i_tx_trig) begin // @[UART_tx.scala 46:38]
        inDataReg <= io_i_data; // @[UART_tx.scala 49:19]
      end
    end
    outDataReg <= reset | _GEN_33; // @[UART_tx.scala 29:27 UART_tx.scala 29:27]
    if (reset) begin // @[UART_tx.scala 30:29]
      outTxBusyReg <= 1'h0; // @[UART_tx.scala 30:29]
    end else begin
      outTxBusyReg <= stateReg != 2'h0; // @[UART_tx.scala 37:16]
    end
    if (reset) begin // @[UART_tx.scala 31:29]
      outTxDoneReg <= 1'h0; // @[UART_tx.scala 31:29]
    end else if (_T) begin // @[Conditional.scala 40:58]
      outTxDoneReg <= 1'h0; // @[UART_tx.scala 41:20]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (!(_T_4)) begin // @[Conditional.scala 39:67]
        outTxDoneReg <= _GEN_19;
      end
    end
    if (reset) begin // @[UART_tx.scala 32:25]
      stateReg <= 2'h0; // @[UART_tx.scala 32:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_i_tx_trig) begin // @[UART_tx.scala 46:38]
        stateReg <= 2'h1; // @[UART_tx.scala 50:18]
      end else begin
        stateReg <= 2'h0; // @[UART_tx.scala 52:18]
      end
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (clkCnterReg < 8'h56) begin // @[UART_tx.scala 56:41]
        stateReg <= 2'h1; // @[UART_tx.scala 58:18]
      end else begin
        stateReg <= 2'h2; // @[UART_tx.scala 64:18]
      end
    end else if (_T_4) begin // @[Conditional.scala 39:67]
      stateReg <= _GEN_11;
    end else begin
      stateReg <= _GEN_18;
    end
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
  clkCnterReg = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  bitCnterReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  inDataReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  outDataReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  outTxBusyReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  outTxDoneReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stateReg = _RAND_6[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
