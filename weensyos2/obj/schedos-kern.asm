
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
  100014:	e8 e2 01 00 00       	call   1001fb <start>
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
  10006d:	e8 12 01 00 00       	call   100184 <interrupt>

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

0010009c <sort_priority>:

#if SCHEDULE_ALGO == 2
//pid_t
void
sort_priority(process_t proc_array[])
{
  10009c:	55                   	push   %ebp
  10009d:	57                   	push   %edi
  10009e:	56                   	push   %esi
  10009f:	53                   	push   %ebx
  1000a0:	bb 02 00 00 00       	mov    $0x2,%ebx
  1000a5:	83 ec 68             	sub    $0x68,%esp
	pid_t i;
	pid_t j;
	for (i = 2; i < NPROCS; i++) {
		for (j = 1; j < i; j++) {
			if(proc_array[i].p_priority < proc_array[j].p_priority){
				process_t temp = proc_array[i];
  1000a8:	8d 44 24 14          	lea    0x14(%esp),%eax

#if SCHEDULE_ALGO == 2
//pid_t
void
sort_priority(process_t proc_array[])
{
  1000ac:	8b 54 24 7c          	mov    0x7c(%esp),%edx
	pid_t i;
	pid_t j;
	for (i = 2; i < NPROCS; i++) {
		for (j = 1; j < i; j++) {
			if(proc_array[i].p_priority < proc_array[j].p_priority){
				process_t temp = proc_array[i];
  1000b0:	89 04 24             	mov    %eax,(%esp)
  1000b3:	eb 42                	jmp    1000f7 <sort_priority+0x5b>

	pid_t i;
	pid_t j;
	for (i = 2; i < NPROCS; i++) {
		for (j = 1; j < i; j++) {
			if(proc_array[i].p_priority < proc_array[j].p_priority){
  1000b5:	8b 8a f8 00 00 00    	mov    0xf8(%edx),%ecx
  1000bb:	3b 88 a4 00 00 00    	cmp    0xa4(%eax),%ecx
  1000c1:	7d 23                	jge    1000e6 <sort_priority+0x4a>
				process_t temp = proc_array[i];
  1000c3:	8b 3c 24             	mov    (%esp),%edi
  1000c6:	b9 15 00 00 00       	mov    $0x15,%ecx
  1000cb:	8b 74 24 04          	mov    0x4(%esp),%esi
  1000cf:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
				proc_array[i] = proc_array[j];
  1000d1:	8b 7c 24 04          	mov    0x4(%esp),%edi
  1000d5:	8d 70 54             	lea    0x54(%eax),%esi
  1000d8:	b1 15                	mov    $0x15,%cl
  1000da:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
				proc_array[j] = temp;
  1000dc:	8b 34 24             	mov    (%esp),%esi
  1000df:	8d 78 54             	lea    0x54(%eax),%edi
  1000e2:	b1 15                	mov    $0x15,%cl
  1000e4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	*/

	pid_t i;
	pid_t j;
	for (i = 2; i < NPROCS; i++) {
		for (j = 1; j < i; j++) {
  1000e6:	45                   	inc    %ebp
  1000e7:	83 c0 54             	add    $0x54,%eax
  1000ea:	39 dd                	cmp    %ebx,%ebp
  1000ec:	7c c7                	jl     1000b5 <sort_priority+0x19>
		return highest_priority;
	*/

	pid_t i;
	pid_t j;
	for (i = 2; i < NPROCS; i++) {
  1000ee:	43                   	inc    %ebx
  1000ef:	83 c2 54             	add    $0x54,%edx
  1000f2:	83 fb 05             	cmp    $0x5,%ebx
  1000f5:	74 15                	je     10010c <sort_priority+0x70>
		for (j = 1; j < i; j++) {
			if(proc_array[i].p_priority < proc_array[j].p_priority){
				process_t temp = proc_array[i];
  1000f7:	8d 8a a8 00 00 00    	lea    0xa8(%edx),%ecx
		return highest_priority;
	*/

	pid_t i;
	pid_t j;
	for (i = 2; i < NPROCS; i++) {
  1000fd:	8b 44 24 7c          	mov    0x7c(%esp),%eax
  100101:	bd 01 00 00 00       	mov    $0x1,%ebp
		for (j = 1; j < i; j++) {
			if(proc_array[i].p_priority < proc_array[j].p_priority){
				process_t temp = proc_array[i];
  100106:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  10010a:	eb a9                	jmp    1000b5 <sort_priority+0x19>
				proc_array[i] = proc_array[j];
				proc_array[j] = temp;
			}
		}
	}
}
  10010c:	83 c4 68             	add    $0x68,%esp
  10010f:	5b                   	pop    %ebx
  100110:	5e                   	pop    %esi
  100111:	5f                   	pop    %edi
  100112:	5d                   	pop    %ebp
  100113:	c3                   	ret    

00100114 <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  100114:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  100117:	a1 50 76 10 00       	mov    0x107650,%eax

	if (scheduling_algorithm == 0)
  10011c:	83 3d 54 76 10 00 00 	cmpl   $0x0,0x107654
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  100123:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  100125:	75 1c                	jne    100143 <schedule+0x2f>
		while (1) {
			pid = (pid + 1) % NPROCS;
  100127:	b9 05 00 00 00       	mov    $0x5,%ecx
  10012c:	8d 42 01             	lea    0x1(%edx),%eax
  10012f:	99                   	cltd   
  100130:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  100132:	6b c2 54             	imul   $0x54,%edx,%eax
  100135:	83 b8 8c 6c 10 00 01 	cmpl   $0x1,0x106c8c(%eax)
  10013c:	75 ee                	jne    10012c <schedule+0x18>
				run(&proc_array[pid]);
  10013e:	83 ec 0c             	sub    $0xc,%esp
  100141:	eb 29                	jmp    10016c <schedule+0x58>
                if (!find_priority(proc_array))
                	return;
	}
	*/
	
	sort_priority(proc_array);
  100143:	83 ec 0c             	sub    $0xc,%esp
  100146:	68 44 6c 10 00       	push   $0x106c44
  10014b:	e8 4c ff ff ff       	call   10009c <sort_priority>
	
	pid_t priority_pid = proc_array[1].p_pid;	
  100150:	a1 98 6c 10 00       	mov    0x106c98,%eax
  100155:	83 c4 10             	add    $0x10,%esp
  100158:	6b d0 54             	imul   $0x54,%eax,%edx
  10015b:	81 c2 8c 6c 10 00    	add    $0x106c8c,%edx
	while (1) {
                        if(proc_array[priority_pid].p_state == P_RUNNABLE)
  100161:	83 3a 01             	cmpl   $0x1,(%edx)
  100164:	75 11                	jne    100177 <schedule+0x63>
                                run(&proc_array[priority_pid]);
  100166:	6b c0 54             	imul   $0x54,%eax,%eax
  100169:	83 ec 0c             	sub    $0xc,%esp
  10016c:	05 44 6c 10 00       	add    $0x106c44,%eax
  100171:	50                   	push   %eax
  100172:	e8 9e 03 00 00       	call   100515 <run>
                        else
                                priority_pid++;
  100177:	40                   	inc    %eax
  100178:	83 c2 54             	add    $0x54,%edx
                        if (priority_pid == NPROCS)
  10017b:	83 f8 05             	cmp    $0x5,%eax
  10017e:	75 e1                	jne    100161 <schedule+0x4d>
	#endif 	
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
	while (1)
		/* do nothing */;
}
  100180:	83 c4 0c             	add    $0xc,%esp
  100183:	c3                   	ret    

00100184 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100184:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100185:	8b 3d 50 76 10 00    	mov    0x107650,%edi
  10018b:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100190:	56                   	push   %esi
  100191:	53                   	push   %ebx
  100192:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100196:	83 c7 04             	add    $0x4,%edi
  100199:	89 de                	mov    %ebx,%esi
  10019b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10019d:	8b 43 28             	mov    0x28(%ebx),%eax
  1001a0:	83 f8 31             	cmp    $0x31,%eax
  1001a3:	74 1f                	je     1001c4 <interrupt+0x40>
  1001a5:	77 0c                	ja     1001b3 <interrupt+0x2f>
  1001a7:	83 f8 20             	cmp    $0x20,%eax
  1001aa:	74 48                	je     1001f4 <interrupt+0x70>
  1001ac:	83 f8 30             	cmp    $0x30,%eax
  1001af:	74 0e                	je     1001bf <interrupt+0x3b>
  1001b1:	eb 46                	jmp    1001f9 <interrupt+0x75>
  1001b3:	83 f8 32             	cmp    $0x32,%eax
  1001b6:	74 23                	je     1001db <interrupt+0x57>
  1001b8:	83 f8 33             	cmp    $0x33,%eax
  1001bb:	74 29                	je     1001e6 <interrupt+0x62>
  1001bd:	eb 3a                	jmp    1001f9 <interrupt+0x75>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001bf:	e8 50 ff ff ff       	call   100114 <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001c4:	a1 50 76 10 00       	mov    0x107650,%eax
		current->p_exit_status = reg->reg_eax;
  1001c9:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001cc:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1001d3:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1001d6:	e8 39 ff ff ff       	call   100114 <schedule>
	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		#if SCHEDULE_ALGO == 2
			current->p_priority = reg->reg_eax;	
  1001db:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001de:	a1 50 76 10 00       	mov    0x107650,%eax
  1001e3:	89 50 50             	mov    %edx,0x50(%eax)
		#endif
		//run(current);

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1001e6:	83 ec 0c             	sub    $0xc,%esp
  1001e9:	ff 35 50 76 10 00    	pushl  0x107650
  1001ef:	e8 21 03 00 00       	call   100515 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001f4:	e8 1b ff ff ff       	call   100114 <schedule>
  1001f9:	eb fe                	jmp    1001f9 <interrupt+0x75>

001001fb <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001fb:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001fc:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100201:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100202:	be 01 00 00 00       	mov    $0x1,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100207:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100208:	bb 98 6c 10 00       	mov    $0x106c98,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10020d:	e8 e2 00 00 00       	call   1002f4 <segments_init>
	interrupt_controller_init(0);
  100212:	83 ec 0c             	sub    $0xc,%esp
  100215:	6a 00                	push   $0x0
  100217:	e8 d3 01 00 00       	call   1003ef <interrupt_controller_init>
	console_clear();
  10021c:	e8 57 02 00 00       	call   100478 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100221:	83 c4 0c             	add    $0xc,%esp
  100224:	68 a4 01 00 00       	push   $0x1a4
  100229:	6a 00                	push   $0x0
  10022b:	68 44 6c 10 00       	push   $0x106c44
  100230:	e8 23 04 00 00       	call   100658 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100235:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100238:	c7 05 44 6c 10 00 00 	movl   $0x0,0x106c44
  10023f:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100242:	c7 05 8c 6c 10 00 00 	movl   $0x0,0x106c8c
  100249:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10024c:	c7 05 98 6c 10 00 01 	movl   $0x1,0x106c98
  100253:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100256:	c7 05 e0 6c 10 00 00 	movl   $0x0,0x106ce0
  10025d:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100260:	c7 05 ec 6c 10 00 02 	movl   $0x2,0x106cec
  100267:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10026a:	c7 05 34 6d 10 00 00 	movl   $0x0,0x106d34
  100271:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100274:	c7 05 40 6d 10 00 03 	movl   $0x3,0x106d40
  10027b:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10027e:	c7 05 88 6d 10 00 00 	movl   $0x0,0x106d88
  100285:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100288:	c7 05 94 6d 10 00 04 	movl   $0x4,0x106d94
  10028f:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100292:	c7 05 dc 6d 10 00 00 	movl   $0x0,0x106ddc
  100299:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10029c:	83 ec 0c             	sub    $0xc,%esp
  10029f:	53                   	push   %ebx
  1002a0:	e8 87 02 00 00       	call   10052c <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002a5:	58                   	pop    %eax
  1002a6:	5a                   	pop    %edx
  1002a7:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1002aa:	89 7b 40             	mov    %edi,0x40(%ebx)
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002ad:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002b3:	50                   	push   %eax
  1002b4:	8d 46 ff             	lea    -0x1(%esi),%eax
  1002b7:	50                   	push   %eax
  1002b8:	e8 ab 02 00 00       	call   100568 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002bd:	83 c4 10             	add    $0x10,%esp
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		#if SCHEDULE_ALGO == 2
		
		proc->p_priority = i;
  1002c0:	89 73 50             	mov    %esi,0x50(%ebx)
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002c3:	46                   	inc    %esi

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002c4:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002cb:	83 c3 54             	add    $0x54,%ebx
  1002ce:	83 fe 05             	cmp    $0x5,%esi
  1002d1:	75 c9                	jne    10029c <start+0xa1>
	#if SCHEDULE_ALGO == 2
	scheduling_algorithm = 2;
	#endif

	// Switch to the first process.
	run(&proc_array[1]);
  1002d3:	83 ec 0c             	sub    $0xc,%esp
  1002d6:	68 98 6c 10 00       	push   $0x106c98
		#endif
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1002db:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1002e2:	80 0b 00 
	#if SCHEDULE_ALGO == 1
	scheduling_algorithm = 1;
	#endif

	#if SCHEDULE_ALGO == 2
	scheduling_algorithm = 2;
  1002e5:	c7 05 54 76 10 00 02 	movl   $0x2,0x107654
  1002ec:	00 00 00 
	#endif

	// Switch to the first process.
	run(&proc_array[1]);
  1002ef:	e8 21 02 00 00       	call   100515 <run>

001002f4 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002f4:	b8 e8 6d 10 00       	mov    $0x106de8,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002f9:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002fe:	89 c2                	mov    %eax,%edx
  100300:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100303:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100304:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100309:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10030c:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100312:	c1 e8 18             	shr    $0x18,%eax
  100315:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10031b:	ba 50 6e 10 00       	mov    $0x106e50,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100320:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100325:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100327:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10032e:	68 00 
  100330:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100337:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10033e:	c7 05 ec 6d 10 00 00 	movl   $0x180000,0x106dec
  100345:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100348:	66 c7 05 f0 6d 10 00 	movw   $0x10,0x106df0
  10034f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100351:	66 89 0c c5 50 6e 10 	mov    %cx,0x106e50(,%eax,8)
  100358:	00 
  100359:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100360:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100365:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10036a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10036f:	40                   	inc    %eax
  100370:	3d 00 01 00 00       	cmp    $0x100,%eax
  100375:	75 da                	jne    100351 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100377:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10037c:	ba 50 6e 10 00       	mov    $0x106e50,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100381:	66 a3 50 6f 10 00    	mov    %ax,0x106f50
  100387:	c1 e8 10             	shr    $0x10,%eax
  10038a:	66 a3 56 6f 10 00    	mov    %ax,0x106f56
  100390:	b8 30 00 00 00       	mov    $0x30,%eax
  100395:	66 c7 05 52 6f 10 00 	movw   $0x8,0x106f52
  10039c:	08 00 
  10039e:	c6 05 54 6f 10 00 00 	movb   $0x0,0x106f54
  1003a5:	c6 05 55 6f 10 00 8e 	movb   $0x8e,0x106f55

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003ac:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1003b3:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003ba:	66 89 0c c5 50 6e 10 	mov    %cx,0x106e50(,%eax,8)
  1003c1:	00 
  1003c2:	c1 e9 10             	shr    $0x10,%ecx
  1003c5:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003ca:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003cf:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1003d4:	40                   	inc    %eax
  1003d5:	83 f8 3a             	cmp    $0x3a,%eax
  1003d8:	75 d2                	jne    1003ac <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003da:	b0 28                	mov    $0x28,%al
  1003dc:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1003e3:	0f 00 d8             	ltr    %ax
  1003e6:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003ed:	5b                   	pop    %ebx
  1003ee:	c3                   	ret    

001003ef <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1003ef:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003f0:	b0 ff                	mov    $0xff,%al
  1003f2:	57                   	push   %edi
  1003f3:	56                   	push   %esi
  1003f4:	53                   	push   %ebx
  1003f5:	bb 21 00 00 00       	mov    $0x21,%ebx
  1003fa:	89 da                	mov    %ebx,%edx
  1003fc:	ee                   	out    %al,(%dx)
  1003fd:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100402:	89 ca                	mov    %ecx,%edx
  100404:	ee                   	out    %al,(%dx)
  100405:	be 11 00 00 00       	mov    $0x11,%esi
  10040a:	bf 20 00 00 00       	mov    $0x20,%edi
  10040f:	89 f0                	mov    %esi,%eax
  100411:	89 fa                	mov    %edi,%edx
  100413:	ee                   	out    %al,(%dx)
  100414:	b0 20                	mov    $0x20,%al
  100416:	89 da                	mov    %ebx,%edx
  100418:	ee                   	out    %al,(%dx)
  100419:	b0 04                	mov    $0x4,%al
  10041b:	ee                   	out    %al,(%dx)
  10041c:	b0 03                	mov    $0x3,%al
  10041e:	ee                   	out    %al,(%dx)
  10041f:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100424:	89 f0                	mov    %esi,%eax
  100426:	89 ea                	mov    %ebp,%edx
  100428:	ee                   	out    %al,(%dx)
  100429:	b0 28                	mov    $0x28,%al
  10042b:	89 ca                	mov    %ecx,%edx
  10042d:	ee                   	out    %al,(%dx)
  10042e:	b0 02                	mov    $0x2,%al
  100430:	ee                   	out    %al,(%dx)
  100431:	b0 01                	mov    $0x1,%al
  100433:	ee                   	out    %al,(%dx)
  100434:	b0 68                	mov    $0x68,%al
  100436:	89 fa                	mov    %edi,%edx
  100438:	ee                   	out    %al,(%dx)
  100439:	be 0a 00 00 00       	mov    $0xa,%esi
  10043e:	89 f0                	mov    %esi,%eax
  100440:	ee                   	out    %al,(%dx)
  100441:	b0 68                	mov    $0x68,%al
  100443:	89 ea                	mov    %ebp,%edx
  100445:	ee                   	out    %al,(%dx)
  100446:	89 f0                	mov    %esi,%eax
  100448:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100449:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10044e:	89 da                	mov    %ebx,%edx
  100450:	19 c0                	sbb    %eax,%eax
  100452:	f7 d0                	not    %eax
  100454:	05 ff 00 00 00       	add    $0xff,%eax
  100459:	ee                   	out    %al,(%dx)
  10045a:	b0 ff                	mov    $0xff,%al
  10045c:	89 ca                	mov    %ecx,%edx
  10045e:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10045f:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100464:	74 0d                	je     100473 <interrupt_controller_init+0x84>
  100466:	b2 43                	mov    $0x43,%dl
  100468:	b0 34                	mov    $0x34,%al
  10046a:	ee                   	out    %al,(%dx)
  10046b:	b0 9c                	mov    $0x9c,%al
  10046d:	b2 40                	mov    $0x40,%dl
  10046f:	ee                   	out    %al,(%dx)
  100470:	b0 2e                	mov    $0x2e,%al
  100472:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100473:	5b                   	pop    %ebx
  100474:	5e                   	pop    %esi
  100475:	5f                   	pop    %edi
  100476:	5d                   	pop    %ebp
  100477:	c3                   	ret    

00100478 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100478:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100479:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10047b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10047c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100483:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100486:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10048c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100492:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100495:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10049a:	75 ea                	jne    100486 <console_clear+0xe>
  10049c:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004a1:	b0 0e                	mov    $0xe,%al
  1004a3:	89 f2                	mov    %esi,%edx
  1004a5:	ee                   	out    %al,(%dx)
  1004a6:	31 c9                	xor    %ecx,%ecx
  1004a8:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004ad:	88 c8                	mov    %cl,%al
  1004af:	89 da                	mov    %ebx,%edx
  1004b1:	ee                   	out    %al,(%dx)
  1004b2:	b0 0f                	mov    $0xf,%al
  1004b4:	89 f2                	mov    %esi,%edx
  1004b6:	ee                   	out    %al,(%dx)
  1004b7:	88 c8                	mov    %cl,%al
  1004b9:	89 da                	mov    %ebx,%edx
  1004bb:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004bc:	5b                   	pop    %ebx
  1004bd:	5e                   	pop    %esi
  1004be:	c3                   	ret    

001004bf <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004bf:	ba 64 00 00 00       	mov    $0x64,%edx
  1004c4:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004c5:	a8 01                	test   $0x1,%al
  1004c7:	74 45                	je     10050e <console_read_digit+0x4f>
  1004c9:	b2 60                	mov    $0x60,%dl
  1004cb:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004cc:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004cf:	80 fa 08             	cmp    $0x8,%dl
  1004d2:	77 05                	ja     1004d9 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004d4:	0f b6 c0             	movzbl %al,%eax
  1004d7:	48                   	dec    %eax
  1004d8:	c3                   	ret    
	else if (data == 0x0B)
  1004d9:	3c 0b                	cmp    $0xb,%al
  1004db:	74 35                	je     100512 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004dd:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004e0:	80 fa 02             	cmp    $0x2,%dl
  1004e3:	77 07                	ja     1004ec <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004e5:	0f b6 c0             	movzbl %al,%eax
  1004e8:	83 e8 40             	sub    $0x40,%eax
  1004eb:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004ec:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004ef:	80 fa 02             	cmp    $0x2,%dl
  1004f2:	77 07                	ja     1004fb <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004f4:	0f b6 c0             	movzbl %al,%eax
  1004f7:	83 e8 47             	sub    $0x47,%eax
  1004fa:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004fb:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004fe:	80 fa 02             	cmp    $0x2,%dl
  100501:	77 07                	ja     10050a <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100503:	0f b6 c0             	movzbl %al,%eax
  100506:	83 e8 4e             	sub    $0x4e,%eax
  100509:	c3                   	ret    
	else if (data == 0x53)
  10050a:	3c 53                	cmp    $0x53,%al
  10050c:	74 04                	je     100512 <console_read_digit+0x53>
  10050e:	83 c8 ff             	or     $0xffffffff,%eax
  100511:	c3                   	ret    
  100512:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100514:	c3                   	ret    

00100515 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100515:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100519:	a3 50 76 10 00       	mov    %eax,0x107650

	asm volatile("movl %0,%%esp\n\t"
  10051e:	83 c0 04             	add    $0x4,%eax
  100521:	89 c4                	mov    %eax,%esp
  100523:	61                   	popa   
  100524:	07                   	pop    %es
  100525:	1f                   	pop    %ds
  100526:	83 c4 08             	add    $0x8,%esp
  100529:	cf                   	iret   
  10052a:	eb fe                	jmp    10052a <run+0x15>

0010052c <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10052c:	53                   	push   %ebx
  10052d:	83 ec 0c             	sub    $0xc,%esp
  100530:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100534:	6a 44                	push   $0x44
  100536:	6a 00                	push   $0x0
  100538:	8d 43 04             	lea    0x4(%ebx),%eax
  10053b:	50                   	push   %eax
  10053c:	e8 17 01 00 00       	call   100658 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100541:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100547:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  10054d:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100553:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100559:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100560:	83 c4 18             	add    $0x18,%esp
  100563:	5b                   	pop    %ebx
  100564:	c3                   	ret    
  100565:	90                   	nop
  100566:	90                   	nop
  100567:	90                   	nop

00100568 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100568:	55                   	push   %ebp
  100569:	57                   	push   %edi
  10056a:	56                   	push   %esi
  10056b:	53                   	push   %ebx
  10056c:	83 ec 1c             	sub    $0x1c,%esp
  10056f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100573:	83 f8 03             	cmp    $0x3,%eax
  100576:	7f 04                	jg     10057c <program_loader+0x14>
  100578:	85 c0                	test   %eax,%eax
  10057a:	79 02                	jns    10057e <program_loader+0x16>
  10057c:	eb fe                	jmp    10057c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10057e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100585:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10058b:	74 02                	je     10058f <program_loader+0x27>
  10058d:	eb fe                	jmp    10058d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10058f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100592:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100596:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100598:	c1 e5 05             	shl    $0x5,%ebp
  10059b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10059e:	eb 3f                	jmp    1005df <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005a0:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005a3:	75 37                	jne    1005dc <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1005a5:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005a8:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005ab:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005ae:	01 c7                	add    %eax,%edi
	memsz += va;
  1005b0:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005b7:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005bb:	52                   	push   %edx
  1005bc:	89 fa                	mov    %edi,%edx
  1005be:	29 c2                	sub    %eax,%edx
  1005c0:	52                   	push   %edx
  1005c1:	8b 53 04             	mov    0x4(%ebx),%edx
  1005c4:	01 f2                	add    %esi,%edx
  1005c6:	52                   	push   %edx
  1005c7:	50                   	push   %eax
  1005c8:	e8 27 00 00 00       	call   1005f4 <memcpy>
  1005cd:	83 c4 10             	add    $0x10,%esp
  1005d0:	eb 04                	jmp    1005d6 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005d2:	c6 07 00             	movb   $0x0,(%edi)
  1005d5:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005d6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005da:	72 f6                	jb     1005d2 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005dc:	83 c3 20             	add    $0x20,%ebx
  1005df:	39 eb                	cmp    %ebp,%ebx
  1005e1:	72 bd                	jb     1005a0 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005e3:	8b 56 18             	mov    0x18(%esi),%edx
  1005e6:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005ea:	89 10                	mov    %edx,(%eax)
}
  1005ec:	83 c4 1c             	add    $0x1c,%esp
  1005ef:	5b                   	pop    %ebx
  1005f0:	5e                   	pop    %esi
  1005f1:	5f                   	pop    %edi
  1005f2:	5d                   	pop    %ebp
  1005f3:	c3                   	ret    

001005f4 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005f4:	56                   	push   %esi
  1005f5:	31 d2                	xor    %edx,%edx
  1005f7:	53                   	push   %ebx
  1005f8:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005fc:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100600:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100604:	eb 08                	jmp    10060e <memcpy+0x1a>
		*d++ = *s++;
  100606:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100609:	4e                   	dec    %esi
  10060a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10060d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10060e:	85 f6                	test   %esi,%esi
  100610:	75 f4                	jne    100606 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100612:	5b                   	pop    %ebx
  100613:	5e                   	pop    %esi
  100614:	c3                   	ret    

00100615 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100615:	57                   	push   %edi
  100616:	56                   	push   %esi
  100617:	53                   	push   %ebx
  100618:	8b 44 24 10          	mov    0x10(%esp),%eax
  10061c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100620:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100624:	39 c7                	cmp    %eax,%edi
  100626:	73 26                	jae    10064e <memmove+0x39>
  100628:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10062b:	39 c6                	cmp    %eax,%esi
  10062d:	76 1f                	jbe    10064e <memmove+0x39>
		s += n, d += n;
  10062f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100632:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100634:	eb 07                	jmp    10063d <memmove+0x28>
			*--d = *--s;
  100636:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100639:	4a                   	dec    %edx
  10063a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10063d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10063e:	85 d2                	test   %edx,%edx
  100640:	75 f4                	jne    100636 <memmove+0x21>
  100642:	eb 10                	jmp    100654 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100644:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100647:	4a                   	dec    %edx
  100648:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10064b:	41                   	inc    %ecx
  10064c:	eb 02                	jmp    100650 <memmove+0x3b>
  10064e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100650:	85 d2                	test   %edx,%edx
  100652:	75 f0                	jne    100644 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100654:	5b                   	pop    %ebx
  100655:	5e                   	pop    %esi
  100656:	5f                   	pop    %edi
  100657:	c3                   	ret    

00100658 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100658:	53                   	push   %ebx
  100659:	8b 44 24 08          	mov    0x8(%esp),%eax
  10065d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100661:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100665:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100667:	eb 04                	jmp    10066d <memset+0x15>
		*p++ = c;
  100669:	88 1a                	mov    %bl,(%edx)
  10066b:	49                   	dec    %ecx
  10066c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10066d:	85 c9                	test   %ecx,%ecx
  10066f:	75 f8                	jne    100669 <memset+0x11>
		*p++ = c;
	return v;
}
  100671:	5b                   	pop    %ebx
  100672:	c3                   	ret    

00100673 <strlen>:

size_t
strlen(const char *s)
{
  100673:	8b 54 24 04          	mov    0x4(%esp),%edx
  100677:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100679:	eb 01                	jmp    10067c <strlen+0x9>
		++n;
  10067b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10067c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100680:	75 f9                	jne    10067b <strlen+0x8>
		++n;
	return n;
}
  100682:	c3                   	ret    

00100683 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100683:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100687:	31 c0                	xor    %eax,%eax
  100689:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10068d:	eb 01                	jmp    100690 <strnlen+0xd>
		++n;
  10068f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100690:	39 d0                	cmp    %edx,%eax
  100692:	74 06                	je     10069a <strnlen+0x17>
  100694:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100698:	75 f5                	jne    10068f <strnlen+0xc>
		++n;
	return n;
}
  10069a:	c3                   	ret    

0010069b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10069b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10069c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006a1:	53                   	push   %ebx
  1006a2:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1006a4:	76 05                	jbe    1006ab <console_putc+0x10>
  1006a6:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006ab:	80 fa 0a             	cmp    $0xa,%dl
  1006ae:	75 2c                	jne    1006dc <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006b0:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006b6:	be 50 00 00 00       	mov    $0x50,%esi
  1006bb:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006bd:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006c0:	99                   	cltd   
  1006c1:	f7 fe                	idiv   %esi
  1006c3:	89 de                	mov    %ebx,%esi
  1006c5:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006c7:	eb 07                	jmp    1006d0 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006c9:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006cc:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1006cd:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006d0:	83 f8 50             	cmp    $0x50,%eax
  1006d3:	75 f4                	jne    1006c9 <console_putc+0x2e>
  1006d5:	29 d0                	sub    %edx,%eax
  1006d7:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006da:	eb 0b                	jmp    1006e7 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006dc:	0f b6 d2             	movzbl %dl,%edx
  1006df:	09 ca                	or     %ecx,%edx
  1006e1:	66 89 13             	mov    %dx,(%ebx)
  1006e4:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006e7:	5b                   	pop    %ebx
  1006e8:	5e                   	pop    %esi
  1006e9:	c3                   	ret    

001006ea <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006ea:	56                   	push   %esi
  1006eb:	53                   	push   %ebx
  1006ec:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006f0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006f3:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006f7:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006fc:	75 04                	jne    100702 <fill_numbuf+0x18>
  1006fe:	85 d2                	test   %edx,%edx
  100700:	74 10                	je     100712 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100702:	89 d0                	mov    %edx,%eax
  100704:	31 d2                	xor    %edx,%edx
  100706:	f7 f1                	div    %ecx
  100708:	4b                   	dec    %ebx
  100709:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10070c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10070e:	89 c2                	mov    %eax,%edx
  100710:	eb ec                	jmp    1006fe <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100712:	89 d8                	mov    %ebx,%eax
  100714:	5b                   	pop    %ebx
  100715:	5e                   	pop    %esi
  100716:	c3                   	ret    

00100717 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100717:	55                   	push   %ebp
  100718:	57                   	push   %edi
  100719:	56                   	push   %esi
  10071a:	53                   	push   %ebx
  10071b:	83 ec 38             	sub    $0x38,%esp
  10071e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100722:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100726:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10072a:	e9 60 03 00 00       	jmp    100a8f <console_vprintf+0x378>
		if (*format != '%') {
  10072f:	80 fa 25             	cmp    $0x25,%dl
  100732:	74 13                	je     100747 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100734:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100738:	0f b6 d2             	movzbl %dl,%edx
  10073b:	89 f0                	mov    %esi,%eax
  10073d:	e8 59 ff ff ff       	call   10069b <console_putc>
  100742:	e9 45 03 00 00       	jmp    100a8c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100747:	47                   	inc    %edi
  100748:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10074f:	00 
  100750:	eb 12                	jmp    100764 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100752:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100753:	8a 11                	mov    (%ecx),%dl
  100755:	84 d2                	test   %dl,%dl
  100757:	74 1a                	je     100773 <console_vprintf+0x5c>
  100759:	89 e8                	mov    %ebp,%eax
  10075b:	38 c2                	cmp    %al,%dl
  10075d:	75 f3                	jne    100752 <console_vprintf+0x3b>
  10075f:	e9 3f 03 00 00       	jmp    100aa3 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100764:	8a 17                	mov    (%edi),%dl
  100766:	84 d2                	test   %dl,%dl
  100768:	74 0b                	je     100775 <console_vprintf+0x5e>
  10076a:	b9 d4 0a 10 00       	mov    $0x100ad4,%ecx
  10076f:	89 d5                	mov    %edx,%ebp
  100771:	eb e0                	jmp    100753 <console_vprintf+0x3c>
  100773:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100775:	8d 42 cf             	lea    -0x31(%edx),%eax
  100778:	3c 08                	cmp    $0x8,%al
  10077a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100781:	00 
  100782:	76 13                	jbe    100797 <console_vprintf+0x80>
  100784:	eb 1d                	jmp    1007a3 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100786:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10078b:	0f be c0             	movsbl %al,%eax
  10078e:	47                   	inc    %edi
  10078f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100793:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100797:	8a 07                	mov    (%edi),%al
  100799:	8d 50 d0             	lea    -0x30(%eax),%edx
  10079c:	80 fa 09             	cmp    $0x9,%dl
  10079f:	76 e5                	jbe    100786 <console_vprintf+0x6f>
  1007a1:	eb 18                	jmp    1007bb <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007a3:	80 fa 2a             	cmp    $0x2a,%dl
  1007a6:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007ad:	ff 
  1007ae:	75 0b                	jne    1007bb <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007b0:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007b3:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007b4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007b7:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007bb:	83 cd ff             	or     $0xffffffff,%ebp
  1007be:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007c1:	75 37                	jne    1007fa <console_vprintf+0xe3>
			++format;
  1007c3:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007c4:	31 ed                	xor    %ebp,%ebp
  1007c6:	8a 07                	mov    (%edi),%al
  1007c8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007cb:	80 fa 09             	cmp    $0x9,%dl
  1007ce:	76 0d                	jbe    1007dd <console_vprintf+0xc6>
  1007d0:	eb 17                	jmp    1007e9 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007d2:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007d5:	0f be c0             	movsbl %al,%eax
  1007d8:	47                   	inc    %edi
  1007d9:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007dd:	8a 07                	mov    (%edi),%al
  1007df:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007e2:	80 fa 09             	cmp    $0x9,%dl
  1007e5:	76 eb                	jbe    1007d2 <console_vprintf+0xbb>
  1007e7:	eb 11                	jmp    1007fa <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007e9:	3c 2a                	cmp    $0x2a,%al
  1007eb:	75 0b                	jne    1007f8 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007ed:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007f0:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007f1:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007f4:	85 ed                	test   %ebp,%ebp
  1007f6:	79 02                	jns    1007fa <console_vprintf+0xe3>
  1007f8:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007fa:	8a 07                	mov    (%edi),%al
  1007fc:	3c 64                	cmp    $0x64,%al
  1007fe:	74 34                	je     100834 <console_vprintf+0x11d>
  100800:	7f 1d                	jg     10081f <console_vprintf+0x108>
  100802:	3c 58                	cmp    $0x58,%al
  100804:	0f 84 a2 00 00 00    	je     1008ac <console_vprintf+0x195>
  10080a:	3c 63                	cmp    $0x63,%al
  10080c:	0f 84 bf 00 00 00    	je     1008d1 <console_vprintf+0x1ba>
  100812:	3c 43                	cmp    $0x43,%al
  100814:	0f 85 d0 00 00 00    	jne    1008ea <console_vprintf+0x1d3>
  10081a:	e9 a3 00 00 00       	jmp    1008c2 <console_vprintf+0x1ab>
  10081f:	3c 75                	cmp    $0x75,%al
  100821:	74 4d                	je     100870 <console_vprintf+0x159>
  100823:	3c 78                	cmp    $0x78,%al
  100825:	74 5c                	je     100883 <console_vprintf+0x16c>
  100827:	3c 73                	cmp    $0x73,%al
  100829:	0f 85 bb 00 00 00    	jne    1008ea <console_vprintf+0x1d3>
  10082f:	e9 86 00 00 00       	jmp    1008ba <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100834:	83 c3 04             	add    $0x4,%ebx
  100837:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10083a:	89 d1                	mov    %edx,%ecx
  10083c:	c1 f9 1f             	sar    $0x1f,%ecx
  10083f:	89 0c 24             	mov    %ecx,(%esp)
  100842:	31 ca                	xor    %ecx,%edx
  100844:	55                   	push   %ebp
  100845:	29 ca                	sub    %ecx,%edx
  100847:	68 dc 0a 10 00       	push   $0x100adc
  10084c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100851:	8d 44 24 40          	lea    0x40(%esp),%eax
  100855:	e8 90 fe ff ff       	call   1006ea <fill_numbuf>
  10085a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10085e:	58                   	pop    %eax
  10085f:	5a                   	pop    %edx
  100860:	ba 01 00 00 00       	mov    $0x1,%edx
  100865:	8b 04 24             	mov    (%esp),%eax
  100868:	83 e0 01             	and    $0x1,%eax
  10086b:	e9 a5 00 00 00       	jmp    100915 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100870:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100873:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100878:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10087b:	55                   	push   %ebp
  10087c:	68 dc 0a 10 00       	push   $0x100adc
  100881:	eb 11                	jmp    100894 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100883:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100886:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100889:	55                   	push   %ebp
  10088a:	68 f0 0a 10 00       	push   $0x100af0
  10088f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100894:	8d 44 24 40          	lea    0x40(%esp),%eax
  100898:	e8 4d fe ff ff       	call   1006ea <fill_numbuf>
  10089d:	ba 01 00 00 00       	mov    $0x1,%edx
  1008a2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1008a6:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008a8:	59                   	pop    %ecx
  1008a9:	59                   	pop    %ecx
  1008aa:	eb 69                	jmp    100915 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008ac:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008af:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008b2:	55                   	push   %ebp
  1008b3:	68 dc 0a 10 00       	push   $0x100adc
  1008b8:	eb d5                	jmp    10088f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008ba:	83 c3 04             	add    $0x4,%ebx
  1008bd:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008c0:	eb 40                	jmp    100902 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008c2:	83 c3 04             	add    $0x4,%ebx
  1008c5:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008c8:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1008cc:	e9 bd 01 00 00       	jmp    100a8e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008d1:	83 c3 04             	add    $0x4,%ebx
  1008d4:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008d7:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008db:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008e0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008e4:	88 44 24 24          	mov    %al,0x24(%esp)
  1008e8:	eb 27                	jmp    100911 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008ea:	84 c0                	test   %al,%al
  1008ec:	75 02                	jne    1008f0 <console_vprintf+0x1d9>
  1008ee:	b0 25                	mov    $0x25,%al
  1008f0:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008f4:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008f9:	80 3f 00             	cmpb   $0x0,(%edi)
  1008fc:	74 0a                	je     100908 <console_vprintf+0x1f1>
  1008fe:	8d 44 24 24          	lea    0x24(%esp),%eax
  100902:	89 44 24 04          	mov    %eax,0x4(%esp)
  100906:	eb 09                	jmp    100911 <console_vprintf+0x1fa>
				format--;
  100908:	8d 54 24 24          	lea    0x24(%esp),%edx
  10090c:	4f                   	dec    %edi
  10090d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100911:	31 d2                	xor    %edx,%edx
  100913:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100915:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100917:	83 fd ff             	cmp    $0xffffffff,%ebp
  10091a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100921:	74 1f                	je     100942 <console_vprintf+0x22b>
  100923:	89 04 24             	mov    %eax,(%esp)
  100926:	eb 01                	jmp    100929 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100928:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100929:	39 e9                	cmp    %ebp,%ecx
  10092b:	74 0a                	je     100937 <console_vprintf+0x220>
  10092d:	8b 44 24 04          	mov    0x4(%esp),%eax
  100931:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100935:	75 f1                	jne    100928 <console_vprintf+0x211>
  100937:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10093a:	89 0c 24             	mov    %ecx,(%esp)
  10093d:	eb 1f                	jmp    10095e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  10093f:	42                   	inc    %edx
  100940:	eb 09                	jmp    10094b <console_vprintf+0x234>
  100942:	89 d1                	mov    %edx,%ecx
  100944:	8b 14 24             	mov    (%esp),%edx
  100947:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10094b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10094f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100953:	75 ea                	jne    10093f <console_vprintf+0x228>
  100955:	8b 44 24 08          	mov    0x8(%esp),%eax
  100959:	89 14 24             	mov    %edx,(%esp)
  10095c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10095e:	85 c0                	test   %eax,%eax
  100960:	74 0c                	je     10096e <console_vprintf+0x257>
  100962:	84 d2                	test   %dl,%dl
  100964:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10096b:	00 
  10096c:	75 24                	jne    100992 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10096e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100973:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10097a:	00 
  10097b:	75 15                	jne    100992 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10097d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100981:	83 e0 08             	and    $0x8,%eax
  100984:	83 f8 01             	cmp    $0x1,%eax
  100987:	19 c9                	sbb    %ecx,%ecx
  100989:	f7 d1                	not    %ecx
  10098b:	83 e1 20             	and    $0x20,%ecx
  10098e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100992:	3b 2c 24             	cmp    (%esp),%ebp
  100995:	7e 0d                	jle    1009a4 <console_vprintf+0x28d>
  100997:	84 d2                	test   %dl,%dl
  100999:	74 40                	je     1009db <console_vprintf+0x2c4>
			zeros = precision - len;
  10099b:	2b 2c 24             	sub    (%esp),%ebp
  10099e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009a2:	eb 3f                	jmp    1009e3 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009a4:	84 d2                	test   %dl,%dl
  1009a6:	74 33                	je     1009db <console_vprintf+0x2c4>
  1009a8:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009ac:	83 e0 06             	and    $0x6,%eax
  1009af:	83 f8 02             	cmp    $0x2,%eax
  1009b2:	75 27                	jne    1009db <console_vprintf+0x2c4>
  1009b4:	45                   	inc    %ebp
  1009b5:	75 24                	jne    1009db <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009b7:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009b9:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009bc:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009c1:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009c4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009c7:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009cb:	7d 0e                	jge    1009db <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1009cd:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009d1:	29 ca                	sub    %ecx,%edx
  1009d3:	29 c2                	sub    %eax,%edx
  1009d5:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009d9:	eb 08                	jmp    1009e3 <console_vprintf+0x2cc>
  1009db:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009e2:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009e3:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009e7:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009e9:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009ed:	2b 2c 24             	sub    (%esp),%ebp
  1009f0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009f5:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009f8:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009fb:	29 c5                	sub    %eax,%ebp
  1009fd:	89 f0                	mov    %esi,%eax
  1009ff:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a03:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a07:	eb 0f                	jmp    100a18 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a09:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a0d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a12:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a13:	e8 83 fc ff ff       	call   10069b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a18:	85 ed                	test   %ebp,%ebp
  100a1a:	7e 07                	jle    100a23 <console_vprintf+0x30c>
  100a1c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a21:	74 e6                	je     100a09 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a23:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a28:	89 c6                	mov    %eax,%esi
  100a2a:	74 23                	je     100a4f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a2c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a31:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a35:	e8 61 fc ff ff       	call   10069b <console_putc>
  100a3a:	89 c6                	mov    %eax,%esi
  100a3c:	eb 11                	jmp    100a4f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a3e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a42:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a47:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a48:	e8 4e fc ff ff       	call   10069b <console_putc>
  100a4d:	eb 06                	jmp    100a55 <console_vprintf+0x33e>
  100a4f:	89 f0                	mov    %esi,%eax
  100a51:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a55:	85 f6                	test   %esi,%esi
  100a57:	7f e5                	jg     100a3e <console_vprintf+0x327>
  100a59:	8b 34 24             	mov    (%esp),%esi
  100a5c:	eb 15                	jmp    100a73 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a5e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a62:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a63:	0f b6 11             	movzbl (%ecx),%edx
  100a66:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a6a:	e8 2c fc ff ff       	call   10069b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a6f:	ff 44 24 04          	incl   0x4(%esp)
  100a73:	85 f6                	test   %esi,%esi
  100a75:	7f e7                	jg     100a5e <console_vprintf+0x347>
  100a77:	eb 0f                	jmp    100a88 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a79:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a7d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a82:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a83:	e8 13 fc ff ff       	call   10069b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a88:	85 ed                	test   %ebp,%ebp
  100a8a:	7f ed                	jg     100a79 <console_vprintf+0x362>
  100a8c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a8e:	47                   	inc    %edi
  100a8f:	8a 17                	mov    (%edi),%dl
  100a91:	84 d2                	test   %dl,%dl
  100a93:	0f 85 96 fc ff ff    	jne    10072f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a99:	83 c4 38             	add    $0x38,%esp
  100a9c:	89 f0                	mov    %esi,%eax
  100a9e:	5b                   	pop    %ebx
  100a9f:	5e                   	pop    %esi
  100aa0:	5f                   	pop    %edi
  100aa1:	5d                   	pop    %ebp
  100aa2:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100aa3:	81 e9 d4 0a 10 00    	sub    $0x100ad4,%ecx
  100aa9:	b8 01 00 00 00       	mov    $0x1,%eax
  100aae:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ab0:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ab1:	09 44 24 14          	or     %eax,0x14(%esp)
  100ab5:	e9 aa fc ff ff       	jmp    100764 <console_vprintf+0x4d>

00100aba <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100aba:	8d 44 24 10          	lea    0x10(%esp),%eax
  100abe:	50                   	push   %eax
  100abf:	ff 74 24 10          	pushl  0x10(%esp)
  100ac3:	ff 74 24 10          	pushl  0x10(%esp)
  100ac7:	ff 74 24 10          	pushl  0x10(%esp)
  100acb:	e8 47 fc ff ff       	call   100717 <console_vprintf>
  100ad0:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100ad3:	c3                   	ret    
