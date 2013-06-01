#ifndef WEENSYOS_SCHEDOS_H
#define WEENSYOS_SCHEDOS_H
#include "types.h"

/*****************************************************************************
 * schedos.h
 *
 *   Constants and variables shared by SchedOS's kernel and applications.
 *
 *****************************************************************************/

// System call numbers.
// An application calls a system call by causing the specified interrupt.

#define INT_SYS_YIELD		48
#define INT_SYS_EXIT		49
#define INT_SYS_USER1		50
#define INT_SYS_USER2		51

// Change: Following macro constant defines which part we're working on
#define SCHEDULE_ALGO		2

// Change: Following macro constant defines test cases
#define TEST			0

// Change: Following macro constant defines wether synchronization impl
// mented or not
#define SYNC			0

// The current screen cursor position (stored at memory location 0x198000).

extern uint16_t * volatile cursorpos;

// A locking variable is defined to prevent race conditions.
extern uint32_t quick_lock;

#endif
