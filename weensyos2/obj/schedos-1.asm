
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
#define PRINTCHAR	('1' | 0x0C00)
#endif

void
start(void)
{
  200000:	31 c0                	xor    %eax,%eax
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  200002:	8b 15 00 80 19 00    	mov    0x198000,%edx
  200008:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  20000d:	83 c2 02             	add    $0x2,%edx
  200010:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200016:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  200018:	40                   	inc    %eax
  200019:	3d 40 01 00 00       	cmp    $0x140,%eax
  20001e:	75 e2                	jne    200002 <start+0x2>
sys_user1(void)
{
        // We call a system call by causing an interrupt with the 'int'
        // instruction.  In weensyos, the type of system call is indicated
        // by the interrupt number -- here, INT_SYS_USER1.
        asm volatile("int %0\n"
  200020:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200022:	cd 30                	int    $0x30
  200024:	eb fc                	jmp    200022 <start+0x22>
