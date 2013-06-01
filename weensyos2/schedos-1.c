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
#define PRIORITY	  1
#endif

void
start(void)
{

	int i;

	#if SCHEDULE_ALGO == 2 || SCHEDULE_ALGO == 1

        sys_user1(PRIORITY);

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
		sys_yield();
	}

	#endif

	#if SYNC == 1

        for (i = 0; i < RUNCOUNT; i++) {
                // Write characters to the console, yielding after each one.
		// Atomically execute print
		// Lock assignement statement
		// After finishing, give up lock
		atomic_swap(&quick_lock, 1);
		atomic_swap((uint32_t *)cursorpos++, PRINTCHAR);
		atomic_swap(&quick_lock, 0);
		sys_yield();
	}

	#endif

        sys_exit(1); // Change: Implemented so schedos-1 does not yield forever.

        // Yield forever.
        while (1)
                sys_yield();

}
