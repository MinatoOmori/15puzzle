module top(mclk, rst_n, btn, seg);
	input wire mclk, rst_n;
	input [4:0] btn;
	output [11:0] seg;
	wire pc_we, reg_we, mem_we;
	wire [8:0] pc_out, pc_in;
	wire [22:0] op;
	wire [5:0]  dst;
	wire [5:0] src0, src1, src2;
	wire [4:0] dec_data;
	wire [4:0] alu_op;
	wire [4:0] alu_out;

	wire zf, zf_out;

	wire sel1, sel2;
	wire [4:0] sel1_out, sel2_out;
	wire [4:0] reg_data0, reg_data1;

	wire [4:0] mem_data;

	wire [5:0] re_dst;

	wire [63:0] cnt, ord;
	wire comp;

divider div0(.mclk(mclk), .rst_n(rst_n), .clk(clk));

sel s1(.in0(dec_data), .in1(reg_data0), .sel(sel1), .out(sel1_out));
sel s2(.in0(alu_out), .in1(mem_data), .sel(sel2), .out(sel2_out));

register r0(.re_dst(re_dst), .src0(src0), .src1(src1), .src2(src2), .dst(dst), .we(reg_we), .data(sel2_out), .clk(clk), .rst_n(rst_n), .outa(reg_data0), .outb(reg_data1), .comp(comp), .ord(ord), .cnt(cnt));

io io0(.comp(comp), .ord(ord), .cnt(cnt), .btn(btn), .seg(seg), .clk(clk), .rst_n(rst_n));

alu a0(.ina(sel1_out), .inb(reg_data1), .op(alu_op), .zf(zf), .out(alu_out));

pc pc0(.pc_in(pc_in), .pc_out(pc_out), .rst_n(rst_n), .clk(clk), .we(pc_we));

imem imem0(.pc(pc_out), .op(op));

zf zf0(.clk(clk), .rst_n(rst_n), .zf_in(zf), .zf_out(zf_out));

decoder dec1(.re_dst(re_dst), .op(op), .zf(zf_out), .pc_in(pc_in), .pc_we(pc_we), .src0(src0), .src1(src1), .src2(src2), .dst(dst), .reg_we(reg_we), .sel1(sel1), .sel2(sel2), .data(dec_data), .alu_op(alu_op), .mem_we(mem_we));

endmodule
