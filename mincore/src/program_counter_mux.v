`include "pc.vh"
`include "register.vh"
`include "instruction.vh"

module program_counter_mux(
  input wire [`PC_OP_W-1:0] op,
  input wire [`MEMORY_ADDR_W-1:0] pc,
  input wire [`REGISTER_DATA_W-1:0] rs1,
  input wire [`MEMORY_ADDR_W-1:0] imm_i,
  input wire [`MEMORY_ADDR_W-1:0] imm_b,
  input wire [`MEMORY_ADDR_W-1:0] imm_j,
  output wire [`MEMORY_ADDR_W-1:0] link_pc,
  output wire [`MEMORY_ADDR_W-1:0] next_pc
  );

  reg [`MEMORY_ADDR_W-1:0] base;
  reg [`MEMORY_ADDR_W-1:0] offset;

  always @(*) begin
    case (op)
      `PC_OP_JAL: begin
        base = pc;
        offset = imm_j;
      end
      `PC_OP_JALR: begin
        base = rs1;
        offset = imm_i;
        base[0] = 0;
        offset[0] = 0;
      end
      `PC_OP_BRANCH: begin
        base = pc;
        offset = imm_b;
      end
      default: begin
        base = pc;
        offset = `MEMORY_ADDR_W'h4;
      end
    endcase
  end

  assign link_pc = pc + `MEMORY_ADDR_W'h4;
  assign next_pc = base + offset;
  
endmodule
