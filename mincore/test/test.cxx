#include "Vtest_top.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv, char** envp) {
  Verilated::commandArgs(argc, argv);
#ifdef ENABLE_VCD_TRACE
  Verilated::traceEverOn(true);
  VerilatedVcdC* vcdFp = new VerilatedVcdC;
#endif
  Vtest_top* mincore = new Vtest_top;
#ifdef ENABLE_VCD_TRACE
  mincore->trace(vcdFp, 99);
  vcdFp->open("test_ops.vcd");
#endif

  vluint64_t time = 0;
  while (!Verilated::gotFinish()) {
    mincore->rst = (time < 75) ? 1 : 0;
    if (time % 100 == 0)
      mincore->clk = 0;
    if (time % 100 == 50)
      mincore->clk = 1;

    mincore->eval();
#ifdef ENABLE_VCD_TRACE
    vcdFp->dump(time);
#endif
    time += 50;
  }

  delete mincore;
#ifdef ENABLE_VCD_TRACE
  vcdFp->close();
#endif
  
  return 0;
}
