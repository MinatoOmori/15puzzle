`include "memory.vh"

module imem(
  input [`MEMORY_ADDR_W-1:0] addr,
  output [`MEMORY_DATA_W-1:0] rdata
  );

  reg [`MEMORY_DATA_W-1:0] data[0:`MEMORY_DEPTH-1];

  assign rdata = data[addr[31:2]];

  initial begin
    $readmemh("memory.memh", data);
  end

endmodule
