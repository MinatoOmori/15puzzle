
module memory_addr_mux(
  input wire [`MEMORY_ADDR_SEL_W-1:0] sel,
  input wire [`REGISTER_DATA_W-1:0] register_rdata1,
  input wire [`INSTRUCTION_IMM_W-1:0] imm_i,
  input wire [`INSTRUCTION_IMM_W-1:0] imm_s,
  output reg [`MEMORY_ADDR_W-1:0] out
  );

  always @(*) begin
    case (sel)
      `MEMORY_ADDR_SEL_LOAD: out = register_rdata1 + imm_i;
      `MEMORY_ADDR_SEL_STORE: out = register_rdata1 + imm_s;
    endcase
  end

endmodule
