
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
  100014:	e8 b0 01 00 00       	call   1001c9 <start>
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
  10006d:	e8 e6 00 00 00       	call   100158 <interrupt>

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

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	56                   	push   %esi
  10009d:	53                   	push   %ebx
  10009e:	83 ec 04             	sub    $0x4,%esp
	pid_t pid = current->p_pid;
  1000a1:	a1 f0 76 10 00       	mov    0x1076f0,%eax
  1000a6:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a8:	a1 f4 76 10 00       	mov    0x1076f4,%eax
  1000ad:	85 c0                	test   %eax,%eax
  1000af:	75 21                	jne    1000d2 <schedule+0x36>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b1:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b6:	8d 42 01             	lea    0x1(%edx),%eax
  1000b9:	99                   	cltd   
  1000ba:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bc:	6b c2 54             	imul   $0x54,%edx,%eax
  1000bf:	83 b8 2c 6d 10 00 01 	cmpl   $0x1,0x106d2c(%eax)
  1000c6:	75 ee                	jne    1000b6 <schedule+0x1a>
				run(&proc_array[pid]);
  1000c8:	83 ec 0c             	sub    $0xc,%esp
  1000cb:	05 e4 6c 10 00       	add    $0x106ce4,%eax
  1000d0:	eb 44                	jmp    100116 <schedule+0x7a>
	// i for looping through each position in th proc_array
	// is_valid to make sure there are any processes left to execute	
	int i, is_valid;
	pid_t priority_pid = 1;
	is_valid = 0;
	if (scheduling_algorithm == 2) {
  1000d2:	83 f8 02             	cmp    $0x2,%eax
  1000d5:	75 5c                	jne    100133 <schedule+0x97>
  1000d7:	b9 01 00 00 00       	mov    $0x1,%ecx
  1000dc:	31 d2                	xor    %edx,%edx
  1000de:	eb 1c                	jmp    1000fc <schedule+0x60>
		while(1) {
			for(i = 2; i < NPROCS; i++) {
			// If we come accross a process_descriptor with a higher			// priority than priority_pid, assign it to priority_pid
				if(proc_array[priority_pid].p_priority > proc_array[i].p_priority) {
  1000e0:	6b f1 54             	imul   $0x54,%ecx,%esi
  1000e3:	6b d8 54             	imul   $0x54,%eax,%ebx
  1000e6:	8b b6 34 6d 10 00    	mov    0x106d34(%esi),%esi
  1000ec:	3b b3 34 6d 10 00    	cmp    0x106d34(%ebx),%esi
  1000f2:	7e 07                	jle    1000fb <schedule+0x5f>
  1000f4:	89 c1                	mov    %eax,%ecx
  1000f6:	ba 01 00 00 00       	mov    $0x1,%edx
	int i, is_valid;
	pid_t priority_pid = 1;
	is_valid = 0;
	if (scheduling_algorithm == 2) {
		while(1) {
			for(i = 2; i < NPROCS; i++) {
  1000fb:	40                   	inc    %eax
  1000fc:	83 f8 04             	cmp    $0x4,%eax
  1000ff:	7e df                	jle    1000e0 <schedule+0x44>
				if(proc_array[priority_pid].p_priority > proc_array[i].p_priority) {
					is_valid = 1;
					priority_pid = i;
				}
			}
                	if(proc_array[priority_pid].p_state == P_RUNNABLE)
  100101:	6b c1 54             	imul   $0x54,%ecx,%eax
  100104:	83 b8 2c 6d 10 00 01 	cmpl   $0x1,0x106d2c(%eax)
  10010b:	8d 80 e4 6c 10 00    	lea    0x106ce4(%eax),%eax
  100111:	75 09                	jne    10011c <schedule+0x80>
                		run(&proc_array[priority_pid]);
  100113:	83 ec 0c             	sub    $0xc,%esp
  100116:	50                   	push   %eax
  100117:	e8 c1 03 00 00       	call   1004dd <run>
               	 	else
                		proc_array[priority_pid].p_priority = 6;
                	if (!is_valid)
  10011c:	85 d2                	test   %edx,%edx
				}
			}
                	if(proc_array[priority_pid].p_state == P_RUNNABLE)
                		run(&proc_array[priority_pid]);
               	 	else
                		proc_array[priority_pid].p_priority = 6;
  10011e:	c7 40 50 06 00 00 00 	movl   $0x6,0x50(%eax)
                	if (!is_valid)
  100125:	74 2d                	je     100154 <schedule+0xb8>
  100127:	ba 01 00 00 00       	mov    $0x1,%edx
  10012c:	b8 02 00 00 00       	mov    $0x2,%eax
  100131:	eb ad                	jmp    1000e0 <schedule+0x44>
                	}
	}

	#endif 	
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100133:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100139:	50                   	push   %eax
  10013a:	68 9c 0a 10 00       	push   $0x100a9c
  10013f:	68 00 01 00 00       	push   $0x100
  100144:	52                   	push   %edx
  100145:	e8 38 09 00 00       	call   100a82 <console_printf>
  10014a:	83 c4 10             	add    $0x10,%esp
  10014d:	a3 00 80 19 00       	mov    %eax,0x198000
  100152:	eb fe                	jmp    100152 <schedule+0xb6>
	while (1)
		/* do nothing */;
}
  100154:	58                   	pop    %eax
  100155:	5b                   	pop    %ebx
  100156:	5e                   	pop    %esi
  100157:	c3                   	ret    

00100158 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100158:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100159:	a1 f0 76 10 00       	mov    0x1076f0,%eax
  10015e:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100163:	56                   	push   %esi
  100164:	53                   	push   %ebx
  100165:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100169:	8d 78 04             	lea    0x4(%eax),%edi
  10016c:	89 de                	mov    %ebx,%esi
  10016e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100170:	8b 53 28             	mov    0x28(%ebx),%edx
  100173:	83 fa 31             	cmp    $0x31,%edx
  100176:	74 1f                	je     100197 <interrupt+0x3f>
  100178:	77 0c                	ja     100186 <interrupt+0x2e>
  10017a:	83 fa 20             	cmp    $0x20,%edx
  10017d:	74 43                	je     1001c2 <interrupt+0x6a>
  10017f:	83 fa 30             	cmp    $0x30,%edx
  100182:	74 0e                	je     100192 <interrupt+0x3a>
  100184:	eb 41                	jmp    1001c7 <interrupt+0x6f>
  100186:	83 fa 32             	cmp    $0x32,%edx
  100189:	74 23                	je     1001ae <interrupt+0x56>
  10018b:	83 fa 33             	cmp    $0x33,%edx
  10018e:	74 29                	je     1001b9 <interrupt+0x61>
  100190:	eb 35                	jmp    1001c7 <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100192:	e8 05 ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100197:	a1 f0 76 10 00       	mov    0x1076f0,%eax
		current->p_exit_status = reg->reg_eax;
  10019c:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10019f:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1001a6:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1001a9:	e8 ee fe ff ff       	call   10009c <schedule>
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* This system call implements the priority scheduling  *
		 * for 4a)						*/
		#if SCHEDULE_ALGO == 2
			current->p_priority = reg->reg_eax;	
  1001ae:	a1 f0 76 10 00       	mov    0x1076f0,%eax
  1001b3:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001b6:	89 50 50             	mov    %edx,0x50(%eax)
		#endif
		run(current);

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1001b9:	83 ec 0c             	sub    $0xc,%esp
  1001bc:	50                   	push   %eax
  1001bd:	e8 1b 03 00 00       	call   1004dd <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001c2:	e8 d5 fe ff ff       	call   10009c <schedule>
  1001c7:	eb fe                	jmp    1001c7 <interrupt+0x6f>

