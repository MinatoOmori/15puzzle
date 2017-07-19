`include "alu.vh"
`include "instruction.vh"
`include "pc.vh"

module mincore(
  input wire clk,
  input wire rst,
  output wire [`MEMORY_ADDR_W-1:0] imem_addr,
  input wire [`MEMORY_DATA_W-1:0] imem_rdata,
  output wire [`MEMORY_ADDR_W-1:0] dmem_addr,
  input wire [`MEMORY_DATA_W-1:0] dmem_rdata,
  output wire [`MEMORY_DATA_W-1:0] dmem_wdata,
  output wire dmem_wenable,
  output wire [`MEMORY_WRITE_TYP_W-1:0] dmem_write_typ
  );

  wire [`INSTRUCTION_OPCODE_W-1:0] opcode;
  wire [`INSTRUCTION_FUNCT3_W-1:0] funct3;
  wire [`INSTRUCTION_FUNCT7_W-1:0] funct7;
  wire [`ALU_OP_W-1:0] alu_op;
  wire [`ALU_INPUT_SEL_W-1:0] alu_input1_sel;
  wire [`ALU_INPUT_SEL_W-1:0] alu_input2_sel;
  wire [`REGISTER_WRITE_SEL_W-1:0] register_write_sel;
  wire register_wenable;
  wire [`REGISTER_DATA_W-1:0] alu_out;
  wire [`PC_OP_W-1:0] pc_op;
  wire [`MEMORY_ADDR_SEL_W-1:0] memory_addr_sel;
  wire [`MEMORY_WRAP_TYP_W-1:0] dmem_read_typ;

  control control(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .memory_addr_sel(memory_addr_sel),
    .dmem_wenable(dmem_wenable),
    .dmem_read_typ(dmem_read_typ),
    .dmem_write_typ(dmem_write_typ),
    .alu_op(alu_op),
    .alu_input1_sel(alu_input1_sel),
    .alu_input2_sel(alu_input2_sel),
    .register_write_sel(register_write_sel),
    .register_wenable(register_wenable),
    .alu_out(alu_out),
    .pc_op(pc_op)
    );

  data_path data_path(
    .clk(clk),
    .rst(rst),
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .imem_addr(imem_addr),
    .imem_rdata(imem_rdata),
    .dmem_addr(dmem_addr),
    .dmem_rdata(dmem_rdata),
    .dmem_wdata(dmem_wdata),
    .alu_op(alu_op),
    .alu_input1_sel(alu_input1_sel),
    .alu_input2_sel(alu_input2_sel),
    .register_write_sel(register_write_sel),
    .register_wenable(register_wenable),
    .alu_out(alu_out),
    .pc_op(pc_op),
    .memory_addr_sel(memory_addr_sel),
    .dmem_read_typ(dmem_read_typ)
    );

endmodule
