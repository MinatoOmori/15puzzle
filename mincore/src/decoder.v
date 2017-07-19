`include "instruction.vh"

module decoder(
  input wire [`MEMORY_DATA_W-1:0] imem_rdata,
  output wire [`INSTRUCTION_OPCODE_W-1:0] opcode,
  output wire [`REGISTER_ADDR_W-1:0] rd,
  output wire [`INSTRUCTION_FUNCT3_W-1:0] funct3,
  output wire [`REGISTER_ADDR_W-1:0] rs1,
  output wire [`REGISTER_ADDR_W-1:0] rs2,
  output wire [`INSTRUCTION_FUNCT7_W-1:0] funct7,
  output wire [`INSTRUCTION_IMM_W-1:0] imm_i,
  output wire [`INSTRUCTION_IMM_W-1:0] imm_s,
  output wire [`INSTRUCTION_IMM_W-1:0] imm_b,
  output wire [`INSTRUCTION_IMM_W-1:0] imm_u,
  output wire [`INSTRUCTION_IMM_W-1:0] imm_j
  );

  // Supports rv32 like instruction formats

  assign {funct7, rs2, rs1, funct3, rd, opcode} = imem_rdata;

  assign imm_i = {{20{imem_rdata[31]}}, imem_rdata[31:20]};
  assign imm_s = {{20{imem_rdata[31]}}, imem_rdata[31:25], imem_rdata[11:7]};
  assign imm_b = {{20{imem_rdata[31]}}, imem_rdata[7], imem_rdata[30:25], imem_rdata[11:8], 1'b0};
  assign imm_u = {imem_rdata[31:12], 12'b0};
  assign imm_j = {{12{imem_rdata[31]}}, imem_rdata[19:12], imem_rdata[20], imem_rdata[30:21], 1'b0};

endmodule