001001c9 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001c9:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001ca:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1001cf:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001d0:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1001d2:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001d3:	bb 38 6d 10 00       	mov    $0x106d38,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001d8:	e8 df 00 00 00       	call   1002bc <segments_init>
	interrupt_controller_init(0);
  1001dd:	83 ec 0c             	sub    $0xc,%esp
  1001e0:	6a 00                	push   $0x0
  1001e2:	e8 d0 01 00 00       	call   1003b7 <interrupt_controller_init>
	console_clear();
  1001e7:	e8 54 02 00 00       	call   100440 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001ec:	83 c4 0c             	add    $0xc,%esp
  1001ef:	68 a4 01 00 00       	push   $0x1a4
  1001f4:	6a 00                	push   $0x0
  1001f6:	68 e4 6c 10 00       	push   $0x106ce4
  1001fb:	e8 20 04 00 00       	call   100620 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100200:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100203:	c7 05 e4 6c 10 00 00 	movl   $0x0,0x106ce4
  10020a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10020d:	c7 05 2c 6d 10 00 00 	movl   $0x0,0x106d2c
  100214:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100217:	c7 05 38 6d 10 00 01 	movl   $0x1,0x106d38
  10021e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100221:	c7 05 80 6d 10 00 00 	movl   $0x0,0x106d80
  100228:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10022b:	c7 05 8c 6d 10 00 02 	movl   $0x2,0x106d8c
  100232:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100235:	c7 05 d4 6d 10 00 00 	movl   $0x0,0x106dd4
  10023c:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10023f:	c7 05 e0 6d 10 00 03 	movl   $0x3,0x106de0
  100246:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100249:	c7 05 28 6e 10 00 00 	movl   $0x0,0x106e28
  100250:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100253:	c7 05 34 6e 10 00 04 	movl   $0x4,0x106e34
  10025a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10025d:	c7 05 7c 6e 10 00 00 	movl   $0x0,0x106e7c
  100264:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100267:	83 ec 0c             	sub    $0xc,%esp
  10026a:	53                   	push   %ebx
  10026b:	e8 84 02 00 00       	call   1004f4 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100270:	8d 43 34             	lea    0x34(%ebx),%eax
  100273:	5a                   	pop    %edx
  100274:	59                   	pop    %ecx

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100275:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100278:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10027e:	50                   	push   %eax
  10027f:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100280:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100281:	e8 aa 02 00 00       	call   100530 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100286:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100289:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100290:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100293:	83 fe 04             	cmp    $0x4,%esi
  100296:	75 cf                	jne    100267 <start+0x9e>
	#if SCHEDULE_ALGO == 2
	scheduling_algorithm = 2;
	#endif

	// Switch to the first process.
	run(&proc_array[1]);
  100298:	83 ec 0c             	sub    $0xc,%esp
  10029b:	68 38 6d 10 00       	push   $0x106d38

	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1002a0:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1002a7:	80 0b 00 
	#if SCHEDULE_ALGO == 1
	scheduling_algorithm = 1;
	#endif

	#if SCHEDULE_ALGO == 2
	scheduling_algorithm = 2;
  1002aa:	c7 05 f4 76 10 00 02 	movl   $0x2,0x1076f4
  1002b1:	00 00 00 
	#endif

	// Switch to the first process.
	run(&proc_array[1]);
  1002b4:	e8 24 02 00 00       	call   1004dd <run>
  1002b9:	90                   	nop
  1002ba:	90                   	nop
  1002bb:	90                   	nop

