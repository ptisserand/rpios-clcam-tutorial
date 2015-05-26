.section .init
.globl _start
_start:
	b main

.section .text
main:
	mov sp,#0x8000

	mov r0,#16		/* LED is plugged on pin 16 */
	mov r1,#1		/* set GPIO as output */
	bl SetGpioFunction

	ptrn .req r4
	ldr ptrn,=pattern
	/* ldr ptrn,[ptrn] */
	seq .req r5
	mov seq,#0
	
loop$:
	mov r0,#16		/* LED 16 */
	mov r1,#1
	
	lsl r1,r1,seq
	and r1,r1,ptrn
	bl SetGpio
	ldr r0, =250000
	bl Wait

	add seq,#1	
	and seq,seq,#0b11111

	b loop$

.section .data
.align 2
pattern:
.int 0b00000000001010100010001000101010
