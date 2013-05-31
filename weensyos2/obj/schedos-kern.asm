
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 32 02 00 00       	call   10024b <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 68 01 00 00       	call   1001da <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <find_highest>:
{
	int low_pri = 9999;
	int low_pos = -1;
	pid_t i;
	for(i = 1; i < NPROCS; i++) {
		if(proc_array[i].p_priority <= low_pri) {
  10009c:	8b 15 c8 70 10 00    	mov    0x1070c8,%edx
  1000a2:	b8 01 00 00 00       	mov    $0x1,%eax
  1000a7:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  1000ad:	7e 08                	jle    1000b7 <find_highest+0x1b>
  1000af:	83 c8 ff             	or     $0xffffffff,%eax
  1000b2:	ba 0f 27 00 00       	mov    $0x270f,%edx
  1000b7:	8b 0d 1c 71 10 00    	mov    0x10711c,%ecx
  1000bd:	39 d1                	cmp    %edx,%ecx
  1000bf:	7f 07                	jg     1000c8 <find_highest+0x2c>
  1000c1:	89 ca                	mov    %ecx,%edx
  1000c3:	b8 02 00 00 00       	mov    $0x2,%eax
  1000c8:	8b 0d 70 71 10 00    	mov    0x107170,%ecx
  1000ce:	39 d1                	cmp    %edx,%ecx
  1000d0:	7f 07                	jg     1000d9 <find_highest+0x3d>
  1000d2:	89 ca                	mov    %ecx,%edx
  1000d4:	b8 03 00 00 00       	mov    $0x3,%eax
  1000d9:	39 15 c4 71 10 00    	cmp    %edx,0x1071c4
  1000df:	7f 05                	jg     1000e6 <find_highest+0x4a>
  1000e1:	b8 04 00 00 00       	mov    $0x4,%eax
			low_pri = proc_array[i].p_priority;
			low_pos = i;
		}
	}
	return low_pos;
}
  1000e6:	c3                   	ret    