001002bc <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002bc:	b8 88 6e 10 00       	mov    $0x106e88,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002c1:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002c6:	89 c2                	mov    %eax,%edx
  1002c8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002cb:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002cc:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1002d1:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002d4:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1002da:	c1 e8 18             	shr    $0x18,%eax
  1002dd:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e3:	ba f0 6e 10 00       	mov    $0x106ef0,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002e8:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002ed:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002ef:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002f6:	68 00 
  1002f8:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002ff:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100306:	c7 05 8c 6e 10 00 00 	movl   $0x180000,0x106e8c
  10030d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100310:	66 c7 05 90 6e 10 00 	movw   $0x10,0x106e90
  100317:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100319:	66 89 0c c5 f0 6e 10 	mov    %cx,0x106ef0(,%eax,8)
  100320:	00 
  100321:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100328:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10032d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100332:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100337:	40                   	inc    %eax
  100338:	3d 00 01 00 00       	cmp    $0x100,%eax
  10033d:	75 da                	jne    100319 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10033f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100344:	ba f0 6e 10 00       	mov    $0x106ef0,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100349:	66 a3 f0 6f 10 00    	mov    %ax,0x106ff0
  10034f:	c1 e8 10             	shr    $0x10,%eax
  100352:	66 a3 f6 6f 10 00    	mov    %ax,0x106ff6
  100358:	b8 30 00 00 00       	mov    $0x30,%eax
  10035d:	66 c7 05 f2 6f 10 00 	movw   $0x8,0x106ff2
  100364:	08 00 
  100366:	c6 05 f4 6f 10 00 00 	movb   $0x0,0x106ff4
  10036d:	c6 05 f5 6f 10 00 8e 	movb   $0x8e,0x106ff5

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100374:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10037b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100382:	66 89 0c c5 f0 6e 10 	mov    %cx,0x106ef0(,%eax,8)
  100389:	00 
  10038a:	c1 e9 10             	shr    $0x10,%ecx
  10038d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100392:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100397:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10039c:	40                   	inc    %eax
  10039d:	83 f8 3a             	cmp    $0x3a,%eax
  1003a0:	75 d2                	jne    100374 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003a2:	b0 28                	mov    $0x28,%al
  1003a4:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1003ab:	0f 00 d8             	ltr    %ax
  1003ae:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003b5:	5b                   	pop    %ebx
  1003b6:	c3                   	ret    

001003b7 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1003b7:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003b8:	b0 ff                	mov    $0xff,%al
  1003ba:	57                   	push   %edi
  1003bb:	56                   	push   %esi
  1003bc:	53                   	push   %ebx
  1003bd:	bb 21 00 00 00       	mov    $0x21,%ebx
  1003c2:	89 da                	mov    %ebx,%edx
  1003c4:	ee                   	out    %al,(%dx)
  1003c5:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1003ca:	89 ca                	mov    %ecx,%edx
  1003cc:	ee                   	out    %al,(%dx)
  1003cd:	be 11 00 00 00       	mov    $0x11,%esi
  1003d2:	bf 20 00 00 00       	mov    $0x20,%edi
  1003d7:	89 f0                	mov    %esi,%eax
  1003d9:	89 fa                	mov    %edi,%edx
  1003db:	ee                   	out    %al,(%dx)
  1003dc:	b0 20                	mov    $0x20,%al
  1003de:	89 da                	mov    %ebx,%edx
  1003e0:	ee                   	out    %al,(%dx)
  1003e1:	b0 04                	mov    $0x4,%al
  1003e3:	ee                   	out    %al,(%dx)
  1003e4:	b0 03                	mov    $0x3,%al
  1003e6:	ee                   	out    %al,(%dx)
  1003e7:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003ec:	89 f0                	mov    %esi,%eax
  1003ee:	89 ea                	mov    %ebp,%edx
  1003f0:	ee                   	out    %al,(%dx)
  1003f1:	b0 28                	mov    $0x28,%al
  1003f3:	89 ca                	mov    %ecx,%edx
  1003f5:	ee                   	out    %al,(%dx)
  1003f6:	b0 02                	mov    $0x2,%al
  1003f8:	ee                   	out    %al,(%dx)
  1003f9:	b0 01                	mov    $0x1,%al
  1003fb:	ee                   	out    %al,(%dx)
  1003fc:	b0 68                	mov    $0x68,%al
  1003fe:	89 fa                	mov    %edi,%edx
  100400:	ee                   	out    %al,(%dx)
  100401:	be 0a 00 00 00       	mov    $0xa,%esi
  100406:	89 f0                	mov    %esi,%eax
  100408:	ee                   	out    %al,(%dx)
  100409:	b0 68                	mov    $0x68,%al
  10040b:	89 ea                	mov    %ebp,%edx
  10040d:	ee                   	out    %al,(%dx)
  10040e:	89 f0                	mov    %esi,%eax
  100410:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100411:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100416:	89 da                	mov    %ebx,%edx
  100418:	19 c0                	sbb    %eax,%eax
  10041a:	f7 d0                	not    %eax
  10041c:	05 ff 00 00 00       	add    $0xff,%eax
  100421:	ee                   	out    %al,(%dx)
  100422:	b0 ff                	mov    $0xff,%al
  100424:	89 ca                	mov    %ecx,%edx
  100426:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100427:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10042c:	74 0d                	je     10043b <interrupt_controller_init+0x84>
  10042e:	b2 43                	mov    $0x43,%dl
  100430:	b0 34                	mov    $0x34,%al
  100432:	ee                   	out    %al,(%dx)
  100433:	b0 9c                	mov    $0x9c,%al
  100435:	b2 40                	mov    $0x40,%dl
  100437:	ee                   	out    %al,(%dx)
  100438:	b0 2e                	mov    $0x2e,%al
  10043a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10043b:	5b                   	pop    %ebx
  10043c:	5e                   	pop    %esi
  10043d:	5f                   	pop    %edi
  10043e:	5d                   	pop    %ebp
  10043f:	c3                   	ret    

