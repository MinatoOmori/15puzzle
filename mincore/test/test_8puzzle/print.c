#include "print.h"
#include <stdint.h>

#define OUTPORT 0x10000000

void print_chr(char ch)
{
	*((volatile uint32_t*)OUTPORT) = ch;
}
