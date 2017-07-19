`define ALU_SHIFT_W 5

`define ALU_INPUT_SEL_W 3
`define ALU_INPUT_SEL_REG `ALU_INPUT_SEL_W'd0
`define ALU_INPUT_SEL_IMM_I `ALU_INPUT_SEL_W'd1
`define ALU_INPUT_SEL_PC `ALU_INPUT_SEL_W'd2
`define ALU_INPUT_SEL_IMM_U `ALU_INPUT_SEL_W'd3
`define ALU_INPUT_SEL_ZERO `ALU_INPUT_SEL_W'd4

`define ALU_OP_W 4
`define ALU_OP_ADD  `ALU_OP_W'd0
`define ALU_OP_SLT  `ALU_OP_W'd1
`define ALU_OP_SLTU `ALU_OP_W'd2
`define ALU_OP_XOR  `ALU_OP_W'd3
`define ALU_OP_OR   `ALU_OP_W'd4
`define ALU_OP_AND  `ALU_OP_W'd5
`define ALU_OP_SLL  `ALU_OP_W'd6
`define ALU_OP_SRL  `ALU_OP_W'd7
`define ALU_OP_SRA  `ALU_OP_W'd8
`define ALU_OP_SUB  `ALU_OP_W'd9
`define ALU_OP_SEQ  `ALU_OP_W'd10
`define ALU_OP_SNE  `ALU_OP_W'd11
`define ALU_OP_SGE  `ALU_OP_W'd12
`define ALU_OP_SGEU `ALU_OP_W'd13
