# simple_uart
A simple UART transmitter and receiver implemented in Verilog and Chisel.  
In this simple UART implementation, data stream includes a start bit, a configurable number of data bits, a single stop bit and no parity bit. Critical files are organized as follows:
- Verilog files are located at /verilog folder, where a UART transmitter and receiver, with their respective testbench plus an additional testbench for testing a UART system with an Rx and a Tx instantiated and interconnected, are implemented in Verilog code.  
- Chisel files are located at /uart folder. A UART transmitter and receiver, essentially designed in the same way as the Verilog version of the Tx and Rx, located at /uart/src/main/scala, are implemented in Chisel. The file VerilogGen.scala are used to generate Verilog code from Chisel code. The Verilog UART Tx and Rx generated from Chisel are located at /uart/verilog_by_chisel, where testbenches are also provided.
The Verilog files, written manually and generated automatically from Chisel, have all been verified in VCS through behavioral simulation using testbenches provided.  

I implemented active low asynchronous reset in the Verilog files. However, Chisel does not currently support active low asynchronous reset. While I can do  
```scala
val reset_n = (!reset.asBool()).asAsyncReset()
  withReset(reset_n){
    // sequential circuits with active low async reset
  }
```
to implement one, I intend not to do this here. Consequently, I did not do anything about the implicit reset signal, leading to a native active high synchronous reset in the verilog code generated from Chisel.  
  
For implementation elaboration, see <https://zhuanlan.zhihu.com/p/398783022>
