module alu(ina, inb, op, zf, out);
	input wire [4:0] ina, inb;
	input wire [4:0] op;
	output reg zf;
	output reg [4:0] out;

`include "def.h"

always @(*) begin
	case(op)
//	AND: begin
//		out = ina & inb;
//		zf = 0;
//	end
//
//	OR: begin 
//		out = ina | inb;
//		zf = 0;
//	end
//	
//	ADD: begin
//		out = ina + inb;
//		zf = 0;
//	end
//
//	SUB: begin
//		out = (ina + inb)? ina - inb : inb - ina;
//		zf = 0;
//	end

	INC: begin
		out = ina + 1;
		zf = 0;
	end
	
	DEC: begin
		out = ina - 1;
		zf = 0;
	end

	COMP: begin
		zf = (ina == inb)? 1:0;
	end
	
	CHECK: begin
		zf = (ina == inb)? 1:0;
	end
	
//	LOAD: begin
//		out = ina;
//		zf = 0;
//	end
//	
//	STORE: begin
//		out = ina;
//		zf = 0;
//	end
	
	LI: begin
		out = ina;
		zf = 0;
	end

	COPY: begin
		out = ina;
		zf = 0;
	end

	RL: begin
		out = ina;
		zf = 0;
	end

	CARD: begin
		out = ina;
		zf = 0;
	end

	LESS: begin
		zf = (ina >inb)? 1 : 0;
		end

	MORE: begin
		zf = (ina <inb)? 1 : 0;
		end

	AMARIN0: begin
		zf = (inb%3 == 0)? 0:1;
	end

	AMARI1: begin
		zf = (inb%3 == 2)? 1:0;
	end

	RCOPI1: begin
		out = ina;
		zf = 0;
	end

	RCOPD1: begin
		out = ina;
		zf = 0;
	end

	RCOPI3: begin
		out = ina;
		zf = 0;
	end

	RCOPD3: begin
		out = ina;
		zf = 0;
	end

	RLI1: begin
		out = ina;
		zf = 0;
	end

	RLD1: begin
		out = ina;
		zf = 0;
	end

	RLI3: begin
		out = ina;
		zf = 0;
	end

	RLD3: begin
		out = ina;
		zf = 0;
	end

	REDST30: begin
		out = ina;
		zf = 0;
	end

	CHECK30: begin
		zf = (ina == inb)? 1:0;
	end

	default : begin
		out = 0;
	end
	
	endcase
end

endmodule