001000e7 <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  1000e7:	53                   	push   %ebx
  1000e8:	83 ec 08             	sub    $0x8,%esp
	pid_t pid = current->p_pid;
  1000eb:	a1 30 7a 10 00       	mov    0x107a30,%eax
  1000f0:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000f2:	a1 34 7a 10 00       	mov    0x107a34,%eax
  1000f7:	85 c0                	test   %eax,%eax
  1000f9:	75 1c                	jne    100117 <schedule+0x30>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000fb:	b9 05 00 00 00       	mov    $0x5,%ecx
  100100:	8d 42 01             	lea    0x1(%edx),%eax
  100103:	99                   	cltd   
  100104:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  100106:	6b c2 54             	imul   $0x54,%edx,%eax
  100109:	83 b8 6c 70 10 00 01 	cmpl   $0x1,0x10706c(%eax)
  100110:	75 ee                	jne    100100 <schedule+0x19>
				run(&proc_array[pid]);
  100112:	83 ec 0c             	sub    $0xc,%esp
  100115:	eb 39                	jmp    100150 <schedule+0x69>
		}
	
	// Following all changed, implemnts question 2

	else if (scheduling_algorithm == 1) {
  100117:	83 f8 01             	cmp    $0x1,%eax
  10011a:	75 3f                	jne    10015b <schedule+0x74>
		// the process is still runnable, we
		// run the same process. Otherwise, we go to
		// the next process. If the processes exceed
		// NPROCS, we return keeping with style above
		while (1) {
			if(proc_array[priority_pid].p_state == P_RUNNABLE)
  10011c:	83 3d c0 70 10 00 01 	cmpl   $0x1,0x1070c0
  100123:	74 25                	je     10014a <schedule+0x63>
  100125:	83 3d 14 71 10 00 01 	cmpl   $0x1,0x107114
  10012c:	b0 02                	mov    $0x2,%al
  10012e:	74 1a                	je     10014a <schedule+0x63>
  100130:	83 3d 68 71 10 00 01 	cmpl   $0x1,0x107168
  100137:	b0 03                	mov    $0x3,%al
  100139:	74 0f                	je     10014a <schedule+0x63>
  10013b:	83 3d bc 71 10 00 01 	cmpl   $0x1,0x1071bc
  100142:	0f 85 8e 00 00 00    	jne    1001d6 <schedule+0xef>
  100148:	b0 04                	mov    $0x4,%al
				run(&proc_array[priority_pid]);
  10014a:	6b c0 54             	imul   $0x54,%eax,%eax
  10014d:	83 ec 0c             	sub    $0xc,%esp
  100150:	05 24 70 10 00       	add    $0x107024,%eax
  100155:	50                   	push   %eax
  100156:	e8 2a 04 00 00       	call   100585 <run>
				priority_pid++;
			if (priority_pid == NPROCS)
				return;
		}	
	}
	else if (scheduling_algorithm == 2) 
  10015b:	83 f8 02             	cmp    $0x2,%eax
  10015e:	75 55                	jne    1001b5 <schedule+0xce>
  100160:	b0 01                	mov    $0x1,%al
  100162:	83 ca ff             	or     $0xffffffff,%edx
  100165:	b9 0f 27 00 00       	mov    $0x270f,%ecx
  10016a:	eb 12                	jmp    10017e <schedule+0x97>
{
	int low_pri = 9999;
	int low_pos = -1;
	pid_t i;
	for(i = 1; i < NPROCS; i++) {
		if(proc_array[i].p_priority <= low_pri) {
  10016c:	6b d8 54             	imul   $0x54,%eax,%ebx
  10016f:	8b 9b 74 70 10 00    	mov    0x107074(%ebx),%ebx
  100175:	39 cb                	cmp    %ecx,%ebx
  100177:	7f 04                	jg     10017d <schedule+0x96>
  100179:	89 c2                	mov    %eax,%edx
  10017b:	89 d9                	mov    %ebx,%ecx
find_highest()
{
	int low_pri = 9999;
	int low_pos = -1;
	pid_t i;
	for(i = 1; i < NPROCS; i++) {
  10017d:	40                   	inc    %eax
  10017e:	83 f8 04             	cmp    $0x4,%eax
  100181:	7e e9                	jle    10016c <schedule+0x85>
		}	
	}
	else if (scheduling_algorithm == 2) 
		while(1) {
			pid_t priority_pid = find_highest();
			if(priority_pid == -1)
  100183:	83 fa ff             	cmp    $0xffffffff,%edx
  100186:	74 4e                	je     1001d6 <schedule+0xef>
				return;
			if(proc_array[priority_pid].p_state == P_RUNNABLE) 				{
  100188:	6b d2 54             	imul   $0x54,%edx,%edx
  10018b:	83 ba 6c 70 10 00 01 	cmpl   $0x1,0x10706c(%edx)
  100192:	8d 82 24 70 10 00    	lea    0x107024(%edx),%eax
  100198:	75 05                	jne    10019f <schedule+0xb8>
                                run(&proc_array[priority_pid]);
  10019a:	83 ec 0c             	sub    $0xc,%esp
  10019d:	eb b6                	jmp    100155 <schedule+0x6e>
			}	
			else
			{
				proc_array[priority_pid].p_priority = 9999;
  10019f:	c7 40 50 0f 27 00 00 	movl   $0x270f,0x50(%eax)
  1001a6:	83 ca ff             	or     $0xffffffff,%edx
  1001a9:	b8 01 00 00 00       	mov    $0x1,%eax
  1001ae:	b9 0f 27 00 00       	mov    $0x270f,%ecx
  1001b3:	eb b7                	jmp    10016c <schedule+0x85>
			}
		}

	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001b5:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001bb:	50                   	push   %eax
  1001bc:	68 44 0b 10 00       	push   $0x100b44
  1001c1:	68 00 01 00 00       	push   $0x100
  1001c6:	52                   	push   %edx
  1001c7:	e8 5e 09 00 00       	call   100b2a <console_printf>
  1001cc:	83 c4 10             	add    $0x10,%esp
  1001cf:	a3 00 80 19 00       	mov    %eax,0x198000
  1001d4:	eb fe                	jmp    1001d4 <schedule+0xed>
	while (1)
		/* do nothing */;
}
  1001d6:	58                   	pop    %eax
  1001d7:	5a                   	pop    %edx
  1001d8:	5b                   	pop    %ebx
  1001d9:	c3                   	ret    

001001da <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001da:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001db:	a1 30 7a 10 00       	mov    0x107a30,%eax
  1001e0:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001e5:	56                   	push   %esi
  1001e6:	53                   	push   %ebx
  1001e7:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001eb:	8d 78 04             	lea    0x4(%eax),%edi
  1001ee:	89 de                	mov    %ebx,%esi
  1001f0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001f2:	8b 53 28             	mov    0x28(%ebx),%edx
  1001f5:	83 fa 31             	cmp    $0x31,%edx
  1001f8:	74 1f                	je     100219 <interrupt+0x3f>
  1001fa:	77 0c                	ja     100208 <interrupt+0x2e>
  1001fc:	83 fa 20             	cmp    $0x20,%edx
  1001ff:	74 43                	je     100244 <interrupt+0x6a>
  100201:	83 fa 30             	cmp    $0x30,%edx
  100204:	74 0e                	je     100214 <interrupt+0x3a>
  100206:	eb 41                	jmp    100249 <interrupt+0x6f>
  100208:	83 fa 32             	cmp    $0x32,%edx
  10020b:	74 23                	je     100230 <interrupt+0x56>
  10020d:	83 fa 33             	cmp    $0x33,%edx
  100210:	74 29                	je     10023b <interrupt+0x61>
  100212:	eb 35                	jmp    100249 <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100214:	e8 ce fe ff ff       	call   1000e7 <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100219:	a1 30 7a 10 00       	mov    0x107a30,%eax
		current->p_exit_status = reg->reg_eax;
  10021e:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100221:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100228:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10022b:	e8 b7 fe ff ff       	call   1000e7 <schedule>
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* This system call implements the priority scheduling  *
		 * for 4a)						*/
		#if SCHEDULE_ALGO == 2
			current->p_priority = reg->reg_eax;	
  100230:	a1 30 7a 10 00       	mov    0x107a30,%eax
  100235:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100238:	89 50 50             	mov    %edx,0x50(%eax)
		#endif
		run(current);

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  10023b:	83 ec 0c             	sub    $0xc,%esp
  10023e:	50                   	push   %eax
  10023f:	e8 41 03 00 00       	call   100585 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100244:	e8 9e fe ff ff       	call   1000e7 <schedule>
  100249:	eb fe                	jmp    100249 <interrupt+0x6f>

0010024b <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10024b:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10024c:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100251:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100252:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100254:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100255:	bb 78 70 10 00       	mov    $0x107078,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10025a:	e8 05 01 00 00       	call   100364 <segments_init>
	interrupt_controller_init(0);
  10025f:	83 ec 0c             	sub    $0xc,%esp
  100262:	6a 00                	push   $0x0
  100264:	e8 f6 01 00 00       	call   10045f <interrupt_controller_init>
	console_clear();
  100269:	e8 7a 02 00 00       	call   1004e8 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10026e:	83 c4 0c             	add    $0xc,%esp
  100271:	68 a4 01 00 00       	push   $0x1a4
  100276:	6a 00                	push   $0x0
  100278:	68 24 70 10 00       	push   $0x107024
  10027d:	e8 46 04 00 00       	call   1006c8 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100282:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100285:	c7 05 24 70 10 00 00 	movl   $0x0,0x107024
  10028c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10028f:	c7 05 6c 70 10 00 00 	movl   $0x0,0x10706c
  100296:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100299:	c7 05 78 70 10 00 01 	movl   $0x1,0x107078
  1002a0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002a3:	c7 05 c0 70 10 00 00 	movl   $0x0,0x1070c0
  1002aa:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ad:	c7 05 cc 70 10 00 02 	movl   $0x2,0x1070cc
  1002b4:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002b7:	c7 05 14 71 10 00 00 	movl   $0x0,0x107114
  1002be:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002c1:	c7 05 20 71 10 00 03 	movl   $0x3,0x107120
  1002c8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002cb:	c7 05 68 71 10 00 00 	movl   $0x0,0x107168
  1002d2:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002d5:	c7 05 74 71 10 00 04 	movl   $0x4,0x107174
  1002dc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002df:	c7 05 bc 71 10 00 00 	movl   $0x0,0x1071bc
  1002e6:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1002e9:	83 ec 0c             	sub    $0xc,%esp
  1002ec:	53                   	push   %ebx
  1002ed:	e8 aa 02 00 00       	call   10059c <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002f2:	59                   	pop    %ecx
  1002f3:	58                   	pop    %eax
  1002f4:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1002f7:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002fa:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100300:	50                   	push   %eax
  100301:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100302:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100303:	e8 d0 02 00 00       	call   1005d8 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100308:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10030b:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100312:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100315:	83 fe 04             	cmp    $0x4,%esi
  100318:	75 cf                	jne    1002e9 <start+0x9e>
	#if SCHEDULE_ALGO == 2
	scheduling_algorithm = 2;
	#endif

	// Switch to the first process.
	run(&proc_array[1]);
  10031a:	83 ec 0c             	sub    $0xc,%esp
  10031d:	68 78 70 10 00       	push   $0x107078

		//proc->p_priority = i;
	}
	
	
	proc_array[1].p_priority = 3;
  100322:	c7 05 c8 70 10 00 03 	movl   $0x3,0x1070c8
  100329:	00 00 00 
        proc_array[2].p_priority = 1;
  10032c:	c7 05 1c 71 10 00 01 	movl   $0x1,0x10711c
  100333:	00 00 00 
        proc_array[3].p_priority = 4;
  100336:	c7 05 70 71 10 00 04 	movl   $0x4,0x107170
  10033d:	00 00 00 
        proc_array[4].p_priority = 2;
  100340:	c7 05 c4 71 10 00 02 	movl   $0x2,0x1071c4
  100347:	00 00 00 
	

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10034a:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100351:	80 0b 00 
	#if SCHEDULE_ALGO == 1
	scheduling_algorithm = 1;
	#endif

	#if SCHEDULE_ALGO == 2
	scheduling_algorithm = 2;
  100354:	c7 05 34 7a 10 00 02 	movl   $0x2,0x107a34
  10035b:	00 00 00 
	#endif

	// Switch to the first process.
	run(&proc_array[1]);
  10035e:	e8 22 02 00 00       	call   100585 <run>
  100363:	90                   	nop

