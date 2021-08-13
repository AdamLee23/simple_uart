import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import firrtl.options.TargetDirAnnotation

object VerilogGen extends App {
  (new ChiselStage).execute(
    Array("-X", "verilog", "--full-stacktrace"),
    Seq(ChiselGeneratorAnnotation(() => new UART_rx),
      TargetDirAnnotation("verilog_by_chisel"))
  )
}

