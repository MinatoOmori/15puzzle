`include "memory.vh"
`include "register.vh"
`include "instruction.vh"
`include "pc.vh"

module data_path(
  input wire clk,
  input wire rst,
  output wire [`MEMORY_ADDR_W-1:0] imem_addr,
  input wire [`MEMORY_DATA_W-1:0] imem_rdata,
  output wire [`MEMORY_ADDR_W-1:0] dmem_addr,
  input wire [`MEMORY_DATA_W-1:0] dmem_rdata,
  output wire [`MEMORY_DATA_W-1:0] dmem_wdata,
  input wire [`ALU_OP_W-1:0] alu_op,
  input wire [`ALU_INPUT_SEL_W-1:0] alu_input1_sel,
  input wire [`ALU_INPUT_SEL_W-1:0] alu_input2_sel,
  output wire [`INSTRUCTION_OPCODE_W-1:0] opcode,
  output wire [`INSTRUCTION_FUNCT3_W-1:0] funct3,
  output wire [`INSTRUCTION_FUNCT7_W-1:0] funct7,
  input wire [`REGISTER_WRITE_SEL_W-1:0] register_write_sel,
  input wire register_wenable,
  output wire [`REGISTER_DATA_W-1:0] alu_out,
  input wire [`PC_OP_W-1:0] pc_op,
  input wire [`MEMORY_ADDR_SEL_W-1:0] memory_addr_sel,
  input wire [`MEMORY_WRAP_TYP_W-1:0] dmem_read_typ
  );

  reg [`MEMORY_ADDR_W-1:0] pc;
  assign imem_addr = pc;

  wire [`INSTRUCTION_IMM_W-1:0] imm_i;
  wire [`INSTRUCTION_IMM_W-1:0] imm_s;
  wire [`INSTRUCTION_IMM_W-1:0] imm_b;
  wire [`INSTRUCTION_IMM_W-1:0] imm_u;
  wire [`INSTRUCTION_IMM_W-1:0] imm_j;

  wire [`REGISTER_ADDR_W-1:0] register_raddr1;
  wire [`REGISTER_DATA_W-1:0] register_rdata1;
  wire [`REGISTER_ADDR_W-1:0] register_raddr2;
  wire [`REGISTER_DATA_W-1:0] register_rdata2;
  wire [`REGISTER_ADDR_W-1:0] register_waddr;
  wire [`REGISTER_DATA_W-1:0] register_wdata;

  wire [`REGISTER_DATA_W-1:0] alu_in1;
  wire [`REGISTER_DATA_W-1:0] alu_in2;

  wire [`MEMORY_ADDR_W-1:0] link_pc;
  wire [`MEMORY_ADDR_W-1:0] next_pc;

  wire [`MEMORY_DATA_W-1:0] read_memory_wrap_out;

  decoder decoder(
    .imem_rdata(imem_rdata),
    .opcode(opcode),
    .rd(register_waddr),
    .funct3(funct3),
    .rs1(register_raddr1),
    .rs2(register_raddr2),
    .funct7(funct7),
    .imm_i(imm_i),
    .imm_s(imm_s),
    .imm_b(imm_b),
    .imm_u(imm_u),
    .imm_j(imm_j)
    );

  register_file register_file(
    .clk(clk),
    .raddr1(register_raddr1),
    .rdata1(register_rdata1),
    .raddr2(register_raddr2),
    .rdata2(register_rdata2),
    .wenable(register_wenable),
    .waddr(register_waddr),
    .wdata(register_wdata)
    );

  alu_input_mux alu_input1_mux(
    .alu_input_sel(alu_input1_sel),
    .rs(register_rdata1),
    .imm_i(imm_i),
    .imm_s(imm_s),
    .imm_b(imm_b),
    .imm_u(imm_u),
    .imm_j(imm_j),
    .pc(pc),
    .alu_input(alu_in1)
    );

  alu_input_mux alu_input2_mux(
    .alu_input_sel(alu_input2_sel),
    .rs(register_rdata2),
    .imm_i(imm_i),
    .imm_s(imm_s),
    .imm_b(imm_b),
    .imm_u(imm_u),
    .imm_j(imm_j),
    .pc(pc),
    .alu_input(alu_in2)
    );

  alu alu(
    .op(alu_op),
    .in1(alu_in1),
    .in2(alu_in2),
    .out(alu_out)
    );

  memory_addr_mux memory_addr_mux(
    .sel(memory_addr_sel),
    .register_rdata1(register_rdata1),
    .imm_i(imm_i),
    .imm_s(imm_s),
    .out(dmem_addr)
    );

  memory_wrap read_memory_wrap(
    .typ(dmem_read_typ),
    .in(dmem_rdata),
    .out(read_memory_wrap_out)
    );

  assign dmem_wdata = register_rdata2;

  register_write_mux register_write_mux(
    .sel(register_write_sel),
    .alu_out(alu_out),
    .link_pc(link_pc),
    .memory_out(read_memory_wrap_out),
    .register_wdata(register_wdata)
    );

  program_counter_mux program_counter_mux(
    .op(pc_op),
    .pc(pc),
    .rs1(register_rdata1),
    .imm_i(imm_i),
    .imm_b(imm_b),
    .imm_j(imm_j),
    .link_pc(link_pc),
    .next_pc(next_pc)
    );

  always @(posedge clk) begin
    if (rst)
      pc <= `MEMORY_ADDR_W'h0;
    else
      pc <= next_pc;
  end

endmodule
