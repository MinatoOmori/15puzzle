`include "alu.vh"
`include "common.vh"
`include "instruction.vh"
`include "memory.vh"
`include "register.vh"
`include "pc.vh"

module control(
  input wire [`INSTRUCTION_OPCODE_W-1:0] opcode,
  input wire [`INSTRUCTION_FUNCT3_W-1:0] funct3,
  input wire [`INSTRUCTION_FUNCT7_W-1:0] funct7,
  output reg [`MEMORY_ADDR_SEL_W-1:0] memory_addr_sel,
  output reg [`MEMORY_WRAP_TYP_W-1:0] dmem_read_typ,
  output reg [`MEMORY_WRITE_TYP_W-1:0] dmem_write_typ,
  output reg dmem_wenable,
  output reg [`ALU_OP_W-1:0] alu_op,
  output reg [`ALU_INPUT_SEL_W-1:0] alu_input1_sel,
  output reg [`ALU_INPUT_SEL_W-1:0] alu_input2_sel,
  output reg [`REGISTER_WRITE_SEL_W-1:0] register_write_sel,
  output reg register_wenable,
  input wire [`REGISTER_DATA_W-1:0] alu_out,
  output reg [`PC_OP_W-1:0] pc_op
  );

  always @(*) begin
    case (opcode)
      `INSTRUCTION_OPCODE_JAL: begin
        pc_op = `PC_OP_JAL;
      end
      `INSTRUCTION_OPCODE_JALR: begin
        pc_op = `PC_OP_JALR;
      end
      `INSTRUCTION_OPCODE_BRANCH: begin
        case (|alu_out)
          1'b1: pc_op = `PC_OP_BRANCH;
          default: pc_op = `PC_OP_DEFAULT;
        endcase
      end
      default: begin
        pc_op = `PC_OP_DEFAULT;
      end
    endcase
  end

  always @(*) begin
    case (opcode)
      `INSTRUCTION_OPCODE_LUI: alu_input1_sel = `ALU_INPUT_SEL_ZERO;
      `INSTRUCTION_OPCODE_AUIPC: alu_input1_sel = `ALU_INPUT_SEL_PC;
      default: alu_input1_sel = `ALU_INPUT_SEL_REG;
    endcase
  end

  always @(*) begin
    case (opcode)
      `INSTRUCTION_OPCODE_BRANCH: begin
        alu_input2_sel = `ALU_INPUT_SEL_REG;
        case (funct3)
          `INSTRUCTION_FUNCT3_BEQ: alu_op = `ALU_OP_SEQ;
          `INSTRUCTION_FUNCT3_BNE: alu_op = `ALU_OP_SNE;
          `INSTRUCTION_FUNCT3_BLT: alu_op = `ALU_OP_SLT;
          `INSTRUCTION_FUNCT3_BGE: alu_op = `ALU_OP_SGE;
          `INSTRUCTION_FUNCT3_BLTU: alu_op = `ALU_OP_SLTU;
          `INSTRUCTION_FUNCT3_BGEU: alu_op = `ALU_OP_SGEU;
          default: alu_op = `ALU_OP_ADD;
        endcase
      end

      `INSTRUCTION_OPCODE_REG: begin
        alu_input2_sel = `ALU_INPUT_SEL_REG;
        case (funct3)
          `INSTRUCTION_FUNCT3_ADD: begin
            case (funct7)
              `INSTRUCTION_FUNCT7_ADD: alu_op = `ALU_OP_ADD;
              `INSTRUCTION_FUNCT7_SUB: alu_op = `ALU_OP_SUB;
              default: alu_op = `ALU_OP_ADD;
            endcase
          end
          `INSTRUCTION_FUNCT3_SLL: alu_op = `ALU_OP_SLL;
          `INSTRUCTION_FUNCT3_SLT: alu_op = `ALU_OP_SLT;
          `INSTRUCTION_FUNCT3_SLTU: alu_op = `ALU_OP_SLTU;
          `INSTRUCTION_FUNCT3_XOR: alu_op = `ALU_OP_XOR;
          `INSTRUCTION_FUNCT3_SRL: begin
            case (funct7)
              `INSTRUCTION_FUNCT7_SRL: alu_op = `ALU_OP_SRL;
              `INSTRUCTION_FUNCT7_SRA: alu_op = `ALU_OP_SRA;
              default: alu_op = `ALU_OP_ADD;
            endcase
          end
          `INSTRUCTION_FUNCT3_OR: alu_op = `ALU_OP_OR;
          `INSTRUCTION_FUNCT3_AND: alu_op = `ALU_OP_AND;
          default: alu_op = `ALU_OP_ADD;
        endcase
      end

      `INSTRUCTION_OPCODE_IMM: begin
        alu_input2_sel = `ALU_INPUT_SEL_IMM_I;
        case (funct3)
          `INSTRUCTION_FUNCT3_ADD: alu_op = `ALU_OP_ADD;
          `INSTRUCTION_FUNCT3_SLT: alu_op = `ALU_OP_SLT;
          `INSTRUCTION_FUNCT3_SLTU: alu_op = `ALU_OP_SLTU;
          `INSTRUCTION_FUNCT3_XOR: alu_op = `ALU_OP_XOR;
          `INSTRUCTION_FUNCT3_OR: alu_op = `ALU_OP_OR;
          `INSTRUCTION_FUNCT3_AND: alu_op = `ALU_OP_AND;
          `INSTRUCTION_FUNCT3_SLL: alu_op = `ALU_OP_SLL;
          `INSTRUCTION_FUNCT3_SRL: begin
            case (funct7)
              `INSTRUCTION_FUNCT7_SRL: alu_op = `ALU_OP_SRL;
              `INSTRUCTION_FUNCT7_SRA: alu_op = `ALU_OP_SRA;
              default: alu_op = `ALU_OP_ADD;
            endcase
          end
          default: alu_op = `ALU_OP_ADD;
        endcase
      end

      `INSTRUCTION_OPCODE_LUI, `INSTRUCTION_OPCODE_AUIPC: begin
        alu_input2_sel = `ALU_INPUT_SEL_IMM_U;
        alu_op = `ALU_OP_ADD;
      end

      default: begin
        alu_input2_sel = `ALU_INPUT_SEL_REG;
        alu_op = `ALU_OP_ADD;
      end
    endcase
  end

  always @(*) begin
    case (opcode)
      `INSTRUCTION_OPCODE_JAL, `INSTRUCTION_OPCODE_JALR: begin
        register_wenable = `ENABLE;
        register_write_sel = `REGISTER_WRITE_SEL_PC;
      end

      `INSTRUCTION_OPCODE_LOAD: begin
        register_wenable = `ENABLE;
        register_write_sel = `REGISTER_WRITE_SEL_DMEM;
      end

      `INSTRUCTION_OPCODE_REG, `INSTRUCTION_OPCODE_IMM, `INSTRUCTION_OPCODE_LUI, `INSTRUCTION_OPCODE_AUIPC: begin
        register_wenable = `ENABLE;
        register_write_sel = `REGISTER_WRITE_SEL_ALU_OUT;
      end

      default: begin
        register_wenable = `DISABLE;
        register_write_sel = `REGISTER_WRITE_SEL_ALU_OUT;
      end
    endcase
  end

  always @(*) begin
    case (opcode)
      `INSTRUCTION_OPCODE_LOAD: begin
        memory_addr_sel = `MEMORY_ADDR_SEL_LOAD;
        dmem_wenable = `DISABLE;
        dmem_write_typ = `MEMORY_WRITE_TYP_WU;
        case (funct3)
          `INSTRUCTION_FUNCT3_BS: dmem_read_typ = `MEMORY_WRAP_TYP_BS;
          `INSTRUCTION_FUNCT3_HS: dmem_read_typ = `MEMORY_WRAP_TYP_HS;
          `INSTRUCTION_FUNCT3_WS: dmem_read_typ = `MEMORY_WRAP_TYP_WS;
          `INSTRUCTION_FUNCT3_BU: dmem_read_typ = `MEMORY_WRAP_TYP_BU;
          `INSTRUCTION_FUNCT3_HU: dmem_read_typ = `MEMORY_WRAP_TYP_HU;
          default: dmem_read_typ = `MEMORY_WRAP_TYP_WS;
        endcase
      end

      `INSTRUCTION_OPCODE_STORE: begin
        memory_addr_sel = `MEMORY_ADDR_SEL_STORE;
        dmem_wenable = `ENABLE;
        dmem_read_typ = `MEMORY_WRAP_TYP_WS;
        case (funct3)
          `INSTRUCTION_FUNCT3_BS: dmem_write_typ = `MEMORY_WRITE_TYP_BU;
          `INSTRUCTION_FUNCT3_HS: dmem_write_typ = `MEMORY_WRITE_TYP_HU;
          `INSTRUCTION_FUNCT3_WS: dmem_write_typ = `MEMORY_WRITE_TYP_WU;
          default: dmem_write_typ = `MEMORY_WRAP_TYP_WS;
        endcase
      end

      default: begin
        memory_addr_sel = `MEMORY_ADDR_SEL_LOAD;
        dmem_wenable = `DISABLE;
        dmem_read_typ = `MEMORY_WRAP_TYP_WS;
        dmem_write_typ = `MEMORY_WRITE_TYP_WU;
      end
    endcase
  end

endmodule
