module imem(pc, op);
	input wire [8:0] pc;
	output reg [22:0] op;

`include "def.h"
parameter[8:0]
	A1 = 30,
	A2 = 80,
	B1 = 32,
	B2 = 90,
	B3 = 108,
	C1 = 34,
	C2 = 98,
	C3 = 117,
	D1 = 36,
	D2 = 124,
	IS = 10,
	GG = 167,
	L1 = 65,
	L4 = 71,
	P8 = 133,
	JD = 46,
	B31 = 145,
	C31 = 153,
	D21 = 159,
	L11 = 138;


always @(pc) begin
	case (pc)
	0 : begin //INIT 1
		op[22:18] = LI;
		op[17:12] = 9;
		op[4:0] = 1-1;
	end

	1 : begin //INIT 2
		op[22:18] = LI;
		op[17:12] = 10;
		op[4:0] = 3-1;
	end

	2 : begin //INIT 3
		op[22:18] = LI;
		op[17:12] = 11;
		op[4:0] = 5-1;
	end

	3 : begin //INIT 4
		op[22:18] = LI;
		op[17:12] = 12;
		op[4:0] = 2-1;
	end

	4 : begin //INIT 5
		op[22:18] = LI;
		op[17:12] = 13;
		op[4:0] = 9-1;
	end

	5 : begin //INIT 6
		op[22:18] = LI;
		op[17:12] = 14;
		op[4:0] = 6-1;
	end

	6 : begin //INIT 7
		op[22:18] = LI;
		op[17:12] = 15;
		op[4:0] = 4-1;
	end

	7 : begin //INIT 8
		op[22:18] = LI;
		op[17:12] = 16;
		op[4:0] = 7-1;
	end

	8 : begin //INIT 9
		op[22:18] = LI;
		op[17:12] = 17;
		op[4:0] = 8-1;
	end

	9 : begin //limit=4
		op[22:18] = LI;
		op[17:12] = 28;
		op[4:0] = 10;
		end

	10 : begin //card1 IS
		op[22:18] = LI;
		op[17:12] = 18;
		op[4:0] = 1-1;
	end

	11 : begin //card2
		op[22:18] = LI;
		op[17:12] = 19;
		op[4:0] = 4-1;
	end

	12 : begin //card3
		op[22:18] = LI;
		op[17:12] = 20;
		op[4:0] = 2-1;
	end

	13 : begin //card4
		op[22:18] = LI;
		op[17:12] = 21;
		op[4:0] = 7-1;
	end

	14 : begin //card5
		op[22:18] = LI;
		op[17:12] = 22;
		op[4:0] = 3-1;
	end

	15 : begin //card6
		op[22:18] = LI;
		op[17:12] = 23;
		op[4:0] = 6-1;
	end

	16 : begin //card7
		op[22:18] = LI;
		op[17:12] = 24;
		op[4:0] = 8-1;
	end

	17 : begin //card8
		op[22:18] = LI;
		op[17:12] = 25;
		op[4:0] = 9-1;
	end

	18 : begin //counter
		op[22:18] = LI;
		op[17:12] = 27;
		op[4:0] = 0;
		end

	19 : begin //path0=4
		op[22:18] = LI;
		op[17:12] = 30;
		op[4:0] = 3;
		end

	20 : begin //board = INIT
		op[22:18] = COPY;
		op[17:12] = 0;
		op[5:0] = 9;
	end

	21 : begin
		op[22:18] = COPY;
		op[17:12] = 1;
		op[5:0] = 10;
	end
	
	22 : begin
		op[22:18] = COPY;
		op[17:12] = 2;
		op[5:0] = 11;
	end

	23 : begin
		op[22:18] = COPY;
		op[17:12] = 3;
		op[5:0] = 12;
	end

	24 : begin
		op[22:18] = COPY;
		op[17:12] = 4;
		op[5:0] = 13;
	end

	25 : begin
		op[22:18] = COPY;
		op[17:12] = 5;
		op[5:0] = 14;
	end

	26 : begin
		op[22:18] = COPY;
		op[17:12] = 6;
		op[5:0] = 15;
	end

	27 : begin
		op[22:18] = COPY;
		op[17:12] = 7;
		op[5:0] = 16;
	end

	28 : begin
		op[22:18] = COPY;
		op[17:12] = 8;
		op[5:0] = 17;
	end

	29 : begin //hole
		op[22:18] = LI;
		op[17:12] = 29;
		op[4:0] = 5-1;
	end

	30 : begin //down? A1
		op[22:18] = LESS;
		op[11:6] = 29;
		op[4:0] = 6;
	end
	
	31 : begin
		op[22:18] = JNZ;
		op[8:0] = A2;
	end


	32 : begin //left? B1
		op[22:18] = AMARIN0;
		op[11:6] = 29;
	end


	33 : begin
		op[22:18] = JNZ;
		op[8:0] = B2;
	end


	34 : begin //up? C1
		op[22:18] = MORE;
		op[11:6] = 29;
		op[4:0] = 2;
	end
	
	35 : begin
		op[22:18] = JNZ;
		op[8:0] = C2;
	end


	36 : begin //left? D1
		op[22:18] = AMARI1;
		op[11:6] = 29;
	end
	

	37 : begin
		op[22:18] = JNZ;
		op[8:0] = L11;
	end


	38 : begin //hole ->
		op[22:18] = RCOPI1;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	40 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	41 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	42 : begin
		op[22:18] = RLI1;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	43 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	44 : begin //left
		op[22:18] = INC;
		op[17:12] = 27;
		op[5:0] = 27;
	end

	45 : begin 
		op[22:18] = REDST30;
		op[17:12] = 27;
		op[4:0] = 3;
	end

	46 : begin //JD
		op[22:18] = CHECK;
		op[11:6] = 0;
		op[5:0] = 0;
	end
	
	47 : begin
		op[22:18] = ZNJ;
		op[8:0] = L1 - 3;
	end
	 

	48 : begin
		op[22:18] = CHECK;
		op[11:6] = 1;
		op[5:0] = 1;
	end
	
	49 : begin
		op[22:18] = ZNJ;
		op[8:0] = L1 - 3;
	end
	 

	50 : begin
		op[22:18] = CHECK;
		op[11:6] = 2;
		op[5:0] = 2;
	end
	
	51 : begin
			op[22:18] = ZNJ;
			op[8:0] = L1 - 3;
	end

	
	52 : begin
			op[22:18] = CHECK;
			op[11:6] = 3;
			op[5:0] = 3;
	end
	
	53 : begin
			op[22:18] = ZNJ;
			op[8:0] = L1 - 3;
	end


	54 : begin
			op[22:18] = CHECK;
			op[11:6] = 4;
			op[5:0] = 4;
	end
	
	55 : begin
			op[22:18] = ZNJ;
			op[8:0] = L1 - 3;
	end

	
	56 : begin
			op[22:18] = CHECK;
			op[11:6] = 5;
			op[5:0] = 5;
	end
	
	57 : begin
			op[22:18] = ZNJ;
			op[8:0] = L1 - 3;
	end
	

	58 : begin 
			op[22:18] = CHECK;
			op[11:6] = 6;
			op[5:0] = 6;
	end
	
	59 : begin
			op[22:18] = ZNJ;
			op[8:0] = L1 - 3;
	end
	 

	60 : begin
			op[22:18] = CHECK;
			op[11:6] = 7;
			op[5:0] = 7;
	end
	
	61 : begin
			op[22:18] = JNZ;
			op[8:0] = GG;
	end


	62 : begin //counter = limit?
		op[22:18] = COMP;
		op[11:6] = 27;
		op[5:0] = 28;
	end

	63 : begin
		op[22:18] = JNZ;
		op[8:0] = L1;
	end


	64 : begin
		op[22:18] = JMP;
		op[8:0] = A1;
	end


	65 : begin //L1
		op[22:18] = CHECK30;
		op[17:12] = 27;
		op[4:0] = 0;
	end

	66 : begin
		op[22:18] = JNZ;
		op[8:0] = B3;
	end


	67 : begin //L2
		op[22:18] = CHECK30;
		op[17:12] = 27;
		op[4:0] = 1;
	end

	68 : begin
		op[22:18] = JNZ;
		op[8:0] = C3;
	end


	69 : begin //L3
		op[22:18] = CHECK30;
		op[17:12] = 27;
		op[4:0] = 2;
	end

	70 : begin
		op[22:18] = JNZ;
		op[8:0] = D2;
	end


	71 : begin //L4
		op[22:18] = CHECK;
		op[11:6] = 27;
		op[4:0] = 0;
	end

	72 : begin
		op[22:18] = JNZ;
		op[8:0] = P8;
	end


	73 : begin //hole <-
		op[22:18] = RCOPD1;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	74 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	75 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	76 : begin
		op[22:18] = RLD1;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	77 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	78 : begin
		op[22:18] = DEC;
		op[17:12] = 27;
		op[5:0] = 27;
	end
	
	79 : begin
		op[22:18] = JMP;
		op[8:0] = L1;
	end


	80 : begin //hole down A2
		op[22:18] = RCOPI3;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	81 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	82 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	83 : begin
		op[22:18] = RLI3;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	84 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	85 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	86 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	87 : begin
		op[22:18] = INC;
		op[17:12] = 27;
		op[5:0] = 27;
	end

	88 : begin 
		op[22:18] = REDST30;
		op[17:12] = 27;
		op[4:0] = 0;
	end

	89 : begin
		op[22:18] = JMP;
		op[8:0] = JD;
	end


	90 : begin //hole <- B2
		op[22:18] = RCOPD1;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	91 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	92 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	93 : begin
		op[22:18] = RLD1;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	94 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	95 : begin 
		op[22:18] = INC;
		op[17:12] = 27;
		op[5:0] = 27;
	end

	96 : begin 
		op[22:18] = REDST30;
		op[17:12] = 27;
		op[4:0] = 1;
	end

	97 : begin
		op[22:18] = JMP;
		op[8:0] = JD;
	end


	98 : begin //hole up C2
		op[22:18] = RCOPD3;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	99 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	100 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	101 : begin
		op[22:18] = RLD3;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	102 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	103 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	104 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	105 : begin 
		op[22:18] = INC;
		op[17:12] = 27;
		op[5:0] = 27;
	end

	106 : begin 
		op[22:18] = REDST30;
		op[17:12] = 27;
		op[4:0] = 2;
	end

	107 : begin
		op[22:18] = JMP;
		op[8:0] = JD;
	end


	108 : begin //B3 
		op[22:18] = RCOPD3;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	109 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	110 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	111 : begin
		op[22:18] = RLD3;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	112 : begin 
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	113 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	114 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	115 : begin
		op[22:18] = DEC;
		op[17:12] = 27;
		op[5:0] = 27;
	end

	116 : begin
		op[22:18] = JMP;
		op[8:0] = B1;
	end


	117 : begin //C3
		op[22:18] = RCOPI1;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	118 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	119 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	120 : begin
		op[22:18] = RLI1;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	121 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	122 : begin
		op[22:18] = DEC;
		op[17:12] = 27;
		op[5:0] = 27;
	end

	123 : begin
		op[22:18] = JMP;
		op[8:0] = C1;
	end


	124 : begin //D2 hole down
		op[22:18] = RCOPI3;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	125 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	126 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	127 : begin
		op[22:18] = RLI3;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	128 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	129 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	130 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	131 : begin
		op[22:18] = DEC;
		op[17:12] = 27;
		op[5:0] = 27;
	end

	132 : begin
		op[22:18] = JMP;
		op[8:0] = D1;
	end


	133 : begin //P8
		op[22:18] = INC;
		op[17:12] = 28;
		op[5:0] = 28;
		end

	134 : begin 
		op[22:18] = INC;
		op[17:12] = 28;
		op[5:0] = 28;
		end

	135 : begin 
		op[22:18] = INC;
		op[17:12] = 28;
		op[5:0] = 28;
		end

	136 : begin 
		op[22:18] = INC;
		op[17:12] = 28;
		op[5:0] = 28;
		end

	137 : begin
		op[22:18] = JMP;
		op[8:0] = IS;
	end


	138 : begin //L11
		op[22:18] = CHECK30;
		op[17:12] = 27;
		op[4:0] = 0;
	end

	139 : begin
		op[22:18] = JNZ;
		op[8:0] = B31;
	end


	140 : begin //L2'
		op[22:18] = CHECK30;
		op[17:12] = 27;
		op[4:0] = 1;
	end

	141 : begin
		op[22:18] = JNZ;
		op[8:0] = C31;
	end


	142 : begin //L3'
		op[22:18] = CHECK30;
		op[17:12] = 27;
		op[4:0] = 2;
	end

	143 : begin
		op[22:18] = JNZ;
		op[8:0] = D21;
	end


	144: begin
		op[21:18] = JMP;
		op[8:0] = L4;
	end


	145 : begin //hole up B31
		op[22:18] = RCOPD3;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	146 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	147 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	148 : begin
		op[22:18] = RLD3;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	149 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	150 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	151 : begin
		op[22:18] = DEC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	152 : begin
		op[22:18] = JMP;
		op[8:0] = C3-2;
	end


	153 : begin //hole -> C31
		op[22:18] = RCOPI1;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	154 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	155 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	156 : begin
		op[22:18] = RLI1;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	157 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	158 : begin
		op[22:18] = JMP;
		op[8:0] = D2-2;
	end


	159 : begin //hole down D21
		op[22:18] = RCOPI3;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	160 : begin
		op[22:18] = CARD;
		op[17:12] = 26;
		op[5:0] = 29;
	end

	161 : begin
		op[22:18] = RL;
		op[17:12] = 29;
		op[5:0] = 26;
	end

	162 : begin
		op[22:18] = RLI3;
		op[17:12] = 29;
		op[4:0] = 8;
	end

	163 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	164 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	165 : begin
		op[22:18] = INC;
		op[17:12] = 29;
		op[5:0] = 29;
	end

	166 : begin
		op[22:18] = JMP;
		op[8:0] = P8-2;
	end


	167 : begin //GG
		op[22:18] = LI;
		op[17:12] = 63;
		op[4:0] = 1;
	end

	168 : begin
		op[22:18] = JMP;
		op[8:0] = 168;
	end


	endcase

end

endmodule
