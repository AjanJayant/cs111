
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
  100014:	e8 3d 02 00 00       	call   100256 <start>
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
  10009c:	8b 15 48 72 10 00    	mov    0x107248,%edx
  1000a2:	b8 01 00 00 00       	mov    $0x1,%eax
  1000a7:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  1000ad:	7e 08                	jle    1000b7 <find_highest+0x1b>
  1000af:	83 c8 ff             	or     $0xffffffff,%eax
  1000b2:	ba 0f 27 00 00       	mov    $0x270f,%edx
  1000b7:	8b 0d 9c 72 10 00    	mov    0x10729c,%ecx
  1000bd:	39 d1                	cmp    %edx,%ecx
  1000bf:	7f 07                	jg     1000c8 <find_highest+0x2c>
  1000c1:	89 ca                	mov    %ecx,%edx
  1000c3:	b8 02 00 00 00       	mov    $0x2,%eax
  1000c8:	8b 0d f0 72 10 00    	mov    0x1072f0,%ecx
  1000ce:	39 d1                	cmp    %edx,%ecx
  1000d0:	7f 07                	jg     1000d9 <find_highest+0x3d>
  1000d2:	89 ca                	mov    %ecx,%edx
  1000d4:	b8 03 00 00 00       	mov    $0x3,%eax
  1000d9:	39 15 44 73 10 00    	cmp    %edx,0x107344
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
  1000eb:	a1 b0 7b 10 00       	mov    0x107bb0,%eax
  1000f0:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000f2:	a1 b4 7b 10 00       	mov    0x107bb4,%eax
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
  100109:	83 b8 ec 71 10 00 01 	cmpl   $0x1,0x1071ec(%eax)
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
  10011c:	83 3d 40 72 10 00 01 	cmpl   $0x1,0x107240
  100123:	74 25                	je     10014a <schedule+0x63>
  100125:	83 3d 94 72 10 00 01 	cmpl   $0x1,0x107294
  10012c:	b0 02                	mov    $0x2,%al
  10012e:	74 1a                	je     10014a <schedule+0x63>
  100130:	83 3d e8 72 10 00 01 	cmpl   $0x1,0x1072e8
  100137:	b0 03                	mov    $0x3,%al
  100139:	74 0f                	je     10014a <schedule+0x63>
  10013b:	83 3d 3c 73 10 00 01 	cmpl   $0x1,0x10733c
  100142:	0f 85 8e 00 00 00    	jne    1001d6 <schedule+0xef>
  100148:	b0 04                	mov    $0x4,%al
				run(&proc_array[priority_pid]);
  10014a:	6b c0 54             	imul   $0x54,%eax,%eax
  10014d:	83 ec 0c             	sub    $0xc,%esp
  100150:	05 a4 71 10 00       	add    $0x1071a4,%eax
  100155:	50                   	push   %eax
  100156:	e8 0e 04 00 00       	call   100569 <run>
	// If the scheduling_algorithm variable is equal to 2, call the
	// find_highest function. If it returns -1, all processes have
	// completed and we can return.
	// Otherwise run process specified by the highst priority.
	// If dead mark as such and find next highest priority.
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
  10016f:	8b 9b f4 71 10 00    	mov    0x1071f4(%ebx),%ebx
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
	// Otherwise run process specified by the highst priority.
	// If dead mark as such and find next highest priority.
	else if (scheduling_algorithm == 2) 
		while(1) {
			pid_t priority_pid = find_highest();
			if(priority_pid == -1)
  100183:	83 fa ff             	cmp    $0xffffffff,%edx
  100186:	74 4e                	je     1001d6 <schedule+0xef>
				return;
			if(proc_array[priority_pid].p_state == P_RUNNABLE) 				{
  100188:	6b d2 54             	imul   $0x54,%edx,%edx
  10018b:	83 ba ec 71 10 00 01 	cmpl   $0x1,0x1071ec(%edx)
  100192:	8d 82 a4 71 10 00    	lea    0x1071a4(%edx),%eax
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
  1001bc:	68 28 0b 10 00       	push   $0x100b28
  1001c1:	68 00 01 00 00       	push   $0x100
  1001c6:	52                   	push   %edx
  1001c7:	e8 42 09 00 00       	call   100b0e <console_printf>
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
  1001db:	8b 3d b0 7b 10 00    	mov    0x107bb0,%edi
  1001e1:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001e6:	56                   	push   %esi
  1001e7:	53                   	push   %ebx
  1001e8:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001ec:	83 c7 04             	add    $0x4,%edi
  1001ef:	89 de                	mov    %ebx,%esi
  1001f1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001f3:	8b 43 28             	mov    0x28(%ebx),%eax
  1001f6:	83 f8 31             	cmp    $0x31,%eax
  1001f9:	74 1f                	je     10021a <interrupt+0x40>
  1001fb:	77 0c                	ja     100209 <interrupt+0x2f>
  1001fd:	83 f8 20             	cmp    $0x20,%eax
  100200:	74 4d                	je     10024f <interrupt+0x75>
  100202:	83 f8 30             	cmp    $0x30,%eax
  100205:	74 0e                	je     100215 <interrupt+0x3b>
  100207:	eb 4b                	jmp    100254 <interrupt+0x7a>
  100209:	83 f8 32             	cmp    $0x32,%eax
  10020c:	74 23                	je     100231 <interrupt+0x57>
  10020e:	83 f8 33             	cmp    $0x33,%eax
  100211:	74 2e                	je     100241 <interrupt+0x67>
  100213:	eb 3f                	jmp    100254 <interrupt+0x7a>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100215:	e8 cd fe ff ff       	call   1000e7 <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10021a:	a1 b0 7b 10 00       	mov    0x107bb0,%eax
		current->p_exit_status = reg->reg_eax;
  10021f:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100222:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100229:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10022c:	e8 b6 fe ff ff       	call   1000e7 <schedule>
	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* This system call implements the priority scheduling  *
		 * for 4a)						*/
		current->p_priority = reg->reg_eax;
  100231:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100234:	a1 b0 7b 10 00       	mov    0x107bb0,%eax
  100239:	89 50 50             	mov    %edx,0x50(%eax)
		//run(current);
		schedule(); // Run schedule after assigning the value in the reg			    // ister to the current's process descriptor
  10023c:	e8 a6 fe ff ff       	call   1000e7 <schedule>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100241:	83 ec 0c             	sub    $0xc,%esp
  100244:	ff 35 b0 7b 10 00    	pushl  0x107bb0
  10024a:	e8 1a 03 00 00       	call   100569 <run>
		// Atomically execute current process
		#if SYNC == 1
		if (quick_lock == 1)
			run(current);
		#endif
		schedule();
  10024f:	e8 93 fe ff ff       	call   1000e7 <schedule>
  100254:	eb fe                	jmp    100254 <interrupt+0x7a>

00100256 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100256:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100257:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  10025c:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10025d:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10025f:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100260:	bb f8 71 10 00       	mov    $0x1071f8,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100265:	e8 de 00 00 00       	call   100348 <segments_init>

	#if SCHEDULE_ALGO == 1 || SCHEDULE_ALGO == 2

	interrupt_controller_init(0);
  10026a:	83 ec 0c             	sub    $0xc,%esp
  10026d:	6a 00                	push   $0x0
  10026f:	e8 cf 01 00 00       	call   100443 <interrupt_controller_init>

	interrupt_controller_init(1);

	#endif
	
	console_clear();
  100274:	e8 53 02 00 00       	call   1004cc <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100279:	83 c4 0c             	add    $0xc,%esp
  10027c:	68 a4 01 00 00       	push   $0x1a4
  100281:	6a 00                	push   $0x0
  100283:	68 a4 71 10 00       	push   $0x1071a4
  100288:	e8 1f 04 00 00       	call   1006ac <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10028d:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100290:	c7 05 a4 71 10 00 00 	movl   $0x0,0x1071a4
  100297:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10029a:	c7 05 ec 71 10 00 00 	movl   $0x0,0x1071ec
  1002a1:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002a4:	c7 05 f8 71 10 00 01 	movl   $0x1,0x1071f8
  1002ab:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002ae:	c7 05 40 72 10 00 00 	movl   $0x0,0x107240
  1002b5:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002b8:	c7 05 4c 72 10 00 02 	movl   $0x2,0x10724c
  1002bf:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002c2:	c7 05 94 72 10 00 00 	movl   $0x0,0x107294
  1002c9:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002cc:	c7 05 a0 72 10 00 03 	movl   $0x3,0x1072a0
  1002d3:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002d6:	c7 05 e8 72 10 00 00 	movl   $0x0,0x1072e8
  1002dd:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002e0:	c7 05 f4 72 10 00 04 	movl   $0x4,0x1072f4
  1002e7:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002ea:	c7 05 3c 73 10 00 00 	movl   $0x0,0x10733c
  1002f1:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1002f4:	83 ec 0c             	sub    $0xc,%esp
  1002f7:	53                   	push   %ebx
  1002f8:	e8 83 02 00 00       	call   100580 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002fd:	59                   	pop    %ecx
  1002fe:	58                   	pop    %eax
  1002ff:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100302:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100305:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10030b:	50                   	push   %eax
  10030c:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10030d:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10030e:	e8 a9 02 00 00       	call   1005bc <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100313:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100316:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  10031d:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100320:	83 fe 04             	cmp    $0x4,%esi
  100323:	75 cf                	jne    1002f4 <start+0x9e>
	#if SCHEDULE_ALGO == 2
	scheduling_algorithm = 2;
	#endif

	// Switch to the first process.
	run(&proc_array[1]);
  100325:	83 ec 0c             	sub    $0xc,%esp
  100328:	68 f8 71 10 00       	push   $0x1071f8

	#endif

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10032d:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100334:	80 0b 00 
	#if SCHEDULE_ALGO == 1
	scheduling_algorithm = 1;
	#endif

	#if SCHEDULE_ALGO == 2
	scheduling_algorithm = 2;
  100337:	c7 05 b4 7b 10 00 02 	movl   $0x2,0x107bb4
  10033e:	00 00 00 
	#endif

	// Switch to the first process.
	run(&proc_array[1]);
  100341:	e8 23 02 00 00       	call   100569 <run>
  100346:	90                   	nop
  100347:	90                   	nop

00100348 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100348:	b8 48 73 10 00       	mov    $0x107348,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10034d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100352:	89 c2                	mov    %eax,%edx
  100354:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100357:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100358:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  10035d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100360:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100366:	c1 e8 18             	shr    $0x18,%eax
  100369:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10036f:	ba b0 73 10 00       	mov    $0x1073b0,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100374:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100379:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10037b:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  100382:	68 00 
  100384:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10038b:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100392:	c7 05 4c 73 10 00 00 	movl   $0x180000,0x10734c
  100399:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10039c:	66 c7 05 50 73 10 00 	movw   $0x10,0x107350
  1003a3:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a5:	66 89 0c c5 b0 73 10 	mov    %cx,0x1073b0(,%eax,8)
  1003ac:	00 
  1003ad:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003b4:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003b9:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003be:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003c3:	40                   	inc    %eax
  1003c4:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003c9:	75 da                	jne    1003a5 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003cb:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003d0:	ba b0 73 10 00       	mov    $0x1073b0,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003d5:	66 a3 b0 74 10 00    	mov    %ax,0x1074b0
  1003db:	c1 e8 10             	shr    $0x10,%eax
  1003de:	66 a3 b6 74 10 00    	mov    %ax,0x1074b6
  1003e4:	b8 30 00 00 00       	mov    $0x30,%eax
  1003e9:	66 c7 05 b2 74 10 00 	movw   $0x8,0x1074b2
  1003f0:	08 00 
  1003f2:	c6 05 b4 74 10 00 00 	movb   $0x0,0x1074b4
  1003f9:	c6 05 b5 74 10 00 8e 	movb   $0x8e,0x1074b5

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100400:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100407:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10040e:	66 89 0c c5 b0 73 10 	mov    %cx,0x1073b0(,%eax,8)
  100415:	00 
  100416:	c1 e9 10             	shr    $0x10,%ecx
  100419:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10041e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100423:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100428:	40                   	inc    %eax
  100429:	83 f8 3a             	cmp    $0x3a,%eax
  10042c:	75 d2                	jne    100400 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10042e:	b0 28                	mov    $0x28,%al
  100430:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100437:	0f 00 d8             	ltr    %ax
  10043a:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100441:	5b                   	pop    %ebx
  100442:	c3                   	ret    

00100443 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100443:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100444:	b0 ff                	mov    $0xff,%al
  100446:	57                   	push   %edi
  100447:	56                   	push   %esi
  100448:	53                   	push   %ebx
  100449:	bb 21 00 00 00       	mov    $0x21,%ebx
  10044e:	89 da                	mov    %ebx,%edx
  100450:	ee                   	out    %al,(%dx)
  100451:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100456:	89 ca                	mov    %ecx,%edx
  100458:	ee                   	out    %al,(%dx)
  100459:	be 11 00 00 00       	mov    $0x11,%esi
  10045e:	bf 20 00 00 00       	mov    $0x20,%edi
  100463:	89 f0                	mov    %esi,%eax
  100465:	89 fa                	mov    %edi,%edx
  100467:	ee                   	out    %al,(%dx)
  100468:	b0 20                	mov    $0x20,%al
  10046a:	89 da                	mov    %ebx,%edx
  10046c:	ee                   	out    %al,(%dx)
  10046d:	b0 04                	mov    $0x4,%al
  10046f:	ee                   	out    %al,(%dx)
  100470:	b0 03                	mov    $0x3,%al
  100472:	ee                   	out    %al,(%dx)
  100473:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100478:	89 f0                	mov    %esi,%eax
  10047a:	89 ea                	mov    %ebp,%edx
  10047c:	ee                   	out    %al,(%dx)
  10047d:	b0 28                	mov    $0x28,%al
  10047f:	89 ca                	mov    %ecx,%edx
  100481:	ee                   	out    %al,(%dx)
  100482:	b0 02                	mov    $0x2,%al
  100484:	ee                   	out    %al,(%dx)
  100485:	b0 01                	mov    $0x1,%al
  100487:	ee                   	out    %al,(%dx)
  100488:	b0 68                	mov    $0x68,%al
  10048a:	89 fa                	mov    %edi,%edx
  10048c:	ee                   	out    %al,(%dx)
  10048d:	be 0a 00 00 00       	mov    $0xa,%esi
  100492:	89 f0                	mov    %esi,%eax
  100494:	ee                   	out    %al,(%dx)
  100495:	b0 68                	mov    $0x68,%al
  100497:	89 ea                	mov    %ebp,%edx
  100499:	ee                   	out    %al,(%dx)
  10049a:	89 f0                	mov    %esi,%eax
  10049c:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  10049d:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004a2:	89 da                	mov    %ebx,%edx
  1004a4:	19 c0                	sbb    %eax,%eax
  1004a6:	f7 d0                	not    %eax
  1004a8:	05 ff 00 00 00       	add    $0xff,%eax
  1004ad:	ee                   	out    %al,(%dx)
  1004ae:	b0 ff                	mov    $0xff,%al
  1004b0:	89 ca                	mov    %ecx,%edx
  1004b2:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004b3:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004b8:	74 0d                	je     1004c7 <interrupt_controller_init+0x84>
  1004ba:	b2 43                	mov    $0x43,%dl
  1004bc:	b0 34                	mov    $0x34,%al
  1004be:	ee                   	out    %al,(%dx)
  1004bf:	b0 9c                	mov    $0x9c,%al
  1004c1:	b2 40                	mov    $0x40,%dl
  1004c3:	ee                   	out    %al,(%dx)
  1004c4:	b0 2e                	mov    $0x2e,%al
  1004c6:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004c7:	5b                   	pop    %ebx
  1004c8:	5e                   	pop    %esi
  1004c9:	5f                   	pop    %edi
  1004ca:	5d                   	pop    %ebp
  1004cb:	c3                   	ret    

001004cc <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004cc:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004cd:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004cf:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004d0:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004d7:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1004da:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1004e0:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1004e6:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004e9:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1004ee:	75 ea                	jne    1004da <console_clear+0xe>
  1004f0:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004f5:	b0 0e                	mov    $0xe,%al
  1004f7:	89 f2                	mov    %esi,%edx
  1004f9:	ee                   	out    %al,(%dx)
  1004fa:	31 c9                	xor    %ecx,%ecx
  1004fc:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100501:	88 c8                	mov    %cl,%al
  100503:	89 da                	mov    %ebx,%edx
  100505:	ee                   	out    %al,(%dx)
  100506:	b0 0f                	mov    $0xf,%al
  100508:	89 f2                	mov    %esi,%edx
  10050a:	ee                   	out    %al,(%dx)
  10050b:	88 c8                	mov    %cl,%al
  10050d:	89 da                	mov    %ebx,%edx
  10050f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100510:	5b                   	pop    %ebx
  100511:	5e                   	pop    %esi
  100512:	c3                   	ret    

00100513 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100513:	ba 64 00 00 00       	mov    $0x64,%edx
  100518:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100519:	a8 01                	test   $0x1,%al
  10051b:	74 45                	je     100562 <console_read_digit+0x4f>
  10051d:	b2 60                	mov    $0x60,%dl
  10051f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100520:	8d 50 fe             	lea    -0x2(%eax),%edx
  100523:	80 fa 08             	cmp    $0x8,%dl
  100526:	77 05                	ja     10052d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100528:	0f b6 c0             	movzbl %al,%eax
  10052b:	48                   	dec    %eax
  10052c:	c3                   	ret    
	else if (data == 0x0B)
  10052d:	3c 0b                	cmp    $0xb,%al
  10052f:	74 35                	je     100566 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100531:	8d 50 b9             	lea    -0x47(%eax),%edx
  100534:	80 fa 02             	cmp    $0x2,%dl
  100537:	77 07                	ja     100540 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100539:	0f b6 c0             	movzbl %al,%eax
  10053c:	83 e8 40             	sub    $0x40,%eax
  10053f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100540:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100543:	80 fa 02             	cmp    $0x2,%dl
  100546:	77 07                	ja     10054f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100548:	0f b6 c0             	movzbl %al,%eax
  10054b:	83 e8 47             	sub    $0x47,%eax
  10054e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10054f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100552:	80 fa 02             	cmp    $0x2,%dl
  100555:	77 07                	ja     10055e <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100557:	0f b6 c0             	movzbl %al,%eax
  10055a:	83 e8 4e             	sub    $0x4e,%eax
  10055d:	c3                   	ret    
	else if (data == 0x53)
  10055e:	3c 53                	cmp    $0x53,%al
  100560:	74 04                	je     100566 <console_read_digit+0x53>
  100562:	83 c8 ff             	or     $0xffffffff,%eax
  100565:	c3                   	ret    
  100566:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100568:	c3                   	ret    

00100569 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100569:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  10056d:	a3 b0 7b 10 00       	mov    %eax,0x107bb0

	asm volatile("movl %0,%%esp\n\t"
  100572:	83 c0 04             	add    $0x4,%eax
  100575:	89 c4                	mov    %eax,%esp
  100577:	61                   	popa   
  100578:	07                   	pop    %es
  100579:	1f                   	pop    %ds
  10057a:	83 c4 08             	add    $0x8,%esp
  10057d:	cf                   	iret   
  10057e:	eb fe                	jmp    10057e <run+0x15>

00100580 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100580:	53                   	push   %ebx
  100581:	83 ec 0c             	sub    $0xc,%esp
  100584:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100588:	6a 44                	push   $0x44
  10058a:	6a 00                	push   $0x0
  10058c:	8d 43 04             	lea    0x4(%ebx),%eax
  10058f:	50                   	push   %eax
  100590:	e8 17 01 00 00       	call   1006ac <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100595:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10059b:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005a1:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005a7:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005ad:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1005b4:	83 c4 18             	add    $0x18,%esp
  1005b7:	5b                   	pop    %ebx
  1005b8:	c3                   	ret    
  1005b9:	90                   	nop
  1005ba:	90                   	nop
  1005bb:	90                   	nop

001005bc <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005bc:	55                   	push   %ebp
  1005bd:	57                   	push   %edi
  1005be:	56                   	push   %esi
  1005bf:	53                   	push   %ebx
  1005c0:	83 ec 1c             	sub    $0x1c,%esp
  1005c3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005c7:	83 f8 03             	cmp    $0x3,%eax
  1005ca:	7f 04                	jg     1005d0 <program_loader+0x14>
  1005cc:	85 c0                	test   %eax,%eax
  1005ce:	79 02                	jns    1005d2 <program_loader+0x16>
  1005d0:	eb fe                	jmp    1005d0 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1005d2:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1005d9:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1005df:	74 02                	je     1005e3 <program_loader+0x27>
  1005e1:	eb fe                	jmp    1005e1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005e3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1005e6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005ea:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005ec:	c1 e5 05             	shl    $0x5,%ebp
  1005ef:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1005f2:	eb 3f                	jmp    100633 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005f4:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005f7:	75 37                	jne    100630 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1005f9:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005fc:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005ff:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100602:	01 c7                	add    %eax,%edi
	memsz += va;
  100604:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100606:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10060b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10060f:	52                   	push   %edx
  100610:	89 fa                	mov    %edi,%edx
  100612:	29 c2                	sub    %eax,%edx
  100614:	52                   	push   %edx
  100615:	8b 53 04             	mov    0x4(%ebx),%edx
  100618:	01 f2                	add    %esi,%edx
  10061a:	52                   	push   %edx
  10061b:	50                   	push   %eax
  10061c:	e8 27 00 00 00       	call   100648 <memcpy>
  100621:	83 c4 10             	add    $0x10,%esp
  100624:	eb 04                	jmp    10062a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100626:	c6 07 00             	movb   $0x0,(%edi)
  100629:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10062a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10062e:	72 f6                	jb     100626 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100630:	83 c3 20             	add    $0x20,%ebx
  100633:	39 eb                	cmp    %ebp,%ebx
  100635:	72 bd                	jb     1005f4 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100637:	8b 56 18             	mov    0x18(%esi),%edx
  10063a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10063e:	89 10                	mov    %edx,(%eax)
}
  100640:	83 c4 1c             	add    $0x1c,%esp
  100643:	5b                   	pop    %ebx
  100644:	5e                   	pop    %esi
  100645:	5f                   	pop    %edi
  100646:	5d                   	pop    %ebp
  100647:	c3                   	ret    

00100648 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100648:	56                   	push   %esi
  100649:	31 d2                	xor    %edx,%edx
  10064b:	53                   	push   %ebx
  10064c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100650:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100654:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100658:	eb 08                	jmp    100662 <memcpy+0x1a>
		*d++ = *s++;
  10065a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10065d:	4e                   	dec    %esi
  10065e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100661:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100662:	85 f6                	test   %esi,%esi
  100664:	75 f4                	jne    10065a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100666:	5b                   	pop    %ebx
  100667:	5e                   	pop    %esi
  100668:	c3                   	ret    

00100669 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100669:	57                   	push   %edi
  10066a:	56                   	push   %esi
  10066b:	53                   	push   %ebx
  10066c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100670:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100674:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100678:	39 c7                	cmp    %eax,%edi
  10067a:	73 26                	jae    1006a2 <memmove+0x39>
  10067c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10067f:	39 c6                	cmp    %eax,%esi
  100681:	76 1f                	jbe    1006a2 <memmove+0x39>
		s += n, d += n;
  100683:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100686:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100688:	eb 07                	jmp    100691 <memmove+0x28>
			*--d = *--s;
  10068a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10068d:	4a                   	dec    %edx
  10068e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100691:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100692:	85 d2                	test   %edx,%edx
  100694:	75 f4                	jne    10068a <memmove+0x21>
  100696:	eb 10                	jmp    1006a8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100698:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10069b:	4a                   	dec    %edx
  10069c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10069f:	41                   	inc    %ecx
  1006a0:	eb 02                	jmp    1006a4 <memmove+0x3b>
  1006a2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006a4:	85 d2                	test   %edx,%edx
  1006a6:	75 f0                	jne    100698 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006a8:	5b                   	pop    %ebx
  1006a9:	5e                   	pop    %esi
  1006aa:	5f                   	pop    %edi
  1006ab:	c3                   	ret    

001006ac <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006ac:	53                   	push   %ebx
  1006ad:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006b1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006b5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006b9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006bb:	eb 04                	jmp    1006c1 <memset+0x15>
		*p++ = c;
  1006bd:	88 1a                	mov    %bl,(%edx)
  1006bf:	49                   	dec    %ecx
  1006c0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006c1:	85 c9                	test   %ecx,%ecx
  1006c3:	75 f8                	jne    1006bd <memset+0x11>
		*p++ = c;
	return v;
}
  1006c5:	5b                   	pop    %ebx
  1006c6:	c3                   	ret    

