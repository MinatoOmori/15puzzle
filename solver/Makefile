TARGET = solver_ida
CFLAGS = -O2

all: $(TARGET)

clean:
	rm -rf $(TARGET)

test: $(TARGET)
	./test_solver.sh

.PHONY: all, clean, test
