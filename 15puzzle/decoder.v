module decoder(op, zf, pc_in, pc_we, src0, src1, src2, dst, re_dst, reg_we, sel1, sel2, data, alu_op, mem_we);
	input wire [22:0] op;
	input wire [5:0] re_dst;
	input wire zf;
	output reg [8:0] pc_in;
	output reg pc_we;
	output reg [5:0] src0, src1, src2, dst;
	output reg reg_we;
	output reg sel1, sel2;
	output reg [4:0] data;
	output reg [4:0] alu_op;
	output reg  mem_we;

`include "def.h"

always @(*) begin
	case(op[22:18])
//synopsys parallel_case full_case
	AND: begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src1 = op[11:6];
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	OR : begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src1 = op[11:6];
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	XOR : begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src1 = op[11:6];
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	ADD : begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src1 = op[11:6];
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	SUB : begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src1 = op[11:6];
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

//	MUL : begin
//		alu_op = op[22:18];
//		dst = op[17:12];
//		src2 = 0;
//		src1 = op[11:6];
//		src0 = op[5:0];
//		pc_in = 0;
//		pc_we = 0;
//		reg_we = 1;
//		sel1 = 0;
//		sel2 = 0;
//		data = 0;
//		mem_we = 0;
//	end
//
//	LSFT : begin
//		alu_op = op[22:18];
//		dst = op[17:12];
//		src2 = 0;
//		src1 = op[11:6];
//		src0 = op[5:0];
//		pc_in = 0;
//		pc_we = 0;
//		reg_we = 1;
//		sel1 = 0;
//		sel2 = 0;
//		data = 0;
//		mem_we = 0;
//	end
//
//	RSFT : begin
//		alu_op = op[22:18];
//		dst = op[17:12];
//		src2 = 0;
//		src1 = op[11:6];
//		src0 = op[5:0];
//		pc_in = 0;
//		pc_we = 0;
//		reg_we = 1;
//		sel1 = 0;
//		sel2 = 0;
//		data = 0;
//		mem_we = 0;
//	end

	JMP : begin
		alu_op = op[22:18];
		dst = 0;
		src2 = 0;
		src1 = 0;
		src0 = 0;
		pc_in = op[8:0];
		pc_we = 1;
		reg_we = 0;
		sel1 = 0;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	JNZ : begin
		alu_op = op[22:18];
		dst = 0;
		src2 = 0;
		src1 = 0;
		src0 = 0;
		pc_in = op[8:0];
		pc_we = zf;
		reg_we = 0;
		sel1 = 0;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end
	
	ZNJ : begin 
		alu_op = op[22:18];
		dst = 0;
		src2 = 0;
		src1 = 0;
		src0 = 0;
		pc_in = op[8:0];
		pc_we = ~zf;
		reg_we = 0;
		sel1 = 0;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	LI : begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src0 = 0;
		src1 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	COPY : begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src1 = 0;
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	RL : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = re_dst[5:0];
		src1 = 0;
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	CARD : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = re_dst[5:0]+18;
		src1 = 0;
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	RCOPI1 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = op[5:0];
		src1 = 0;
		src0 = re_dst[5:0]+1;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	RCOPD1 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = op[5:0];
		src1 = 0;
		src0 = re_dst[5:0]-1;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	RCOPI3 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = op[5:0];
		src1 = 0;
		src0 = re_dst[5:0]+3;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	RCOPD3 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = op[5:0];
		src1 = 0;
		src0 = re_dst[5:0]-3;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	REDST30 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = re_dst[5:0]+30;
		src1 = 0;
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	RLI1 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = re_dst[5:0]+1;
		src1 = 0;
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	RLI3 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = re_dst[5:0]+3;
		src1 = 0;
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	RLD1 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = re_dst[5:0]-1;
		src1 = 0;
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	RLD3 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = re_dst[5:0]-3;
		src1 = 0;
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end


	CHECK30 : begin
		alu_op = op[22:18];
		src2 = op[17:12];
		dst = 0;
		src1 = re_dst[5:0]+30;
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 0;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	COMP : begin
		alu_op = op[22:18];
		src2 = 0;
		dst = 0;
		src1 = op[11:6];
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 0;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end


	CHECK : begin
		alu_op = op[22:18];
		dst = 0;
		src2 = 0;
		src1 = op[11:6];
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 0;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	LESS : begin
		alu_op = op[22:18];
		dst = 0;
		src2 = 0;
		src1 = op[11:6];
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 0;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	MORE : begin
		alu_op = op[22:18];
		dst = 0;
		src2 = 0;
		src1 = op[11:6];
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 0;
		sel1 = 0;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	AMARIN0 : begin
		alu_op = op[22:18];
		dst = 0;
		src2 = 0;
		src1 = op[11:6];
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 0;
		sel1 = 1;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end

	AMARI1 : begin
		alu_op = op[22:18];
		dst = 0;
		src2 = 0;
		src1 = op[11:6];
		src0 = 0;
		pc_in = 0;
		pc_we = 0;
		reg_we = 0;
		sel1 = 1;
		sel2 = 0;
		data = op[4:0];
		mem_we = 0;
	end
	
	INC : begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src1 = 0;
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end

	DEC : begin
		alu_op = op[22:18];
		dst = op[17:12];
		src2 = 0;
		src1 = 0;
		src0 = op[5:0];
		pc_in = 0;
		pc_we = 0;
		reg_we = 1;
		sel1 = 1;
		sel2 = 0;
		data = 0;
		mem_we = 0;
	end


	default : begin
		pc_we = 0;
	end

	endcase
end

endmodule
