`include "register.vh"

module register_file(
  input clk,
  input [`REGISTER_ADDR_W-1:0] raddr1,
  output [`REGISTER_DATA_W-1:0] rdata1,
  input [`REGISTER_ADDR_W-1:0] raddr2,
  output [`REGISTER_DATA_W-1:0] rdata2,
  input wenable,
  input [`REGISTER_ADDR_W-1:0] waddr,
  input [`REGISTER_DATA_W-1:0] wdata
  );

  reg [`REGISTER_DATA_W-1:0] data[`REGISTER_N:0];

  assign rdata1 = data[raddr1];
  assign rdata2 = data[raddr2];

  wire should_write;
  assign should_write = wenable && |waddr; // Use x0 as a zero-register

  always @(posedge clk) begin
    if (should_write)
      data[waddr] <= wdata;
  end

  initial begin
    data[0] = 0;
  end

endmodule
