BUILD_DIR = build
VERILOGC = verilator 
VERILATOR_FLAGS = -Wall -Wno-WIDTH -Wno-UNUSED --cc --trace --Mdir $(BUILD_DIR)
VERILATOR_MAKE_FLAGS = OPT_FAST="-O2"

TEST_TARGET =
VERILATOR_TOP_SRC =
include test/makefile

INCLUDE_DIR = include
SRC_DIR = src
SIMULATOR_SRC_DIR = $(SRC_DIR)/simulator
TEST_SRC_DIR = test

SRC = src/alu.v src/alu_input_mux.v src/data_path.v src/memory_addr_mux.v \
			src/memory_wrap.v src/mincore.v src/register_file.v \
			src/register_write_mux.v src/control.v src/decoder.v \
			src/program_counter_mux.v

SIMULATOR_SRC = src/simulator/dmem.v src/simulator/imem.v

all: test

clean:
	rm -rf $(BUILD_DIR)

test: $(BUILD_DIR)/$(TEST_TARGET)

.PHONY: all, clean, test

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/%: $(TEST_SRC_DIR)/%.cxx $(SRC) $(SIMULATOR_SRC) $(BUILD_DIR)
	$(VERILOGC) $(VERILATOR_FLAGS) -I$(INCLUDE_DIR) $(VERILATOR_TOP_SRC) $(SRC) $(SIMULATOR_SRC) --exe $<
	cd $(BUILD_DIR); make $(VERILATOR_MAKE_FLAGS) -f Vtest_top.mk Vtest_top
