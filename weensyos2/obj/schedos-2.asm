
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
sys_user1(int priority)
{
        // We call a system call by causing an interrupt with the 'int'
        // instruction.  In weensyos, the type of system call is indicated
        // by the interrupt number -- here, INT_SYS_USER1.
        asm volatile("int %0\n"
  300000:	b8 d3 f5 ff ff       	mov    $0xfffff5d3,%eax
  300005:	cd 32                	int    $0x32
  300007:	31 c0                	xor    %eax,%eax

	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  300009:	8b 15 00 80 19 00    	mov    0x198000,%edx
  30000f:	66 c7 02 32 0a       	movw   $0xa32,(%edx)
  300014:	83 c2 02             	add    $0x2,%edx
  300017:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  30001d:	cd 30                	int    $0x30

        #endif

	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  30001f:	40                   	inc    %eax
  300020:	3d 40 01 00 00       	cmp    $0x140,%eax
  300025:	75 e2                	jne    300009 <start+0x9>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300027:	66 b8 01 00          	mov    $0x1,%ax
  30002b:	cd 31                	int    $0x31
  30002d:	eb fe                	jmp    30002d <start+0x2d>