00100364 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100364:	b8 c8 71 10 00       	mov    $0x1071c8,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100369:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10036e:	89 c2                	mov    %eax,%edx
  100370:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100373:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100374:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100379:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10037c:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100382:	c1 e8 18             	shr    $0x18,%eax
  100385:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10038b:	ba 30 72 10 00       	mov    $0x107230,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100390:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100395:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100397:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10039e:	68 00 
  1003a0:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003a7:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003ae:	c7 05 cc 71 10 00 00 	movl   $0x180000,0x1071cc
  1003b5:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003b8:	66 c7 05 d0 71 10 00 	movw   $0x10,0x1071d0
  1003bf:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003c1:	66 89 0c c5 30 72 10 	mov    %cx,0x107230(,%eax,8)
  1003c8:	00 
  1003c9:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003d0:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003d5:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003da:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003df:	40                   	inc    %eax
  1003e0:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003e5:	75 da                	jne    1003c1 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003e7:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003ec:	ba 30 72 10 00       	mov    $0x107230,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003f1:	66 a3 30 73 10 00    	mov    %ax,0x107330
  1003f7:	c1 e8 10             	shr    $0x10,%eax
  1003fa:	66 a3 36 73 10 00    	mov    %ax,0x107336
  100400:	b8 30 00 00 00       	mov    $0x30,%eax
  100405:	66 c7 05 32 73 10 00 	movw   $0x8,0x107332
  10040c:	08 00 
  10040e:	c6 05 34 73 10 00 00 	movb   $0x0,0x107334
  100415:	c6 05 35 73 10 00 8e 	movb   $0x8e,0x107335

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10041c:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100423:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10042a:	66 89 0c c5 30 72 10 	mov    %cx,0x107230(,%eax,8)
  100431:	00 
  100432:	c1 e9 10             	shr    $0x10,%ecx
  100435:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10043a:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10043f:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100444:	40                   	inc    %eax
  100445:	83 f8 3a             	cmp    $0x3a,%eax
  100448:	75 d2                	jne    10041c <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10044a:	b0 28                	mov    $0x28,%al
  10044c:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100453:	0f 00 d8             	ltr    %ax
  100456:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  10045d:	5b                   	pop    %ebx
  10045e:	c3                   	ret    