001006c7 <strlen>:

size_t
strlen(const char *s)
{
  1006c7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006cb:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006cd:	eb 01                	jmp    1006d0 <strlen+0x9>
		++n;
  1006cf:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006d0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1006d4:	75 f9                	jne    1006cf <strlen+0x8>
		++n;
	return n;
}
  1006d6:	c3                   	ret    

001006d7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1006d7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1006db:	31 c0                	xor    %eax,%eax
  1006dd:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006e1:	eb 01                	jmp    1006e4 <strnlen+0xd>
		++n;
  1006e3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006e4:	39 d0                	cmp    %edx,%eax
  1006e6:	74 06                	je     1006ee <strnlen+0x17>
  1006e8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006ec:	75 f5                	jne    1006e3 <strnlen+0xc>
		++n;
	return n;
}
  1006ee:	c3                   	ret    

001006ef <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006ef:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1006f0:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006f5:	53                   	push   %ebx
  1006f6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1006f8:	76 05                	jbe    1006ff <console_putc+0x10>
  1006fa:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006ff:	80 fa 0a             	cmp    $0xa,%dl
  100702:	75 2c                	jne    100730 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100704:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10070a:	be 50 00 00 00       	mov    $0x50,%esi
  10070f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100711:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100714:	99                   	cltd   
  100715:	f7 fe                	idiv   %esi
  100717:	89 de                	mov    %ebx,%esi
  100719:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10071b:	eb 07                	jmp    100724 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10071d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100720:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100721:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100724:	83 f8 50             	cmp    $0x50,%eax
  100727:	75 f4                	jne    10071d <console_putc+0x2e>
  100729:	29 d0                	sub    %edx,%eax
  10072b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10072e:	eb 0b                	jmp    10073b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100730:	0f b6 d2             	movzbl %dl,%edx
  100733:	09 ca                	or     %ecx,%edx
  100735:	66 89 13             	mov    %dx,(%ebx)
  100738:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10073b:	5b                   	pop    %ebx
  10073c:	5e                   	pop    %esi
  10073d:	c3                   	ret    

