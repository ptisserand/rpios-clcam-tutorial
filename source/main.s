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
	/* turn on */
	pinNum .req r0
	pinVal .req r1
	mov pinNum,#16		/* LED 16 */
	mov pinVal,#0		/* turn on */
	bl SetGpio
	.unreq pinNum
	.unreq pinVal

loop$:
	/* delay */
	ldr r0, =0x7a120
	bl Wait
	/* turn on */
	pinNum .req r0
	pinVal .req r1
	mov pinNum,#16		/* LED 16 */
	mov pinVal,#0		/* turn on */
	bl SetGpio
	.unreq pinNum
	.unreq pinVal

	/* delay */	
	ldr r0, =0xf4240
	bl Wait

	/* turn off */
	pinNum .req r0
	pinVal .req r1
	mov pinNum,#16		/* LED 16 */
	mov pinVal,#1		/* turn off */
	bl SetGpio
	.unreq pinNum
	.unreq pinVal

	b loop$
