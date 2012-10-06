.section .init
.globl _start
_start:
	b main

.section .text
main:
	mov sp,#0x8000

	pinNum .req r0
	pinFunc .req r1
	mov pinNum,#16		/* LED is plugged on pin 16 */
	mov pinFunc,#1		/* set GPIO as output */
	bl SetGpioFunction
	.unreq pinNum
	.unreq pinFunc

loop$:
	/* delay before turning on */
	mov r2,#0x3F0000
wait1$:
	sub r2,#1
	cmp r2,#0
	bne wait1$

	/* turn on */
	pinNum .req r0
	pinVal .req r1
	mov pinNum,#16		/* LED 16 */
	mov pinVal,#0		/* turn on */
	bl SetGpio
	.unreq pinNum
	.unreq pinVal
	
	/* delay before turning off */
	mov r2,#0x3F0000
wait2$:
	sub r2,#1
	cmp r2,#0
	bne wait2$
	
	/* turn off */
	pinNum .req r0
	pinVal .req r1
	mov pinNum,#16		/* LED 16 */
	mov pinVal,#1		/* turn off */
	bl SetGpio
	.unreq pinNum
	.unreq pinVal

	b loop$