0010073e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10073e:	56                   	push   %esi
  10073f:	53                   	push   %ebx
  100740:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100744:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100747:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10074b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100750:	75 04                	jne    100756 <fill_numbuf+0x18>
  100752:	85 d2                	test   %edx,%edx
  100754:	74 10                	je     100766 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100756:	89 d0                	mov    %edx,%eax
  100758:	31 d2                	xor    %edx,%edx
  10075a:	f7 f1                	div    %ecx
  10075c:	4b                   	dec    %ebx
  10075d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100760:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100762:	89 c2                	mov    %eax,%edx
  100764:	eb ec                	jmp    100752 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100766:	89 d8                	mov    %ebx,%eax
  100768:	5b                   	pop    %ebx
  100769:	5e                   	pop    %esi
  10076a:	c3                   	ret    

0010076b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10076b:	55                   	push   %ebp
  10076c:	57                   	push   %edi
  10076d:	56                   	push   %esi
  10076e:	53                   	push   %ebx
  10076f:	83 ec 38             	sub    $0x38,%esp
  100772:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100776:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10077a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10077e:	e9 60 03 00 00       	jmp    100ae3 <console_vprintf+0x378>
		if (*format != '%') {
  100783:	80 fa 25             	cmp    $0x25,%dl
  100786:	74 13                	je     10079b <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100788:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10078c:	0f b6 d2             	movzbl %dl,%edx
  10078f:	89 f0                	mov    %esi,%eax
  100791:	e8 59 ff ff ff       	call   1006ef <console_putc>
  100796:	e9 45 03 00 00       	jmp    100ae0 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10079b:	47                   	inc    %edi
  10079c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007a3:	00 
  1007a4:	eb 12                	jmp    1007b8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007a6:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007a7:	8a 11                	mov    (%ecx),%dl
  1007a9:	84 d2                	test   %dl,%dl
  1007ab:	74 1a                	je     1007c7 <console_vprintf+0x5c>
  1007ad:	89 e8                	mov    %ebp,%eax
  1007af:	38 c2                	cmp    %al,%dl
  1007b1:	75 f3                	jne    1007a6 <console_vprintf+0x3b>
  1007b3:	e9 3f 03 00 00       	jmp    100af7 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007b8:	8a 17                	mov    (%edi),%dl
  1007ba:	84 d2                	test   %dl,%dl
  1007bc:	74 0b                	je     1007c9 <console_vprintf+0x5e>
  1007be:	b9 4c 0b 10 00       	mov    $0x100b4c,%ecx
  1007c3:	89 d5                	mov    %edx,%ebp
  1007c5:	eb e0                	jmp    1007a7 <console_vprintf+0x3c>
  1007c7:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007c9:	8d 42 cf             	lea    -0x31(%edx),%eax
  1007cc:	3c 08                	cmp    $0x8,%al
  1007ce:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1007d5:	00 
  1007d6:	76 13                	jbe    1007eb <console_vprintf+0x80>
  1007d8:	eb 1d                	jmp    1007f7 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1007da:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1007df:	0f be c0             	movsbl %al,%eax
  1007e2:	47                   	inc    %edi
  1007e3:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1007e7:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1007eb:	8a 07                	mov    (%edi),%al
  1007ed:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007f0:	80 fa 09             	cmp    $0x9,%dl
  1007f3:	76 e5                	jbe    1007da <console_vprintf+0x6f>
  1007f5:	eb 18                	jmp    10080f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007f7:	80 fa 2a             	cmp    $0x2a,%dl
  1007fa:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100801:	ff 
  100802:	75 0b                	jne    10080f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100804:	83 c3 04             	add    $0x4,%ebx
			++format;
  100807:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100808:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10080b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10080f:	83 cd ff             	or     $0xffffffff,%ebp
  100812:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100815:	75 37                	jne    10084e <console_vprintf+0xe3>
			++format;
  100817:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100818:	31 ed                	xor    %ebp,%ebp
  10081a:	8a 07                	mov    (%edi),%al
  10081c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10081f:	80 fa 09             	cmp    $0x9,%dl
  100822:	76 0d                	jbe    100831 <console_vprintf+0xc6>
  100824:	eb 17                	jmp    10083d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100826:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100829:	0f be c0             	movsbl %al,%eax
  10082c:	47                   	inc    %edi
  10082d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100831:	8a 07                	mov    (%edi),%al
  100833:	8d 50 d0             	lea    -0x30(%eax),%edx
  100836:	80 fa 09             	cmp    $0x9,%dl
  100839:	76 eb                	jbe    100826 <console_vprintf+0xbb>
  10083b:	eb 11                	jmp    10084e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10083d:	3c 2a                	cmp    $0x2a,%al
  10083f:	75 0b                	jne    10084c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100841:	83 c3 04             	add    $0x4,%ebx
				++format;
  100844:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100845:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100848:	85 ed                	test   %ebp,%ebp
  10084a:	79 02                	jns    10084e <console_vprintf+0xe3>
  10084c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10084e:	8a 07                	mov    (%edi),%al
  100850:	3c 64                	cmp    $0x64,%al
  100852:	74 34                	je     100888 <console_vprintf+0x11d>
  100854:	7f 1d                	jg     100873 <console_vprintf+0x108>
  100856:	3c 58                	cmp    $0x58,%al
  100858:	0f 84 a2 00 00 00    	je     100900 <console_vprintf+0x195>
  10085e:	3c 63                	cmp    $0x63,%al
  100860:	0f 84 bf 00 00 00    	je     100925 <console_vprintf+0x1ba>
  100866:	3c 43                	cmp    $0x43,%al
  100868:	0f 85 d0 00 00 00    	jne    10093e <console_vprintf+0x1d3>
  10086e:	e9 a3 00 00 00       	jmp    100916 <console_vprintf+0x1ab>
  100873:	3c 75                	cmp    $0x75,%al
  100875:	74 4d                	je     1008c4 <console_vprintf+0x159>
  100877:	3c 78                	cmp    $0x78,%al
  100879:	74 5c                	je     1008d7 <console_vprintf+0x16c>
  10087b:	3c 73                	cmp    $0x73,%al
  10087d:	0f 85 bb 00 00 00    	jne    10093e <console_vprintf+0x1d3>
  100883:	e9 86 00 00 00       	jmp    10090e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100888:	83 c3 04             	add    $0x4,%ebx
  10088b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10088e:	89 d1                	mov    %edx,%ecx
  100890:	c1 f9 1f             	sar    $0x1f,%ecx
  100893:	89 0c 24             	mov    %ecx,(%esp)
  100896:	31 ca                	xor    %ecx,%edx
  100898:	55                   	push   %ebp
  100899:	29 ca                	sub    %ecx,%edx
  10089b:	68 54 0b 10 00       	push   $0x100b54
  1008a0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008a5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008a9:	e8 90 fe ff ff       	call   10073e <fill_numbuf>
  1008ae:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008b2:	58                   	pop    %eax
  1008b3:	5a                   	pop    %edx
  1008b4:	ba 01 00 00 00       	mov    $0x1,%edx
  1008b9:	8b 04 24             	mov    (%esp),%eax
  1008bc:	83 e0 01             	and    $0x1,%eax
  1008bf:	e9 a5 00 00 00       	jmp    100969 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008c4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008c7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008cc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008cf:	55                   	push   %ebp
  1008d0:	68 54 0b 10 00       	push   $0x100b54
  1008d5:	eb 11                	jmp    1008e8 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1008d7:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1008da:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008dd:	55                   	push   %ebp
  1008de:	68 68 0b 10 00       	push   $0x100b68
  1008e3:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008e8:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008ec:	e8 4d fe ff ff       	call   10073e <fill_numbuf>
  1008f1:	ba 01 00 00 00       	mov    $0x1,%edx
  1008f6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1008fa:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008fc:	59                   	pop    %ecx
  1008fd:	59                   	pop    %ecx
  1008fe:	eb 69                	jmp    100969 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100900:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100903:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100906:	55                   	push   %ebp
  100907:	68 54 0b 10 00       	push   $0x100b54
  10090c:	eb d5                	jmp    1008e3 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10090e:	83 c3 04             	add    $0x4,%ebx
  100911:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100914:	eb 40                	jmp    100956 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100916:	83 c3 04             	add    $0x4,%ebx
  100919:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10091c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100920:	e9 bd 01 00 00       	jmp    100ae2 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100925:	83 c3 04             	add    $0x4,%ebx
  100928:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10092b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10092f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100934:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100938:	88 44 24 24          	mov    %al,0x24(%esp)
  10093c:	eb 27                	jmp    100965 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10093e:	84 c0                	test   %al,%al
  100940:	75 02                	jne    100944 <console_vprintf+0x1d9>
  100942:	b0 25                	mov    $0x25,%al
  100944:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100948:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10094d:	80 3f 00             	cmpb   $0x0,(%edi)
  100950:	74 0a                	je     10095c <console_vprintf+0x1f1>
  100952:	8d 44 24 24          	lea    0x24(%esp),%eax
  100956:	89 44 24 04          	mov    %eax,0x4(%esp)
  10095a:	eb 09                	jmp    100965 <console_vprintf+0x1fa>
				format--;
  10095c:	8d 54 24 24          	lea    0x24(%esp),%edx
  100960:	4f                   	dec    %edi
  100961:	89 54 24 04          	mov    %edx,0x4(%esp)
  100965:	31 d2                	xor    %edx,%edx
  100967:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100969:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10096b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10096e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100975:	74 1f                	je     100996 <console_vprintf+0x22b>
  100977:	89 04 24             	mov    %eax,(%esp)
  10097a:	eb 01                	jmp    10097d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10097c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10097d:	39 e9                	cmp    %ebp,%ecx
  10097f:	74 0a                	je     10098b <console_vprintf+0x220>
  100981:	8b 44 24 04          	mov    0x4(%esp),%eax
  100985:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100989:	75 f1                	jne    10097c <console_vprintf+0x211>
  10098b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10098e:	89 0c 24             	mov    %ecx,(%esp)
  100991:	eb 1f                	jmp    1009b2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100993:	42                   	inc    %edx
  100994:	eb 09                	jmp    10099f <console_vprintf+0x234>
  100996:	89 d1                	mov    %edx,%ecx
  100998:	8b 14 24             	mov    (%esp),%edx
  10099b:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10099f:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009a3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009a7:	75 ea                	jne    100993 <console_vprintf+0x228>
  1009a9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009ad:	89 14 24             	mov    %edx,(%esp)
  1009b0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009b2:	85 c0                	test   %eax,%eax
  1009b4:	74 0c                	je     1009c2 <console_vprintf+0x257>
  1009b6:	84 d2                	test   %dl,%dl
  1009b8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009bf:	00 
  1009c0:	75 24                	jne    1009e6 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009c2:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009c7:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1009ce:	00 
  1009cf:	75 15                	jne    1009e6 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1009d1:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009d5:	83 e0 08             	and    $0x8,%eax
  1009d8:	83 f8 01             	cmp    $0x1,%eax
  1009db:	19 c9                	sbb    %ecx,%ecx
  1009dd:	f7 d1                	not    %ecx
  1009df:	83 e1 20             	and    $0x20,%ecx
  1009e2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009e6:	3b 2c 24             	cmp    (%esp),%ebp
  1009e9:	7e 0d                	jle    1009f8 <console_vprintf+0x28d>
  1009eb:	84 d2                	test   %dl,%dl
  1009ed:	74 40                	je     100a2f <console_vprintf+0x2c4>
			zeros = precision - len;
  1009ef:	2b 2c 24             	sub    (%esp),%ebp
  1009f2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009f6:	eb 3f                	jmp    100a37 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009f8:	84 d2                	test   %dl,%dl
  1009fa:	74 33                	je     100a2f <console_vprintf+0x2c4>
  1009fc:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a00:	83 e0 06             	and    $0x6,%eax
  100a03:	83 f8 02             	cmp    $0x2,%eax
  100a06:	75 27                	jne    100a2f <console_vprintf+0x2c4>
  100a08:	45                   	inc    %ebp
  100a09:	75 24                	jne    100a2f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a0b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a0d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a10:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a15:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a18:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a1b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a1f:	7d 0e                	jge    100a2f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a21:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a25:	29 ca                	sub    %ecx,%edx
  100a27:	29 c2                	sub    %eax,%edx
  100a29:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a2d:	eb 08                	jmp    100a37 <console_vprintf+0x2cc>
  100a2f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a36:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a37:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a3b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a3d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a41:	2b 2c 24             	sub    (%esp),%ebp
  100a44:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a49:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a4c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a4f:	29 c5                	sub    %eax,%ebp
  100a51:	89 f0                	mov    %esi,%eax
  100a53:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a57:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a5b:	eb 0f                	jmp    100a6c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a5d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a61:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a66:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a67:	e8 83 fc ff ff       	call   1006ef <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a6c:	85 ed                	test   %ebp,%ebp
  100a6e:	7e 07                	jle    100a77 <console_vprintf+0x30c>
  100a70:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a75:	74 e6                	je     100a5d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a77:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a7c:	89 c6                	mov    %eax,%esi
  100a7e:	74 23                	je     100aa3 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a80:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a85:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a89:	e8 61 fc ff ff       	call   1006ef <console_putc>
  100a8e:	89 c6                	mov    %eax,%esi
  100a90:	eb 11                	jmp    100aa3 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a92:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a96:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a9b:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a9c:	e8 4e fc ff ff       	call   1006ef <console_putc>
  100aa1:	eb 06                	jmp    100aa9 <console_vprintf+0x33e>
  100aa3:	89 f0                	mov    %esi,%eax
  100aa5:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100aa9:	85 f6                	test   %esi,%esi
  100aab:	7f e5                	jg     100a92 <console_vprintf+0x327>
  100aad:	8b 34 24             	mov    (%esp),%esi
  100ab0:	eb 15                	jmp    100ac7 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100ab2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ab6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100ab7:	0f b6 11             	movzbl (%ecx),%edx
  100aba:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100abe:	e8 2c fc ff ff       	call   1006ef <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ac3:	ff 44 24 04          	incl   0x4(%esp)
  100ac7:	85 f6                	test   %esi,%esi
  100ac9:	7f e7                	jg     100ab2 <console_vprintf+0x347>
  100acb:	eb 0f                	jmp    100adc <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100acd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ad1:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100ad6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100ad7:	e8 13 fc ff ff       	call   1006ef <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100adc:	85 ed                	test   %ebp,%ebp
  100ade:	7f ed                	jg     100acd <console_vprintf+0x362>
  100ae0:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100ae2:	47                   	inc    %edi
  100ae3:	8a 17                	mov    (%edi),%dl
  100ae5:	84 d2                	test   %dl,%dl
  100ae7:	0f 85 96 fc ff ff    	jne    100783 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100aed:	83 c4 38             	add    $0x38,%esp
  100af0:	89 f0                	mov    %esi,%eax
  100af2:	5b                   	pop    %ebx
  100af3:	5e                   	pop    %esi
  100af4:	5f                   	pop    %edi
  100af5:	5d                   	pop    %ebp
  100af6:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100af7:	81 e9 4c 0b 10 00    	sub    $0x100b4c,%ecx
  100afd:	b8 01 00 00 00       	mov    $0x1,%eax
  100b02:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b04:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b05:	09 44 24 14          	or     %eax,0x14(%esp)
  100b09:	e9 aa fc ff ff       	jmp    1007b8 <console_vprintf+0x4d>

00100b0e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b0e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b12:	50                   	push   %eax
  100b13:	ff 74 24 10          	pushl  0x10(%esp)
  100b17:	ff 74 24 10          	pushl  0x10(%esp)
  100b1b:	ff 74 24 10          	pushl  0x10(%esp)
  100b1f:	e8 47 fc ff ff       	call   10076b <console_vprintf>
  100b24:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b27:	c3                   	ret    