00100440 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100440:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100441:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100443:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100444:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10044b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10044e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100454:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10045a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10045d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100462:	75 ea                	jne    10044e <console_clear+0xe>
  100464:	be d4 03 00 00       	mov    $0x3d4,%esi
  100469:	b0 0e                	mov    $0xe,%al
  10046b:	89 f2                	mov    %esi,%edx
  10046d:	ee                   	out    %al,(%dx)
  10046e:	31 c9                	xor    %ecx,%ecx
  100470:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100475:	88 c8                	mov    %cl,%al
  100477:	89 da                	mov    %ebx,%edx
  100479:	ee                   	out    %al,(%dx)
  10047a:	b0 0f                	mov    $0xf,%al
  10047c:	89 f2                	mov    %esi,%edx
  10047e:	ee                   	out    %al,(%dx)
  10047f:	88 c8                	mov    %cl,%al
  100481:	89 da                	mov    %ebx,%edx
  100483:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100484:	5b                   	pop    %ebx
  100485:	5e                   	pop    %esi
  100486:	c3                   	ret    

00100487 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100487:	ba 64 00 00 00       	mov    $0x64,%edx
  10048c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10048d:	a8 01                	test   $0x1,%al
  10048f:	74 45                	je     1004d6 <console_read_digit+0x4f>
  100491:	b2 60                	mov    $0x60,%dl
  100493:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100494:	8d 50 fe             	lea    -0x2(%eax),%edx
  100497:	80 fa 08             	cmp    $0x8,%dl
  10049a:	77 05                	ja     1004a1 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10049c:	0f b6 c0             	movzbl %al,%eax
  10049f:	48                   	dec    %eax
  1004a0:	c3                   	ret    
	else if (data == 0x0B)
  1004a1:	3c 0b                	cmp    $0xb,%al
  1004a3:	74 35                	je     1004da <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004a5:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004a8:	80 fa 02             	cmp    $0x2,%dl
  1004ab:	77 07                	ja     1004b4 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004ad:	0f b6 c0             	movzbl %al,%eax
  1004b0:	83 e8 40             	sub    $0x40,%eax
  1004b3:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004b4:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004b7:	80 fa 02             	cmp    $0x2,%dl
  1004ba:	77 07                	ja     1004c3 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004bc:	0f b6 c0             	movzbl %al,%eax
  1004bf:	83 e8 47             	sub    $0x47,%eax
  1004c2:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004c3:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004c6:	80 fa 02             	cmp    $0x2,%dl
  1004c9:	77 07                	ja     1004d2 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004cb:	0f b6 c0             	movzbl %al,%eax
  1004ce:	83 e8 4e             	sub    $0x4e,%eax
  1004d1:	c3                   	ret    
	else if (data == 0x53)
  1004d2:	3c 53                	cmp    $0x53,%al
  1004d4:	74 04                	je     1004da <console_read_digit+0x53>
  1004d6:	83 c8 ff             	or     $0xffffffff,%eax
  1004d9:	c3                   	ret    
  1004da:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004dc:	c3                   	ret    

001004dd <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004dd:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004e1:	a3 f0 76 10 00       	mov    %eax,0x1076f0

	asm volatile("movl %0,%%esp\n\t"
  1004e6:	83 c0 04             	add    $0x4,%eax
  1004e9:	89 c4                	mov    %eax,%esp
  1004eb:	61                   	popa   
  1004ec:	07                   	pop    %es
  1004ed:	1f                   	pop    %ds
  1004ee:	83 c4 08             	add    $0x8,%esp
  1004f1:	cf                   	iret   
  1004f2:	eb fe                	jmp    1004f2 <run+0x15>

001004f4 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004f4:	53                   	push   %ebx
  1004f5:	83 ec 0c             	sub    $0xc,%esp
  1004f8:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004fc:	6a 44                	push   $0x44
  1004fe:	6a 00                	push   $0x0
  100500:	8d 43 04             	lea    0x4(%ebx),%eax
  100503:	50                   	push   %eax
  100504:	e8 17 01 00 00       	call   100620 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100509:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10050f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100515:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10051b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100521:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100528:	83 c4 18             	add    $0x18,%esp
  10052b:	5b                   	pop    %ebx
  10052c:	c3                   	ret    
  10052d:	90                   	nop
  10052e:	90                   	nop
  10052f:	90                   	nop

00100530 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100530:	55                   	push   %ebp
  100531:	57                   	push   %edi
  100532:	56                   	push   %esi
  100533:	53                   	push   %ebx
  100534:	83 ec 1c             	sub    $0x1c,%esp
  100537:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10053b:	83 f8 03             	cmp    $0x3,%eax
  10053e:	7f 04                	jg     100544 <program_loader+0x14>
  100540:	85 c0                	test   %eax,%eax
  100542:	79 02                	jns    100546 <program_loader+0x16>
  100544:	eb fe                	jmp    100544 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100546:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10054d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100553:	74 02                	je     100557 <program_loader+0x27>
  100555:	eb fe                	jmp    100555 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100557:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10055a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10055e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100560:	c1 e5 05             	shl    $0x5,%ebp
  100563:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100566:	eb 3f                	jmp    1005a7 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100568:	83 3b 01             	cmpl   $0x1,(%ebx)
  10056b:	75 37                	jne    1005a4 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10056d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100570:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100573:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100576:	01 c7                	add    %eax,%edi
	memsz += va;
  100578:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10057a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10057f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100583:	52                   	push   %edx
  100584:	89 fa                	mov    %edi,%edx
  100586:	29 c2                	sub    %eax,%edx
  100588:	52                   	push   %edx
  100589:	8b 53 04             	mov    0x4(%ebx),%edx
  10058c:	01 f2                	add    %esi,%edx
  10058e:	52                   	push   %edx
  10058f:	50                   	push   %eax
  100590:	e8 27 00 00 00       	call   1005bc <memcpy>
  100595:	83 c4 10             	add    $0x10,%esp
  100598:	eb 04                	jmp    10059e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10059a:	c6 07 00             	movb   $0x0,(%edi)
  10059d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10059e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005a2:	72 f6                	jb     10059a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005a4:	83 c3 20             	add    $0x20,%ebx
  1005a7:	39 eb                	cmp    %ebp,%ebx
  1005a9:	72 bd                	jb     100568 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005ab:	8b 56 18             	mov    0x18(%esi),%edx
  1005ae:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005b2:	89 10                	mov    %edx,(%eax)
}
  1005b4:	83 c4 1c             	add    $0x1c,%esp
  1005b7:	5b                   	pop    %ebx
  1005b8:	5e                   	pop    %esi
  1005b9:	5f                   	pop    %edi
  1005ba:	5d                   	pop    %ebp
  1005bb:	c3                   	ret    