0010045f <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10045f:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100460:	b0 ff                	mov    $0xff,%al
  100462:	57                   	push   %edi
  100463:	56                   	push   %esi
  100464:	53                   	push   %ebx
  100465:	bb 21 00 00 00       	mov    $0x21,%ebx
  10046a:	89 da                	mov    %ebx,%edx
  10046c:	ee                   	out    %al,(%dx)
  10046d:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100472:	89 ca                	mov    %ecx,%edx
  100474:	ee                   	out    %al,(%dx)
  100475:	be 11 00 00 00       	mov    $0x11,%esi
  10047a:	bf 20 00 00 00       	mov    $0x20,%edi
  10047f:	89 f0                	mov    %esi,%eax
  100481:	89 fa                	mov    %edi,%edx
  100483:	ee                   	out    %al,(%dx)
  100484:	b0 20                	mov    $0x20,%al
  100486:	89 da                	mov    %ebx,%edx
  100488:	ee                   	out    %al,(%dx)
  100489:	b0 04                	mov    $0x4,%al
  10048b:	ee                   	out    %al,(%dx)
  10048c:	b0 03                	mov    $0x3,%al
  10048e:	ee                   	out    %al,(%dx)
  10048f:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100494:	89 f0                	mov    %esi,%eax
  100496:	89 ea                	mov    %ebp,%edx
  100498:	ee                   	out    %al,(%dx)
  100499:	b0 28                	mov    $0x28,%al
  10049b:	89 ca                	mov    %ecx,%edx
  10049d:	ee                   	out    %al,(%dx)
  10049e:	b0 02                	mov    $0x2,%al
  1004a0:	ee                   	out    %al,(%dx)
  1004a1:	b0 01                	mov    $0x1,%al
  1004a3:	ee                   	out    %al,(%dx)
  1004a4:	b0 68                	mov    $0x68,%al
  1004a6:	89 fa                	mov    %edi,%edx
  1004a8:	ee                   	out    %al,(%dx)
  1004a9:	be 0a 00 00 00       	mov    $0xa,%esi
  1004ae:	89 f0                	mov    %esi,%eax
  1004b0:	ee                   	out    %al,(%dx)
  1004b1:	b0 68                	mov    $0x68,%al
  1004b3:	89 ea                	mov    %ebp,%edx
  1004b5:	ee                   	out    %al,(%dx)
  1004b6:	89 f0                	mov    %esi,%eax
  1004b8:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004b9:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004be:	89 da                	mov    %ebx,%edx
  1004c0:	19 c0                	sbb    %eax,%eax
  1004c2:	f7 d0                	not    %eax
  1004c4:	05 ff 00 00 00       	add    $0xff,%eax
  1004c9:	ee                   	out    %al,(%dx)
  1004ca:	b0 ff                	mov    $0xff,%al
  1004cc:	89 ca                	mov    %ecx,%edx
  1004ce:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004cf:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004d4:	74 0d                	je     1004e3 <interrupt_controller_init+0x84>
  1004d6:	b2 43                	mov    $0x43,%dl
  1004d8:	b0 34                	mov    $0x34,%al
  1004da:	ee                   	out    %al,(%dx)
  1004db:	b0 9c                	mov    $0x9c,%al
  1004dd:	b2 40                	mov    $0x40,%dl
  1004df:	ee                   	out    %al,(%dx)
  1004e0:	b0 2e                	mov    $0x2e,%al
  1004e2:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004e3:	5b                   	pop    %ebx
  1004e4:	5e                   	pop    %esi
  1004e5:	5f                   	pop    %edi
  1004e6:	5d                   	pop    %ebp
  1004e7:	c3                   	ret    

001004e8 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004e8:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004e9:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004eb:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004ec:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004f3:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1004f6:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1004fc:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100502:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100505:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10050a:	75 ea                	jne    1004f6 <console_clear+0xe>
  10050c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100511:	b0 0e                	mov    $0xe,%al
  100513:	89 f2                	mov    %esi,%edx
  100515:	ee                   	out    %al,(%dx)
  100516:	31 c9                	xor    %ecx,%ecx
  100518:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10051d:	88 c8                	mov    %cl,%al
  10051f:	89 da                	mov    %ebx,%edx
  100521:	ee                   	out    %al,(%dx)
  100522:	b0 0f                	mov    $0xf,%al
  100524:	89 f2                	mov    %esi,%edx
  100526:	ee                   	out    %al,(%dx)
  100527:	88 c8                	mov    %cl,%al
  100529:	89 da                	mov    %ebx,%edx
  10052b:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  10052c:	5b                   	pop    %ebx
  10052d:	5e                   	pop    %esi
  10052e:	c3                   	ret    

0010052f <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10052f:	ba 64 00 00 00       	mov    $0x64,%edx
  100534:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100535:	a8 01                	test   $0x1,%al
  100537:	74 45                	je     10057e <console_read_digit+0x4f>
  100539:	b2 60                	mov    $0x60,%dl
  10053b:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  10053c:	8d 50 fe             	lea    -0x2(%eax),%edx
  10053f:	80 fa 08             	cmp    $0x8,%dl
  100542:	77 05                	ja     100549 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100544:	0f b6 c0             	movzbl %al,%eax
  100547:	48                   	dec    %eax
  100548:	c3                   	ret    
	else if (data == 0x0B)
  100549:	3c 0b                	cmp    $0xb,%al
  10054b:	74 35                	je     100582 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  10054d:	8d 50 b9             	lea    -0x47(%eax),%edx
  100550:	80 fa 02             	cmp    $0x2,%dl
  100553:	77 07                	ja     10055c <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100555:	0f b6 c0             	movzbl %al,%eax
  100558:	83 e8 40             	sub    $0x40,%eax
  10055b:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  10055c:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10055f:	80 fa 02             	cmp    $0x2,%dl
  100562:	77 07                	ja     10056b <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100564:	0f b6 c0             	movzbl %al,%eax
  100567:	83 e8 47             	sub    $0x47,%eax
  10056a:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10056b:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10056e:	80 fa 02             	cmp    $0x2,%dl
  100571:	77 07                	ja     10057a <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100573:	0f b6 c0             	movzbl %al,%eax
  100576:	83 e8 4e             	sub    $0x4e,%eax
  100579:	c3                   	ret    
	else if (data == 0x53)
  10057a:	3c 53                	cmp    $0x53,%al
  10057c:	74 04                	je     100582 <console_read_digit+0x53>
  10057e:	83 c8 ff             	or     $0xffffffff,%eax
  100581:	c3                   	ret    
  100582:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100584:	c3                   	ret    

