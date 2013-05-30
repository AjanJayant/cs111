#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif

void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
		sys_yield();
	}
	
	#if SCHEDULE_ALGO == 1

        sys_exit(1); // Change: Implemented so schedos-1 does not yield forever.

	#endif

	#if SCHEDULE_ALGO == 2

	sys_user1();
		
	#endif

	// Will never reach here if CURRENT_PART == 1
	// Yield forever.
	while (1)
		sys_yield();
}
