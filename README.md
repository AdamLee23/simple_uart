# simple_uart
A simple UART transmitter and receiver implemented in Verilog.  
Data transmission includes a start bit, a configurable number of data bits, a single stop bit and no parity bit.  
Testbenches are also provided.  
All codes have been verified in VCS.  

Chisel does not currently support active low asynchronous reset. While we can do  
```scala
val reset_n = (!reset.asBool()).asAsyncReset()
  withReset(reset_n){
    io.out := RegNext(io.in, false.B)
  }
```
to implement one, I'm not going to do this here. Consequently, I did not do anything about the implicit reset signal, leading to a native active high synchronous reset in the generated verilog code.
