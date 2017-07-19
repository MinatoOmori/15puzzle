BUILD = build

RV32_GCC =
RV32_OBJCOPY =
include ../../config.mak

TARGET = $(BUILD)/memory.memh
FIRMWARE_OBJS = $(addprefix $(BUILD)/,start.o print.o)
TEST_OPS_DIR = tests
TEST_OPS = addi add andi and auipc \
						beq bge bgeu blt bltu bne jalr jal \
						lb lbu lh lhu lui lw \
						ori or sb sh slli sll slti slt \
						srai sra srli srl sub sw xori xor
TEST_OBJS = $(addprefix $(BUILD)/,$(addsuffix .o,$(TEST_OPS)))

all: $(TARGET)

test: $(TARGET)
	cd build; ../../../build/Vtest_top

clean:
	rm -rf $(BUILD)

.PHONY: all, clean

$(BUILD):
	mkdir -p $@

$(BUILD)/%.o: $(TEST_OPS_DIR)/%.S $(TEST_OPS_DIR)/riscv_test.h $(TEST_OPS_DIR)/test_macros.h
	$(RV32_GCC) -c -march=rv32i -o $@ $< -DTEST_FUNC_NAME=$(notdir $(basename $<)) \
		-DTEST_FUNC_TXT='"$(notdir $(basename $<))"' \
		-DTEST_FUNC_RET=$(notdir $(basename $<))_ret

$(BUILD)/start.o: firmware/start.S
	$(RV32_GCC) -c -march=rv32i -o $@ $<

$(BUILD)/%.o: firmware/%.c
	$(RV32_GCC) -c -march=rv32i -Os -std=c99 -ffreestanding -nostdlib -o $@ $<

$(BUILD)/firmware: $(BUILD) $(FIRMWARE_OBJS) $(TEST_OBJS) firmware/sections.lds
	$(RV32_GCC) -Os -ffreestanding -nostdlib -o $@ \
		-Wl,-Bstatic,-T,firmware/sections.lds,-Map,firmware/firmware.map,--strip-debug \
		$(FIRMWARE_OBJS) $(TEST_OBJS) -lgcc

$(BUILD)/firmware.bin: $(BUILD)/firmware
	$(RV32_OBJCOPY) -O binary $< $@

$(TARGET): $(BUILD)/firmware.bin
	python3 ../../script/convert_bin_to_memh.py --bin $< > $@