001005bc <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005bc:	56                   	push   %esi
  1005bd:	31 d2                	xor    %edx,%edx
  1005bf:	53                   	push   %ebx
  1005c0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005c4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005c8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005cc:	eb 08                	jmp    1005d6 <memcpy+0x1a>
		*d++ = *s++;
  1005ce:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005d1:	4e                   	dec    %esi
  1005d2:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005d5:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005d6:	85 f6                	test   %esi,%esi
  1005d8:	75 f4                	jne    1005ce <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005da:	5b                   	pop    %ebx
  1005db:	5e                   	pop    %esi
  1005dc:	c3                   	ret    

001005dd <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005dd:	57                   	push   %edi
  1005de:	56                   	push   %esi
  1005df:	53                   	push   %ebx
  1005e0:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005e4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005e8:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005ec:	39 c7                	cmp    %eax,%edi
  1005ee:	73 26                	jae    100616 <memmove+0x39>
  1005f0:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005f3:	39 c6                	cmp    %eax,%esi
  1005f5:	76 1f                	jbe    100616 <memmove+0x39>
		s += n, d += n;
  1005f7:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005fa:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005fc:	eb 07                	jmp    100605 <memmove+0x28>
			*--d = *--s;
  1005fe:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100601:	4a                   	dec    %edx
  100602:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100605:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100606:	85 d2                	test   %edx,%edx
  100608:	75 f4                	jne    1005fe <memmove+0x21>
  10060a:	eb 10                	jmp    10061c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10060c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10060f:	4a                   	dec    %edx
  100610:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100613:	41                   	inc    %ecx
  100614:	eb 02                	jmp    100618 <memmove+0x3b>
  100616:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100618:	85 d2                	test   %edx,%edx
  10061a:	75 f0                	jne    10060c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10061c:	5b                   	pop    %ebx
  10061d:	5e                   	pop    %esi
  10061e:	5f                   	pop    %edi
  10061f:	c3                   	ret    

00100620 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100620:	53                   	push   %ebx
  100621:	8b 44 24 08          	mov    0x8(%esp),%eax
  100625:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100629:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10062d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10062f:	eb 04                	jmp    100635 <memset+0x15>
		*p++ = c;
  100631:	88 1a                	mov    %bl,(%edx)
  100633:	49                   	dec    %ecx
  100634:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100635:	85 c9                	test   %ecx,%ecx
  100637:	75 f8                	jne    100631 <memset+0x11>
		*p++ = c;
	return v;
}
  100639:	5b                   	pop    %ebx
  10063a:	c3                   	ret    

0010063b <strlen>:

size_t
strlen(const char *s)
{
  10063b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10063f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100641:	eb 01                	jmp    100644 <strlen+0x9>
		++n;
  100643:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100644:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100648:	75 f9                	jne    100643 <strlen+0x8>
		++n;
	return n;
}
  10064a:	c3                   	ret    

0010064b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10064b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10064f:	31 c0                	xor    %eax,%eax
  100651:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100655:	eb 01                	jmp    100658 <strnlen+0xd>
		++n;
  100657:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100658:	39 d0                	cmp    %edx,%eax
  10065a:	74 06                	je     100662 <strnlen+0x17>
  10065c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100660:	75 f5                	jne    100657 <strnlen+0xc>
		++n;
	return n;
}
  100662:	c3                   	ret    

