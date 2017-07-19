`include "alu.vh"
`include "register.vh"

module alu(
  input [`ALU_OP_W-1:0] op,
  input [`REGISTER_DATA_W-1:0] in1,
  input [`REGISTER_DATA_W-1:0] in2,
  output reg[`REGISTER_DATA_W-1:0] out
  );

  wire [`ALU_SHIFT_W-1:0] shift;
  assign shift = in2[`ALU_SHIFT_W-1:0];

  always @(*) begin
    case (op)
      `ALU_OP_ADD: out = in1 + in2;
      `ALU_OP_SLT: out = {31'b0, $signed(in1) < $signed(in2)};
      `ALU_OP_SLTU: out = {31'b0, in1 < in2};
      `ALU_OP_XOR: out = in1 ^ in2;
      `ALU_OP_OR: out = in1 | in2;
      `ALU_OP_AND: out = in1 & in2;
      `ALU_OP_SLL: out = in1 << shift;
      `ALU_OP_SRL: out = in1 >> shift;
      `ALU_OP_SRA: out = $signed(in1) >>> shift;
      `ALU_OP_SUB: out = in1 - in2;
      // For conditional branches
      `ALU_OP_SEQ: out = {31'b0, in1 == in2};
      `ALU_OP_SNE: out = {31'b0, in1 != in2};
      `ALU_OP_SGE: out = {31'b0, $signed(in1) >= $signed(in2)};
      `ALU_OP_SGEU: out = {31'b0, in1 >= in2};
      default: out = 0;
    endcase
  end

endmodule
