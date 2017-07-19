BUILD = build

RV32_GCC =
RV32_OBJCOPY =
include ../../config.mak

TARGET = $(BUILD)/solver_ida.memh
OBJS = $(addprefix $(BUILD)/,start.o print.o solver_ida.o)

all: $(TARGET)

test: $(TARGET)
	./test.sh

clean:
	rm -rf $(BUILD)

.PHONY: all, clean

$(BUILD):
	mkdir -p $@

$(BUILD)/start.o: start.S
	$(RV32_GCC) -c -march=rv32i -o $@ $<

$(BUILD)/%.o: %.c
	$(RV32_GCC) -c -march=rv32i -O2 -std=c99 -ffreestanding -nostdlib -DRISCV_SIM -o $@ $<

$(BUILD)/solver_ida: $(BUILD) $(OBJS) sections.lds
	$(RV32_GCC) -O2 -ffreestanding -nostdlib -o $@ \
		-Wl,-Bstatic,-T,sections.lds,-Map,build/solver_ida.map,--strip-debug \
		$(OBJS) -lgcc

$(BUILD)/solver_ida.bin: $(BUILD)/solver_ida
	$(RV32_OBJCOPY) -O binary $< $@

$(TARGET): $(BUILD)/solver_ida.bin ../../script/convert_bin_to_memh.py
	python3 ../../script/convert_bin_to_memh.py --bin $< > $@