00100663 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100663:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100664:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100669:	53                   	push   %ebx
  10066a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10066c:	76 05                	jbe    100673 <console_putc+0x10>
  10066e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100673:	80 fa 0a             	cmp    $0xa,%dl
  100676:	75 2c                	jne    1006a4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100678:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10067e:	be 50 00 00 00       	mov    $0x50,%esi
  100683:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100685:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100688:	99                   	cltd   
  100689:	f7 fe                	idiv   %esi
  10068b:	89 de                	mov    %ebx,%esi
  10068d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10068f:	eb 07                	jmp    100698 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100691:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100694:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100695:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100698:	83 f8 50             	cmp    $0x50,%eax
  10069b:	75 f4                	jne    100691 <console_putc+0x2e>
  10069d:	29 d0                	sub    %edx,%eax
  10069f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006a2:	eb 0b                	jmp    1006af <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006a4:	0f b6 d2             	movzbl %dl,%edx
  1006a7:	09 ca                	or     %ecx,%edx
  1006a9:	66 89 13             	mov    %dx,(%ebx)
  1006ac:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006af:	5b                   	pop    %ebx
  1006b0:	5e                   	pop    %esi
  1006b1:	c3                   	ret    

001006b2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006b2:	56                   	push   %esi
  1006b3:	53                   	push   %ebx
  1006b4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006b8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006bb:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006bf:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006c4:	75 04                	jne    1006ca <fill_numbuf+0x18>
  1006c6:	85 d2                	test   %edx,%edx
  1006c8:	74 10                	je     1006da <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006ca:	89 d0                	mov    %edx,%eax
  1006cc:	31 d2                	xor    %edx,%edx
  1006ce:	f7 f1                	div    %ecx
  1006d0:	4b                   	dec    %ebx
  1006d1:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006d4:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006d6:	89 c2                	mov    %eax,%edx
  1006d8:	eb ec                	jmp    1006c6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006da:	89 d8                	mov    %ebx,%eax
  1006dc:	5b                   	pop    %ebx
  1006dd:	5e                   	pop    %esi
  1006de:	c3                   	ret    

