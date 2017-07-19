`include "register.vh"

module register_write_mux(
  input wire [`REGISTER_WRITE_SEL_W-1:0] sel,
  input wire [`REGISTER_DATA_W-1:0] alu_out,
  input wire [`MEMORY_ADDR_W-1:0] link_pc,
  input wire [`MEMORY_DATA_W-1:0] memory_out,
  output reg [`REGISTER_DATA_W-1:0] register_wdata
  );

  always @(*) begin
    case (sel)
      `REGISTER_WRITE_SEL_ALU_OUT: register_wdata = alu_out;
      `REGISTER_WRITE_SEL_PC: register_wdata = link_pc;
      `REGISTER_WRITE_SEL_DMEM: register_wdata = memory_out;
      default: register_wdata = 0;
    endcase
  end

endmodule
