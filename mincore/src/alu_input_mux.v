`include "alu.vh"
`include "instruction.vh"
`include "register.vh"

module alu_input_mux(
  input wire [`ALU_INPUT_SEL_W-1:0] alu_input_sel,
  input wire [`REGISTER_DATA_W-1:0] rs,
  input wire [`INSTRUCTION_IMM_W-1:0] imm_i,
  input wire [`INSTRUCTION_IMM_W-1:0] imm_s,
  input wire [`INSTRUCTION_IMM_W-1:0] imm_b,
  input wire [`INSTRUCTION_IMM_W-1:0] imm_u,
  input wire [`INSTRUCTION_IMM_W-1:0] imm_j,
  input wire [`MEMORY_ADDR_W-1:0] pc,
  output reg [`REGISTER_DATA_W-1:0] alu_input
  );

  always @(*) begin
    case (alu_input_sel)
      `ALU_INPUT_SEL_REG: alu_input = rs;
      `ALU_INPUT_SEL_IMM_I: alu_input = imm_i;
      `ALU_INPUT_SEL_PC: alu_input = pc;
      `ALU_INPUT_SEL_IMM_U: alu_input = imm_u;
      `ALU_INPUT_SEL_ZERO: alu_input = 0;
      default: alu_input = 0;
    endcase
  end

endmodule