001006df <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006df:	55                   	push   %ebp
  1006e0:	57                   	push   %edi
  1006e1:	56                   	push   %esi
  1006e2:	53                   	push   %ebx
  1006e3:	83 ec 38             	sub    $0x38,%esp
  1006e6:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006ea:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006ee:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006f2:	e9 60 03 00 00       	jmp    100a57 <console_vprintf+0x378>
		if (*format != '%') {
  1006f7:	80 fa 25             	cmp    $0x25,%dl
  1006fa:	74 13                	je     10070f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006fc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100700:	0f b6 d2             	movzbl %dl,%edx
  100703:	89 f0                	mov    %esi,%eax
  100705:	e8 59 ff ff ff       	call   100663 <console_putc>
  10070a:	e9 45 03 00 00       	jmp    100a54 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10070f:	47                   	inc    %edi
  100710:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100717:	00 
  100718:	eb 12                	jmp    10072c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10071a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10071b:	8a 11                	mov    (%ecx),%dl
  10071d:	84 d2                	test   %dl,%dl
  10071f:	74 1a                	je     10073b <console_vprintf+0x5c>
  100721:	89 e8                	mov    %ebp,%eax
  100723:	38 c2                	cmp    %al,%dl
  100725:	75 f3                	jne    10071a <console_vprintf+0x3b>
  100727:	e9 3f 03 00 00       	jmp    100a6b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10072c:	8a 17                	mov    (%edi),%dl
  10072e:	84 d2                	test   %dl,%dl
  100730:	74 0b                	je     10073d <console_vprintf+0x5e>
  100732:	b9 c0 0a 10 00       	mov    $0x100ac0,%ecx
  100737:	89 d5                	mov    %edx,%ebp
  100739:	eb e0                	jmp    10071b <console_vprintf+0x3c>
  10073b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10073d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100740:	3c 08                	cmp    $0x8,%al
  100742:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100749:	00 
  10074a:	76 13                	jbe    10075f <console_vprintf+0x80>
  10074c:	eb 1d                	jmp    10076b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10074e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100753:	0f be c0             	movsbl %al,%eax
  100756:	47                   	inc    %edi
  100757:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10075b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10075f:	8a 07                	mov    (%edi),%al
  100761:	8d 50 d0             	lea    -0x30(%eax),%edx
  100764:	80 fa 09             	cmp    $0x9,%dl
  100767:	76 e5                	jbe    10074e <console_vprintf+0x6f>
  100769:	eb 18                	jmp    100783 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10076b:	80 fa 2a             	cmp    $0x2a,%dl
  10076e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100775:	ff 
  100776:	75 0b                	jne    100783 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100778:	83 c3 04             	add    $0x4,%ebx
			++format;
  10077b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10077c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10077f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100783:	83 cd ff             	or     $0xffffffff,%ebp
  100786:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100789:	75 37                	jne    1007c2 <console_vprintf+0xe3>
			++format;
  10078b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10078c:	31 ed                	xor    %ebp,%ebp
  10078e:	8a 07                	mov    (%edi),%al
  100790:	8d 50 d0             	lea    -0x30(%eax),%edx
  100793:	80 fa 09             	cmp    $0x9,%dl
  100796:	76 0d                	jbe    1007a5 <console_vprintf+0xc6>
  100798:	eb 17                	jmp    1007b1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10079a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10079d:	0f be c0             	movsbl %al,%eax
  1007a0:	47                   	inc    %edi
  1007a1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007a5:	8a 07                	mov    (%edi),%al
  1007a7:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007aa:	80 fa 09             	cmp    $0x9,%dl
  1007ad:	76 eb                	jbe    10079a <console_vprintf+0xbb>
  1007af:	eb 11                	jmp    1007c2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007b1:	3c 2a                	cmp    $0x2a,%al
  1007b3:	75 0b                	jne    1007c0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007b5:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007b8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007b9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007bc:	85 ed                	test   %ebp,%ebp
  1007be:	79 02                	jns    1007c2 <console_vprintf+0xe3>
  1007c0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007c2:	8a 07                	mov    (%edi),%al
  1007c4:	3c 64                	cmp    $0x64,%al
  1007c6:	74 34                	je     1007fc <console_vprintf+0x11d>
  1007c8:	7f 1d                	jg     1007e7 <console_vprintf+0x108>
  1007ca:	3c 58                	cmp    $0x58,%al
  1007cc:	0f 84 a2 00 00 00    	je     100874 <console_vprintf+0x195>
  1007d2:	3c 63                	cmp    $0x63,%al
  1007d4:	0f 84 bf 00 00 00    	je     100899 <console_vprintf+0x1ba>
  1007da:	3c 43                	cmp    $0x43,%al
  1007dc:	0f 85 d0 00 00 00    	jne    1008b2 <console_vprintf+0x1d3>
  1007e2:	e9 a3 00 00 00       	jmp    10088a <console_vprintf+0x1ab>
  1007e7:	3c 75                	cmp    $0x75,%al
  1007e9:	74 4d                	je     100838 <console_vprintf+0x159>
  1007eb:	3c 78                	cmp    $0x78,%al
  1007ed:	74 5c                	je     10084b <console_vprintf+0x16c>
  1007ef:	3c 73                	cmp    $0x73,%al
  1007f1:	0f 85 bb 00 00 00    	jne    1008b2 <console_vprintf+0x1d3>
  1007f7:	e9 86 00 00 00       	jmp    100882 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007fc:	83 c3 04             	add    $0x4,%ebx
  1007ff:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100802:	89 d1                	mov    %edx,%ecx
  100804:	c1 f9 1f             	sar    $0x1f,%ecx
  100807:	89 0c 24             	mov    %ecx,(%esp)
  10080a:	31 ca                	xor    %ecx,%edx
  10080c:	55                   	push   %ebp
  10080d:	29 ca                	sub    %ecx,%edx
  10080f:	68 c8 0a 10 00       	push   $0x100ac8
  100814:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100819:	8d 44 24 40          	lea    0x40(%esp),%eax
  10081d:	e8 90 fe ff ff       	call   1006b2 <fill_numbuf>
  100822:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100826:	58                   	pop    %eax
  100827:	5a                   	pop    %edx
  100828:	ba 01 00 00 00       	mov    $0x1,%edx
  10082d:	8b 04 24             	mov    (%esp),%eax
  100830:	83 e0 01             	and    $0x1,%eax
  100833:	e9 a5 00 00 00       	jmp    1008dd <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100838:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10083b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100840:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100843:	55                   	push   %ebp
  100844:	68 c8 0a 10 00       	push   $0x100ac8
  100849:	eb 11                	jmp    10085c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10084b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10084e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100851:	55                   	push   %ebp
  100852:	68 dc 0a 10 00       	push   $0x100adc
  100857:	b9 10 00 00 00       	mov    $0x10,%ecx
  10085c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100860:	e8 4d fe ff ff       	call   1006b2 <fill_numbuf>
  100865:	ba 01 00 00 00       	mov    $0x1,%edx
  10086a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10086e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100870:	59                   	pop    %ecx
  100871:	59                   	pop    %ecx
  100872:	eb 69                	jmp    1008dd <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100874:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100877:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10087a:	55                   	push   %ebp
  10087b:	68 c8 0a 10 00       	push   $0x100ac8
  100880:	eb d5                	jmp    100857 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100882:	83 c3 04             	add    $0x4,%ebx
  100885:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100888:	eb 40                	jmp    1008ca <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10088a:	83 c3 04             	add    $0x4,%ebx
  10088d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100890:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100894:	e9 bd 01 00 00       	jmp    100a56 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100899:	83 c3 04             	add    $0x4,%ebx
  10089c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10089f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008a3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008a8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008ac:	88 44 24 24          	mov    %al,0x24(%esp)
  1008b0:	eb 27                	jmp    1008d9 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008b2:	84 c0                	test   %al,%al
  1008b4:	75 02                	jne    1008b8 <console_vprintf+0x1d9>
  1008b6:	b0 25                	mov    $0x25,%al
  1008b8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008bc:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008c1:	80 3f 00             	cmpb   $0x0,(%edi)
  1008c4:	74 0a                	je     1008d0 <console_vprintf+0x1f1>
  1008c6:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008ce:	eb 09                	jmp    1008d9 <console_vprintf+0x1fa>
				format--;
  1008d0:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008d4:	4f                   	dec    %edi
  1008d5:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008d9:	31 d2                	xor    %edx,%edx
  1008db:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008dd:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008df:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008e9:	74 1f                	je     10090a <console_vprintf+0x22b>
  1008eb:	89 04 24             	mov    %eax,(%esp)
  1008ee:	eb 01                	jmp    1008f1 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008f0:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008f1:	39 e9                	cmp    %ebp,%ecx
  1008f3:	74 0a                	je     1008ff <console_vprintf+0x220>
  1008f5:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008f9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008fd:	75 f1                	jne    1008f0 <console_vprintf+0x211>
  1008ff:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100902:	89 0c 24             	mov    %ecx,(%esp)
  100905:	eb 1f                	jmp    100926 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100907:	42                   	inc    %edx
  100908:	eb 09                	jmp    100913 <console_vprintf+0x234>
  10090a:	89 d1                	mov    %edx,%ecx
  10090c:	8b 14 24             	mov    (%esp),%edx
  10090f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100913:	8b 44 24 04          	mov    0x4(%esp),%eax
  100917:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  10091b:	75 ea                	jne    100907 <console_vprintf+0x228>
  10091d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100921:	89 14 24             	mov    %edx,(%esp)
  100924:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100926:	85 c0                	test   %eax,%eax
  100928:	74 0c                	je     100936 <console_vprintf+0x257>
  10092a:	84 d2                	test   %dl,%dl
  10092c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100933:	00 
  100934:	75 24                	jne    10095a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100936:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  10093b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100942:	00 
  100943:	75 15                	jne    10095a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100945:	8b 44 24 14          	mov    0x14(%esp),%eax
  100949:	83 e0 08             	and    $0x8,%eax
  10094c:	83 f8 01             	cmp    $0x1,%eax
  10094f:	19 c9                	sbb    %ecx,%ecx
  100951:	f7 d1                	not    %ecx
  100953:	83 e1 20             	and    $0x20,%ecx
  100956:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  10095a:	3b 2c 24             	cmp    (%esp),%ebp
  10095d:	7e 0d                	jle    10096c <console_vprintf+0x28d>
  10095f:	84 d2                	test   %dl,%dl
  100961:	74 40                	je     1009a3 <console_vprintf+0x2c4>
			zeros = precision - len;
  100963:	2b 2c 24             	sub    (%esp),%ebp
  100966:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  10096a:	eb 3f                	jmp    1009ab <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10096c:	84 d2                	test   %dl,%dl
  10096e:	74 33                	je     1009a3 <console_vprintf+0x2c4>
  100970:	8b 44 24 14          	mov    0x14(%esp),%eax
  100974:	83 e0 06             	and    $0x6,%eax
  100977:	83 f8 02             	cmp    $0x2,%eax
  10097a:	75 27                	jne    1009a3 <console_vprintf+0x2c4>
  10097c:	45                   	inc    %ebp
  10097d:	75 24                	jne    1009a3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  10097f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100981:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100984:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100989:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10098c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  10098f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100993:	7d 0e                	jge    1009a3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100995:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100999:	29 ca                	sub    %ecx,%edx
  10099b:	29 c2                	sub    %eax,%edx
  10099d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009a1:	eb 08                	jmp    1009ab <console_vprintf+0x2cc>
  1009a3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009aa:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009ab:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009af:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009b1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009b5:	2b 2c 24             	sub    (%esp),%ebp
  1009b8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009bd:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009c0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009c3:	29 c5                	sub    %eax,%ebp
  1009c5:	89 f0                	mov    %esi,%eax
  1009c7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009cb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009cf:	eb 0f                	jmp    1009e0 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009d1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009d5:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009da:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009db:	e8 83 fc ff ff       	call   100663 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009e0:	85 ed                	test   %ebp,%ebp
  1009e2:	7e 07                	jle    1009eb <console_vprintf+0x30c>
  1009e4:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009e9:	74 e6                	je     1009d1 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009eb:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009f0:	89 c6                	mov    %eax,%esi
  1009f2:	74 23                	je     100a17 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009f4:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009f9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009fd:	e8 61 fc ff ff       	call   100663 <console_putc>
  100a02:	89 c6                	mov    %eax,%esi
  100a04:	eb 11                	jmp    100a17 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a06:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a0a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a0f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a10:	e8 4e fc ff ff       	call   100663 <console_putc>
  100a15:	eb 06                	jmp    100a1d <console_vprintf+0x33e>
  100a17:	89 f0                	mov    %esi,%eax
  100a19:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a1d:	85 f6                	test   %esi,%esi
  100a1f:	7f e5                	jg     100a06 <console_vprintf+0x327>
  100a21:	8b 34 24             	mov    (%esp),%esi
  100a24:	eb 15                	jmp    100a3b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a26:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a2a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a2b:	0f b6 11             	movzbl (%ecx),%edx
  100a2e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a32:	e8 2c fc ff ff       	call   100663 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a37:	ff 44 24 04          	incl   0x4(%esp)
  100a3b:	85 f6                	test   %esi,%esi
  100a3d:	7f e7                	jg     100a26 <console_vprintf+0x347>
  100a3f:	eb 0f                	jmp    100a50 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a41:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a45:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a4a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a4b:	e8 13 fc ff ff       	call   100663 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a50:	85 ed                	test   %ebp,%ebp
  100a52:	7f ed                	jg     100a41 <console_vprintf+0x362>
  100a54:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a56:	47                   	inc    %edi
  100a57:	8a 17                	mov    (%edi),%dl
  100a59:	84 d2                	test   %dl,%dl
  100a5b:	0f 85 96 fc ff ff    	jne    1006f7 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a61:	83 c4 38             	add    $0x38,%esp
  100a64:	89 f0                	mov    %esi,%eax
  100a66:	5b                   	pop    %ebx
  100a67:	5e                   	pop    %esi
  100a68:	5f                   	pop    %edi
  100a69:	5d                   	pop    %ebp
  100a6a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a6b:	81 e9 c0 0a 10 00    	sub    $0x100ac0,%ecx
  100a71:	b8 01 00 00 00       	mov    $0x1,%eax
  100a76:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a78:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a79:	09 44 24 14          	or     %eax,0x14(%esp)
  100a7d:	e9 aa fc ff ff       	jmp    10072c <console_vprintf+0x4d>

00100a82 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a82:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a86:	50                   	push   %eax
  100a87:	ff 74 24 10          	pushl  0x10(%esp)
  100a8b:	ff 74 24 10          	pushl  0x10(%esp)
  100a8f:	ff 74 24 10          	pushl  0x10(%esp)
  100a93:	e8 47 fc ff ff       	call   1006df <console_vprintf>
  100a98:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a9b:	c3                   	ret    