00100585 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100585:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100589:	a3 30 7a 10 00       	mov    %eax,0x107a30

	asm volatile("movl %0,%%esp\n\t"
  10058e:	83 c0 04             	add    $0x4,%eax
  100591:	89 c4                	mov    %eax,%esp
  100593:	61                   	popa   
  100594:	07                   	pop    %es
  100595:	1f                   	pop    %ds
  100596:	83 c4 08             	add    $0x8,%esp
  100599:	cf                   	iret   
  10059a:	eb fe                	jmp    10059a <run+0x15>

0010059c <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10059c:	53                   	push   %ebx
  10059d:	83 ec 0c             	sub    $0xc,%esp
  1005a0:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005a4:	6a 44                	push   $0x44
  1005a6:	6a 00                	push   $0x0
  1005a8:	8d 43 04             	lea    0x4(%ebx),%eax
  1005ab:	50                   	push   %eax
  1005ac:	e8 17 01 00 00       	call   1006c8 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005b1:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005b7:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005bd:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005c3:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005c9:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1005d0:	83 c4 18             	add    $0x18,%esp
  1005d3:	5b                   	pop    %ebx
  1005d4:	c3                   	ret    
  1005d5:	90                   	nop
  1005d6:	90                   	nop
  1005d7:	90                   	nop

001005d8 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005d8:	55                   	push   %ebp
  1005d9:	57                   	push   %edi
  1005da:	56                   	push   %esi
  1005db:	53                   	push   %ebx
  1005dc:	83 ec 1c             	sub    $0x1c,%esp
  1005df:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005e3:	83 f8 03             	cmp    $0x3,%eax
  1005e6:	7f 04                	jg     1005ec <program_loader+0x14>
  1005e8:	85 c0                	test   %eax,%eax
  1005ea:	79 02                	jns    1005ee <program_loader+0x16>
  1005ec:	eb fe                	jmp    1005ec <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1005ee:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1005f5:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1005fb:	74 02                	je     1005ff <program_loader+0x27>
  1005fd:	eb fe                	jmp    1005fd <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005ff:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100602:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100606:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100608:	c1 e5 05             	shl    $0x5,%ebp
  10060b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10060e:	eb 3f                	jmp    10064f <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100610:	83 3b 01             	cmpl   $0x1,(%ebx)
  100613:	75 37                	jne    10064c <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100615:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100618:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10061b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10061e:	01 c7                	add    %eax,%edi
	memsz += va;
  100620:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100622:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100627:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10062b:	52                   	push   %edx
  10062c:	89 fa                	mov    %edi,%edx
  10062e:	29 c2                	sub    %eax,%edx
  100630:	52                   	push   %edx
  100631:	8b 53 04             	mov    0x4(%ebx),%edx
  100634:	01 f2                	add    %esi,%edx
  100636:	52                   	push   %edx
  100637:	50                   	push   %eax
  100638:	e8 27 00 00 00       	call   100664 <memcpy>
  10063d:	83 c4 10             	add    $0x10,%esp
  100640:	eb 04                	jmp    100646 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100642:	c6 07 00             	movb   $0x0,(%edi)
  100645:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100646:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10064a:	72 f6                	jb     100642 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  10064c:	83 c3 20             	add    $0x20,%ebx
  10064f:	39 eb                	cmp    %ebp,%ebx
  100651:	72 bd                	jb     100610 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100653:	8b 56 18             	mov    0x18(%esi),%edx
  100656:	8b 44 24 34          	mov    0x34(%esp),%eax
  10065a:	89 10                	mov    %edx,(%eax)
}
  10065c:	83 c4 1c             	add    $0x1c,%esp
  10065f:	5b                   	pop    %ebx
  100660:	5e                   	pop    %esi
  100661:	5f                   	pop    %edi
  100662:	5d                   	pop    %ebp
  100663:	c3                   	ret    

00100664 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100664:	56                   	push   %esi
  100665:	31 d2                	xor    %edx,%edx
  100667:	53                   	push   %ebx
  100668:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10066c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100670:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100674:	eb 08                	jmp    10067e <memcpy+0x1a>
		*d++ = *s++;
  100676:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100679:	4e                   	dec    %esi
  10067a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10067d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10067e:	85 f6                	test   %esi,%esi
  100680:	75 f4                	jne    100676 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100682:	5b                   	pop    %ebx
  100683:	5e                   	pop    %esi
  100684:	c3                   	ret    

00100685 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100685:	57                   	push   %edi
  100686:	56                   	push   %esi
  100687:	53                   	push   %ebx
  100688:	8b 44 24 10          	mov    0x10(%esp),%eax
  10068c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100690:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100694:	39 c7                	cmp    %eax,%edi
  100696:	73 26                	jae    1006be <memmove+0x39>
  100698:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10069b:	39 c6                	cmp    %eax,%esi
  10069d:	76 1f                	jbe    1006be <memmove+0x39>
		s += n, d += n;
  10069f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006a2:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006a4:	eb 07                	jmp    1006ad <memmove+0x28>
			*--d = *--s;
  1006a6:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006a9:	4a                   	dec    %edx
  1006aa:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006ad:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006ae:	85 d2                	test   %edx,%edx
  1006b0:	75 f4                	jne    1006a6 <memmove+0x21>
  1006b2:	eb 10                	jmp    1006c4 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006b4:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006b7:	4a                   	dec    %edx
  1006b8:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006bb:	41                   	inc    %ecx
  1006bc:	eb 02                	jmp    1006c0 <memmove+0x3b>
  1006be:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006c0:	85 d2                	test   %edx,%edx
  1006c2:	75 f0                	jne    1006b4 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006c4:	5b                   	pop    %ebx
  1006c5:	5e                   	pop    %esi
  1006c6:	5f                   	pop    %edi
  1006c7:	c3                   	ret    

001006c8 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006c8:	53                   	push   %ebx
  1006c9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006cd:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006d1:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006d5:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006d7:	eb 04                	jmp    1006dd <memset+0x15>
		*p++ = c;
  1006d9:	88 1a                	mov    %bl,(%edx)
  1006db:	49                   	dec    %ecx
  1006dc:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006dd:	85 c9                	test   %ecx,%ecx
  1006df:	75 f8                	jne    1006d9 <memset+0x11>
		*p++ = c;
	return v;
}
  1006e1:	5b                   	pop    %ebx
  1006e2:	c3                   	ret    

001006e3 <strlen>:

size_t
strlen(const char *s)
{
  1006e3:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006e7:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006e9:	eb 01                	jmp    1006ec <strlen+0x9>
		++n;
  1006eb:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006ec:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1006f0:	75 f9                	jne    1006eb <strlen+0x8>
		++n;
	return n;
}
  1006f2:	c3                   	ret    

