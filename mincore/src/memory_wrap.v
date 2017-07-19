`include "memory.vh"

module memory_wrap(
  input wire [`MEMORY_WRAP_TYP_W-1:0] typ,
  input wire [`MEMORY_DATA_W-1:0] in,
  output reg [`MEMORY_DATA_W-1:0] out
  );

  always @(*) begin
    case (typ)
      `MEMORY_WRAP_TYP_BS: out = {{24{in[7]}}, in[7:0]};
      `MEMORY_WRAP_TYP_HS: out = {{16{in[15]}}, in[15:0]};
      `MEMORY_WRAP_TYP_WS: out = in;
      `MEMORY_WRAP_TYP_BU: out = in & 32'hff;
      `MEMORY_WRAP_TYP_HU: out = in & 32'hffff;
      default: out = in;
    endcase
  end

endmodule
