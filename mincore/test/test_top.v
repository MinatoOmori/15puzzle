`include "alu.vh"
`include "instruction.vh"
`include "memory.vh"
`include "register.vh"

module test_top(
  input clk,
  input rst
  );

  wire [`MEMORY_ADDR_W-1:0] imem_addr;
  wire [`MEMORY_DATA_W-1:0] imem_rdata;
  wire [`MEMORY_ADDR_W-1:0] dmem_addr;
  wire [`MEMORY_DATA_W-1:0] dmem_rdata;
  wire [`MEMORY_DATA_W-1:0] dmem_wdata;
  wire dmem_wenable;
  wire [`MEMORY_WRITE_TYP_W-1:0] dmem_write_typ;

  imem imem(.addr(imem_addr), .rdata(imem_rdata));

  dmem dmem(.clk(clk), .addr(dmem_addr), .rdata(dmem_rdata), .wdata(dmem_wdata),
    .wenable(dmem_wenable), .wtyp(dmem_write_typ));

  mincore mincore(
    .clk(clk),
    .rst(rst),
    .imem_addr(imem_addr),
    .imem_rdata(imem_rdata),
    .dmem_addr(dmem_addr),
    .dmem_rdata(dmem_rdata),
    .dmem_wdata(dmem_wdata),
    .dmem_wenable(dmem_wenable),
    .dmem_write_typ(dmem_write_typ)
    );
  
  wire [`MEMORY_ADDR_W-1:0] pc = mincore.data_path.pc;
  wire [`INSTRUCTION_OPCODE_W-1:0] opcode = mincore.opcode;
  wire [`REGISTER_ADDR_W-1:0] rd = mincore.data_path.register_waddr;
  wire [`INSTRUCTION_FUNCT3_W-1:0] funct3 = mincore.funct3;
  wire [`REGISTER_ADDR_W-1:0] rs1 = mincore.data_path.register_raddr1;
  wire [`REGISTER_ADDR_W-1:0] rs2 = mincore.data_path.register_raddr2;
  wire [`INSTRUCTION_FUNCT7_W-1:0] funct7 = mincore.funct7;

  wire [`ALU_OP_W-1:0] alu_op = mincore.data_path.alu_op;
  wire [`ALU_INPUT_SEL_W-1:0] alu_input_sel = mincore.data_path.alu_input2_sel;
  wire [`REGISTER_DATA_W-1:0] alu_in1 = mincore.data_path.alu_in1;
  wire [`REGISTER_DATA_W-1:0] alu_in2 = mincore.data_path.alu_in2;
  wire [`REGISTER_DATA_W-1:0] alu_out = mincore.data_path.alu_out;

  wire register_wenable = mincore.data_path.register_file.wenable;
  wire [`REGISTER_DATA_W-1:0] x0 = mincore.data_path.register_file.data[0];
  wire [`REGISTER_DATA_W-1:0] x1 = mincore.data_path.register_file.data[1];
  wire [`REGISTER_DATA_W-1:0] x2 = mincore.data_path.register_file.data[2];
  wire [`REGISTER_DATA_W-1:0] x3 = mincore.data_path.register_file.data[3];
  wire [`REGISTER_DATA_W-1:0] x4 = mincore.data_path.register_file.data[4];
  wire [`REGISTER_DATA_W-1:0] x5 = mincore.data_path.register_file.data[5];
  wire [`REGISTER_DATA_W-1:0] x6 = mincore.data_path.register_file.data[6];

  wire [`MEMORY_DATA_W-1:0] m0 = dmem.data[0];
  wire [`MEMORY_DATA_W-1:0] m1 = dmem.data[1];
  wire [`MEMORY_DATA_W-1:0] m2 = dmem.data[2];
  wire [`MEMORY_DATA_W-1:0] m3 = dmem.data[3];

  always @(posedge clk) begin
    if (dmem_addr == 32'h10000000 && dmem_wenable) begin
      $write("%c", dmem_wdata);
    end
  end

  always @(negedge clk) begin
    // $display("pc: %h, opcode: %h, rd: %h, funct3: %h, rs1: %h, rs2: %h, funct7: %h",
    //   pc, opcode, rd, funct3, rs1, rs2, funct7);
    // $display("alu_op: %h, alu_input_sel: %h, alu_in1: %h, alu_in2: %h, alu_out: %h",
    //   alu_op, alu_input_sel, alu_in1, alu_in2, alu_out);
    // $display("reg: %b %h %h %h %h %h %h %h", register_wenable, x0, x1, x2, x3, x4, x5, x6);
    // $display("mem: %b %h %h %h %h", dmem_wenable, m0, m1, m2, m3);
    // $display("");

    if (opcode == `INSTRUCTION_OPCODE_SYSTEM) begin
      $display("exit with system: %h", imem_rdata);
      $finish;
    end
  end

endmodule