001006f3 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1006f3:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1006f7:	31 c0                	xor    %eax,%eax
  1006f9:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006fd:	eb 01                	jmp    100700 <strnlen+0xd>
		++n;
  1006ff:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100700:	39 d0                	cmp    %edx,%eax
  100702:	74 06                	je     10070a <strnlen+0x17>
  100704:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100708:	75 f5                	jne    1006ff <strnlen+0xc>
		++n;
	return n;
}
  10070a:	c3                   	ret    

0010070b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10070b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10070c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100711:	53                   	push   %ebx
  100712:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100714:	76 05                	jbe    10071b <console_putc+0x10>
  100716:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10071b:	80 fa 0a             	cmp    $0xa,%dl
  10071e:	75 2c                	jne    10074c <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100720:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100726:	be 50 00 00 00       	mov    $0x50,%esi
  10072b:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  10072d:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100730:	99                   	cltd   
  100731:	f7 fe                	idiv   %esi
  100733:	89 de                	mov    %ebx,%esi
  100735:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100737:	eb 07                	jmp    100740 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100739:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10073c:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  10073d:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100740:	83 f8 50             	cmp    $0x50,%eax
  100743:	75 f4                	jne    100739 <console_putc+0x2e>
  100745:	29 d0                	sub    %edx,%eax
  100747:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10074a:	eb 0b                	jmp    100757 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  10074c:	0f b6 d2             	movzbl %dl,%edx
  10074f:	09 ca                	or     %ecx,%edx
  100751:	66 89 13             	mov    %dx,(%ebx)
  100754:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100757:	5b                   	pop    %ebx
  100758:	5e                   	pop    %esi
  100759:	c3                   	ret    

0010075a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10075a:	56                   	push   %esi
  10075b:	53                   	push   %ebx
  10075c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100760:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100763:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100767:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10076c:	75 04                	jne    100772 <fill_numbuf+0x18>
  10076e:	85 d2                	test   %edx,%edx
  100770:	74 10                	je     100782 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100772:	89 d0                	mov    %edx,%eax
  100774:	31 d2                	xor    %edx,%edx
  100776:	f7 f1                	div    %ecx
  100778:	4b                   	dec    %ebx
  100779:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10077c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10077e:	89 c2                	mov    %eax,%edx
  100780:	eb ec                	jmp    10076e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100782:	89 d8                	mov    %ebx,%eax
  100784:	5b                   	pop    %ebx
  100785:	5e                   	pop    %esi
  100786:	c3                   	ret    

