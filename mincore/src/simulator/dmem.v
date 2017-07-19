`include "memory.vh"

module dmem(
  input wire clk,
  input wire [`MEMORY_ADDR_W-1:0] addr,
  output wire [`MEMORY_DATA_W-1:0] rdata,
  input wire [`MEMORY_DATA_W-1:0] wdata,
  input wire wenable,
  input wire [`MEMORY_WRITE_TYP_W-1:0] wtyp
  );

  reg [`MEMORY_DATA_W-1:0] data[0:`MEMORY_DEPTH-1];

  wire [`MEMORY_ADDR_W-3:0] idx; 
  wire [5:0] offset, rev_offset;
  wire can_overwrap;
  assign idx = addr[`MEMORY_ADDR_W-1:2];
  assign offset = addr[1:0] * 8;
  assign rev_offset = 4 * 8 - offset;
  assign can_overwrap = $signed(idx - 1) < `MEMORY_DEPTH;

  reg [`MEMORY_DATA_W-1:0] rdata1;
  reg [`MEMORY_DATA_W-1:0] rdata2;

  always @(*) begin
    if (can_overwrap) begin
      rdata1 = data[idx];
      rdata2 = data[idx + 1];
    end else begin
      rdata1 = data[idx];
      rdata2 = 0;
    end
  end

  assign rdata = (rdata2 << rev_offset) | (rdata1 >> offset);

  wire [`MEMORY_ADDR_W*2-1:0] current_rdata = {rdata2, rdata1};
  reg [`MEMORY_ADDR_W*2-1:0] mask;
  reg [`MEMORY_ADDR_W*2-1:0] update;

  always @(*) begin
    case (wtyp)
      `MEMORY_WRITE_TYP_BU: begin
        mask = 64'hff << offset;
        update = ((wdata & 8'hff) << offset) | ~mask;
      end
      `MEMORY_WRITE_TYP_HU: begin
        mask = 64'hffff << offset;
        update = ((wdata & 16'hffff) << offset) | ~mask;
      end
      default: begin
        mask = 64'hffffffff << offset;
        update = (wdata << offset) | ~mask;
      end
    endcase
  end

  wire [`MEMORY_ADDR_W*2-1:0] masked_data = current_rdata | mask;
  wire [`MEMORY_ADDR_W*2-1:0] updated_data = masked_data & update;

  always @(posedge clk) begin
    if (wenable) begin
      if (can_overwrap) begin
        data[idx] <= updated_data[`MEMORY_ADDR_W-1:0];
        data[idx + 1] <= updated_data[`MEMORY_ADDR_W*2-1:`MEMORY_ADDR_W];
      end else begin
        data[idx] <= updated_data[`MEMORY_ADDR_W-1:0];
      end
    end
  end

  initial begin
    $readmemh("memory.memh", data);
  end

endmodule
