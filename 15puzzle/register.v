	module register(re_dst,src2, src0, src1, dst, we, data, we, clk, rst_n, outa, outb, comp, cnt, ord);
		input wire clk, rst_n;
		input wire [5:0] src0, src1, src2;
		input wire [5:0] dst;
		input wire we;
		input wire [4:0] data;
		output wire comp;
		output wire [63:0] cnt, ord;
		output wire [4:0] outa, outb;
		output wire [5:0] re_dst;
		wire [4:0] limit,path0,path1,path2,path3,path4,path5,path6,path7,path8,path9,path10,board0,board1,board2,board3,board4,board5,board6,board7,board8,hole,counter,init0;

		reg[4:0] regis [63:0];

	always @(posedge clk) begin
		if (!rst_n)begin
			regis[0] <= 0;
			regis[1] <= 0;
			regis[2] <= 0;
			regis[3] <= 0;
			regis[4] <= 0;
			regis[5] <= 0;
			regis[6] <= 0;
			regis[7] <= 0;
			regis[8] <= 0;
			regis[9] <= 0;
			regis[10] <= 0;
			regis[11] <= 0;
			regis[12] <= 0;
			regis[13] <= 0;
			regis[14] <= 0;
			regis[15] <= 0;
			regis[16] <= 0;
			regis[17] <= 0;
			regis[18] <= 0;
			regis[19] <= 0;
			regis[20] <= 0;
			regis[21] <= 0;
			regis[22] <= 0;
			regis[23] <= 0;
			regis[24] <= 0;
			regis[25] <= 0;
			regis[26] <= 0;
			regis[27] <= 0;
			regis[28] <= 0;
			regis[29] <= 0;
			regis[30] <= 0;
			regis[31] <= 0;
			regis[32] <= 0;
			regis[33] <= 0;
			regis[34] <= 0;
			regis[35] <= 0;
			regis[36] <= 0;
			regis[37] <= 0;
			regis[38] <= 0;
			regis[39] <= 0;
			regis[40] <= 0;
			regis[41] <= 0;
			regis[42] <= 0;
			regis[43] <= 0;
			regis[44] <= 0;
			regis[45] <= 0;
			regis[46] <= 0;
			regis[47] <= 0;
			regis[48] <= 0;
			regis[49] <= 0;
			regis[50] <= 0;
			regis[51] <= 0;
			regis[52] <= 0;
			regis[53] <= 0;
			regis[54] <= 0;
			regis[55] <= 0;
			regis[56] <= 0;
			regis[57] <= 0;
			regis[58] <= 0;
			regis[59] <= 0;
			regis[60] <= 0;
			regis[61] <= 0;
			regis[62] <= 0;
			regis[63] <= 0;
		end else begin
			if (we) begin
				regis[dst] <= data;
			end else begin
				regis[dst] <= regis[dst];
			end
		end
	end

	assign outa = regis[src0];
	assign outb = regis[src1];
	assign re_dst ={1'b0, regis[src2]};

	assign path0 = regis[30];
	assign path1 = regis[31];
	assign path2 = regis[32];
	assign path3 = regis[33];
	assign path4 = regis[34];
	assign path5 = regis[35];
	assign path6 = regis[36];
	assign path7 = regis[37];
	assign path8 = regis[38];
	assign path9 = regis[39];
	assign path10 = regis[40];
	assign board0 = regis[0];
	assign board1 = regis[1];
	assign board2 = regis[2];
	assign board3 = regis[3];
	assign board4 = regis[4];
	assign board5 = regis[5];
	assign board6 = regis[6];
	assign board7 = regis[7];
	assign board8 = regis[8];
	assign hole = regis[29];
	assign counter = regis[27];
	assign init0 = regis[9];
	assign limit = regis[28];

	assign ord = {regis[62][1:0], regis[61][1:0], regis[60][1:0], regis[59][1:0], regis[58][1:0], regis[57][1:0], regis[56][1:0], regis[55][1:0], regis[54][1:0], regis[53][1:0], regis[52][1:0], regis[51][1:0], regis[50][1:0], regis[49][1:0], regis[48][1:0], regis[47][1:0], regis[46][1:0], regis[45][1:0], regis[44][1:0], regis[43][1:0], regis[42][1:0], regis[41][1:0], regis[40][1:0], regis[39][1:0], regis[38][1:0], regis[37][1:0], regis[36][1:0], regis[35][1:0], regis[34][1:0], regis[33][1:0], regis[32][1:0], regis[31][1:0]};
	assign cnt = {59'b0, regis[27]};
	assign comp = regis[63][0];
	
endmodule