00100787 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100787:	55                   	push   %ebp
  100788:	57                   	push   %edi
  100789:	56                   	push   %esi
  10078a:	53                   	push   %ebx
  10078b:	83 ec 38             	sub    $0x38,%esp
  10078e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100792:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100796:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10079a:	e9 60 03 00 00       	jmp    100aff <console_vprintf+0x378>
		if (*format != '%') {
  10079f:	80 fa 25             	cmp    $0x25,%dl
  1007a2:	74 13                	je     1007b7 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007a4:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007a8:	0f b6 d2             	movzbl %dl,%edx
  1007ab:	89 f0                	mov    %esi,%eax
  1007ad:	e8 59 ff ff ff       	call   10070b <console_putc>
  1007b2:	e9 45 03 00 00       	jmp    100afc <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007b7:	47                   	inc    %edi
  1007b8:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007bf:	00 
  1007c0:	eb 12                	jmp    1007d4 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007c2:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007c3:	8a 11                	mov    (%ecx),%dl
  1007c5:	84 d2                	test   %dl,%dl
  1007c7:	74 1a                	je     1007e3 <console_vprintf+0x5c>
  1007c9:	89 e8                	mov    %ebp,%eax
  1007cb:	38 c2                	cmp    %al,%dl
  1007cd:	75 f3                	jne    1007c2 <console_vprintf+0x3b>
  1007cf:	e9 3f 03 00 00       	jmp    100b13 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007d4:	8a 17                	mov    (%edi),%dl
  1007d6:	84 d2                	test   %dl,%dl
  1007d8:	74 0b                	je     1007e5 <console_vprintf+0x5e>
  1007da:	b9 68 0b 10 00       	mov    $0x100b68,%ecx
  1007df:	89 d5                	mov    %edx,%ebp
  1007e1:	eb e0                	jmp    1007c3 <console_vprintf+0x3c>
  1007e3:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007e5:	8d 42 cf             	lea    -0x31(%edx),%eax
  1007e8:	3c 08                	cmp    $0x8,%al
  1007ea:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1007f1:	00 
  1007f2:	76 13                	jbe    100807 <console_vprintf+0x80>
  1007f4:	eb 1d                	jmp    100813 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1007f6:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1007fb:	0f be c0             	movsbl %al,%eax
  1007fe:	47                   	inc    %edi
  1007ff:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100803:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100807:	8a 07                	mov    (%edi),%al
  100809:	8d 50 d0             	lea    -0x30(%eax),%edx
  10080c:	80 fa 09             	cmp    $0x9,%dl
  10080f:	76 e5                	jbe    1007f6 <console_vprintf+0x6f>
  100811:	eb 18                	jmp    10082b <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100813:	80 fa 2a             	cmp    $0x2a,%dl
  100816:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10081d:	ff 
  10081e:	75 0b                	jne    10082b <console_vprintf+0xa4>
			width = va_arg(val, int);
  100820:	83 c3 04             	add    $0x4,%ebx
			++format;
  100823:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100824:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100827:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10082b:	83 cd ff             	or     $0xffffffff,%ebp
  10082e:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100831:	75 37                	jne    10086a <console_vprintf+0xe3>
			++format;
  100833:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100834:	31 ed                	xor    %ebp,%ebp
  100836:	8a 07                	mov    (%edi),%al
  100838:	8d 50 d0             	lea    -0x30(%eax),%edx
  10083b:	80 fa 09             	cmp    $0x9,%dl
  10083e:	76 0d                	jbe    10084d <console_vprintf+0xc6>
  100840:	eb 17                	jmp    100859 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100842:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100845:	0f be c0             	movsbl %al,%eax
  100848:	47                   	inc    %edi
  100849:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  10084d:	8a 07                	mov    (%edi),%al
  10084f:	8d 50 d0             	lea    -0x30(%eax),%edx
  100852:	80 fa 09             	cmp    $0x9,%dl
  100855:	76 eb                	jbe    100842 <console_vprintf+0xbb>
  100857:	eb 11                	jmp    10086a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100859:	3c 2a                	cmp    $0x2a,%al
  10085b:	75 0b                	jne    100868 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10085d:	83 c3 04             	add    $0x4,%ebx
				++format;
  100860:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100861:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100864:	85 ed                	test   %ebp,%ebp
  100866:	79 02                	jns    10086a <console_vprintf+0xe3>
  100868:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10086a:	8a 07                	mov    (%edi),%al
  10086c:	3c 64                	cmp    $0x64,%al
  10086e:	74 34                	je     1008a4 <console_vprintf+0x11d>
  100870:	7f 1d                	jg     10088f <console_vprintf+0x108>
  100872:	3c 58                	cmp    $0x58,%al
  100874:	0f 84 a2 00 00 00    	je     10091c <console_vprintf+0x195>
  10087a:	3c 63                	cmp    $0x63,%al
  10087c:	0f 84 bf 00 00 00    	je     100941 <console_vprintf+0x1ba>
  100882:	3c 43                	cmp    $0x43,%al
  100884:	0f 85 d0 00 00 00    	jne    10095a <console_vprintf+0x1d3>
  10088a:	e9 a3 00 00 00       	jmp    100932 <console_vprintf+0x1ab>
  10088f:	3c 75                	cmp    $0x75,%al
  100891:	74 4d                	je     1008e0 <console_vprintf+0x159>
  100893:	3c 78                	cmp    $0x78,%al
  100895:	74 5c                	je     1008f3 <console_vprintf+0x16c>
  100897:	3c 73                	cmp    $0x73,%al
  100899:	0f 85 bb 00 00 00    	jne    10095a <console_vprintf+0x1d3>
  10089f:	e9 86 00 00 00       	jmp    10092a <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008a4:	83 c3 04             	add    $0x4,%ebx
  1008a7:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008aa:	89 d1                	mov    %edx,%ecx
  1008ac:	c1 f9 1f             	sar    $0x1f,%ecx
  1008af:	89 0c 24             	mov    %ecx,(%esp)
  1008b2:	31 ca                	xor    %ecx,%edx
  1008b4:	55                   	push   %ebp
  1008b5:	29 ca                	sub    %ecx,%edx
  1008b7:	68 70 0b 10 00       	push   $0x100b70
  1008bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008c1:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008c5:	e8 90 fe ff ff       	call   10075a <fill_numbuf>
  1008ca:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008ce:	58                   	pop    %eax
  1008cf:	5a                   	pop    %edx
  1008d0:	ba 01 00 00 00       	mov    $0x1,%edx
  1008d5:	8b 04 24             	mov    (%esp),%eax
  1008d8:	83 e0 01             	and    $0x1,%eax
  1008db:	e9 a5 00 00 00       	jmp    100985 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008e0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008e8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008eb:	55                   	push   %ebp
  1008ec:	68 70 0b 10 00       	push   $0x100b70
  1008f1:	eb 11                	jmp    100904 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1008f3:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1008f6:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008f9:	55                   	push   %ebp
  1008fa:	68 84 0b 10 00       	push   $0x100b84
  1008ff:	b9 10 00 00 00       	mov    $0x10,%ecx
  100904:	8d 44 24 40          	lea    0x40(%esp),%eax
  100908:	e8 4d fe ff ff       	call   10075a <fill_numbuf>
  10090d:	ba 01 00 00 00       	mov    $0x1,%edx
  100912:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100916:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100918:	59                   	pop    %ecx
  100919:	59                   	pop    %ecx
  10091a:	eb 69                	jmp    100985 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  10091c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10091f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100922:	55                   	push   %ebp
  100923:	68 70 0b 10 00       	push   $0x100b70
  100928:	eb d5                	jmp    1008ff <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10092a:	83 c3 04             	add    $0x4,%ebx
  10092d:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100930:	eb 40                	jmp    100972 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100932:	83 c3 04             	add    $0x4,%ebx
  100935:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100938:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  10093c:	e9 bd 01 00 00       	jmp    100afe <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100941:	83 c3 04             	add    $0x4,%ebx
  100944:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100947:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10094b:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100950:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100954:	88 44 24 24          	mov    %al,0x24(%esp)
  100958:	eb 27                	jmp    100981 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10095a:	84 c0                	test   %al,%al
  10095c:	75 02                	jne    100960 <console_vprintf+0x1d9>
  10095e:	b0 25                	mov    $0x25,%al
  100960:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100964:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100969:	80 3f 00             	cmpb   $0x0,(%edi)
  10096c:	74 0a                	je     100978 <console_vprintf+0x1f1>
  10096e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100972:	89 44 24 04          	mov    %eax,0x4(%esp)
  100976:	eb 09                	jmp    100981 <console_vprintf+0x1fa>
				format--;
  100978:	8d 54 24 24          	lea    0x24(%esp),%edx
  10097c:	4f                   	dec    %edi
  10097d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100981:	31 d2                	xor    %edx,%edx
  100983:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100985:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100987:	83 fd ff             	cmp    $0xffffffff,%ebp
  10098a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100991:	74 1f                	je     1009b2 <console_vprintf+0x22b>
  100993:	89 04 24             	mov    %eax,(%esp)
  100996:	eb 01                	jmp    100999 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100998:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100999:	39 e9                	cmp    %ebp,%ecx
  10099b:	74 0a                	je     1009a7 <console_vprintf+0x220>
  10099d:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009a1:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009a5:	75 f1                	jne    100998 <console_vprintf+0x211>
  1009a7:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009aa:	89 0c 24             	mov    %ecx,(%esp)
  1009ad:	eb 1f                	jmp    1009ce <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009af:	42                   	inc    %edx
  1009b0:	eb 09                	jmp    1009bb <console_vprintf+0x234>
  1009b2:	89 d1                	mov    %edx,%ecx
  1009b4:	8b 14 24             	mov    (%esp),%edx
  1009b7:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009bb:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009bf:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009c3:	75 ea                	jne    1009af <console_vprintf+0x228>
  1009c5:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009c9:	89 14 24             	mov    %edx,(%esp)
  1009cc:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009ce:	85 c0                	test   %eax,%eax
  1009d0:	74 0c                	je     1009de <console_vprintf+0x257>
  1009d2:	84 d2                	test   %dl,%dl
  1009d4:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009db:	00 
  1009dc:	75 24                	jne    100a02 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009de:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009e3:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1009ea:	00 
  1009eb:	75 15                	jne    100a02 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1009ed:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009f1:	83 e0 08             	and    $0x8,%eax
  1009f4:	83 f8 01             	cmp    $0x1,%eax
  1009f7:	19 c9                	sbb    %ecx,%ecx
  1009f9:	f7 d1                	not    %ecx
  1009fb:	83 e1 20             	and    $0x20,%ecx
  1009fe:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a02:	3b 2c 24             	cmp    (%esp),%ebp
  100a05:	7e 0d                	jle    100a14 <console_vprintf+0x28d>
  100a07:	84 d2                	test   %dl,%dl
  100a09:	74 40                	je     100a4b <console_vprintf+0x2c4>
			zeros = precision - len;
  100a0b:	2b 2c 24             	sub    (%esp),%ebp
  100a0e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a12:	eb 3f                	jmp    100a53 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a14:	84 d2                	test   %dl,%dl
  100a16:	74 33                	je     100a4b <console_vprintf+0x2c4>
  100a18:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a1c:	83 e0 06             	and    $0x6,%eax
  100a1f:	83 f8 02             	cmp    $0x2,%eax
  100a22:	75 27                	jne    100a4b <console_vprintf+0x2c4>
  100a24:	45                   	inc    %ebp
  100a25:	75 24                	jne    100a4b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a27:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a29:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a2c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a31:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a34:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a37:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a3b:	7d 0e                	jge    100a4b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a3d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a41:	29 ca                	sub    %ecx,%edx
  100a43:	29 c2                	sub    %eax,%edx
  100a45:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a49:	eb 08                	jmp    100a53 <console_vprintf+0x2cc>
  100a4b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a52:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a53:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a57:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a59:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a5d:	2b 2c 24             	sub    (%esp),%ebp
  100a60:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a65:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a68:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a6b:	29 c5                	sub    %eax,%ebp
  100a6d:	89 f0                	mov    %esi,%eax
  100a6f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a73:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a77:	eb 0f                	jmp    100a88 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a79:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a7d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a82:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a83:	e8 83 fc ff ff       	call   10070b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a88:	85 ed                	test   %ebp,%ebp
  100a8a:	7e 07                	jle    100a93 <console_vprintf+0x30c>
  100a8c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a91:	74 e6                	je     100a79 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a93:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a98:	89 c6                	mov    %eax,%esi
  100a9a:	74 23                	je     100abf <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a9c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100aa1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aa5:	e8 61 fc ff ff       	call   10070b <console_putc>
  100aaa:	89 c6                	mov    %eax,%esi
  100aac:	eb 11                	jmp    100abf <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100aae:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ab2:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ab7:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100ab8:	e8 4e fc ff ff       	call   10070b <console_putc>
  100abd:	eb 06                	jmp    100ac5 <console_vprintf+0x33e>
  100abf:	89 f0                	mov    %esi,%eax
  100ac1:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ac5:	85 f6                	test   %esi,%esi
  100ac7:	7f e5                	jg     100aae <console_vprintf+0x327>
  100ac9:	8b 34 24             	mov    (%esp),%esi
  100acc:	eb 15                	jmp    100ae3 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100ace:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ad2:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100ad3:	0f b6 11             	movzbl (%ecx),%edx
  100ad6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ada:	e8 2c fc ff ff       	call   10070b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100adf:	ff 44 24 04          	incl   0x4(%esp)
  100ae3:	85 f6                	test   %esi,%esi
  100ae5:	7f e7                	jg     100ace <console_vprintf+0x347>
  100ae7:	eb 0f                	jmp    100af8 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100ae9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aed:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100af2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100af3:	e8 13 fc ff ff       	call   10070b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100af8:	85 ed                	test   %ebp,%ebp
  100afa:	7f ed                	jg     100ae9 <console_vprintf+0x362>
  100afc:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100afe:	47                   	inc    %edi
  100aff:	8a 17                	mov    (%edi),%dl
  100b01:	84 d2                	test   %dl,%dl
  100b03:	0f 85 96 fc ff ff    	jne    10079f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b09:	83 c4 38             	add    $0x38,%esp
  100b0c:	89 f0                	mov    %esi,%eax
  100b0e:	5b                   	pop    %ebx
  100b0f:	5e                   	pop    %esi
  100b10:	5f                   	pop    %edi
  100b11:	5d                   	pop    %ebp
  100b12:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b13:	81 e9 68 0b 10 00    	sub    $0x100b68,%ecx
  100b19:	b8 01 00 00 00       	mov    $0x1,%eax
  100b1e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b20:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b21:	09 44 24 14          	or     %eax,0x14(%esp)
  100b25:	e9 aa fc ff ff       	jmp    1007d4 <console_vprintf+0x4d>

00100b2a <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b2a:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b2e:	50                   	push   %eax
  100b2f:	ff 74 24 10          	pushl  0x10(%esp)
  100b33:	ff 74 24 10          	pushl  0x10(%esp)
  100b37:	ff 74 24 10          	pushl  0x10(%esp)
  100b3b:	e8 47 fc ff ff       	call   100787 <console_vprintf>
  100b40:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b43:	c3                   	ret    
