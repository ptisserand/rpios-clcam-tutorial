.globl GetGpioAddress
GetGpioAddress:
	ldr r0,=0x20200000 /* r0 and r1 are used to return value */
	mov pc,lr

.globl SetGpioFunction
SetGpioFunction:	/* r0: GPIO pin number, r1: function number */
	cmp r0,#53	/* check if valid 54 pins */
	cmpls r1,#7	/* 8 functions */
	movhi pc,lr	/* return if input not valid */

	push {lr}	/* store lr on stack */
	mov r2,r0	/* GetGpioAddress willl change r0 */
	bl GetGpioAddress
	
	/* here: r0: GPIO adress, r1: function number, r2: GPIO pin number */
	/* find correct block */
functionLoop$:
	cmp r2,#9
	subhi r2,#10
	addhi r0,#4		/* r0 will point to correct block */
	bhi functionLoop$

	add r2, r2,lsl #1	/* r2 * 3 == r2 + r2 * 2 */
	lsl r1, r2
	str r1,[r0]

	pop {pc}		/* return */

.globl SetGpio
SetGpio:		/* r0: GPIO pin number, r1: value */
	pinNum .req r0
	pinVal .req r1

	cmp pinNum,#53	/* check if pin number is valid */
	movhi pc,lr
	push {lr}

	mov r2,pinNum
	.unreq pinNum
	pinNum .req r2
	bl GetGpioAddress
	gpioAddr .req r0

	/* divide pin number by 32 since we have 2 bank set */
	pinBank .req r3
	lsr pinBank,pinNum,#5
	lsl pinBank,#2
	add gpioAddr,pinBank	/* gpioAddr have correct  bank adress */
	.unreq pinBank

	and pinNum,#31
	setBit .req r3
	mov setBit,#1
	lsl setBit,pinNum	/* setBit is mask to apply */
	.unreq pinNum

	teq pinVal,#0
	.unreq pinVal
	streq setBit,[gpioAddr,#40]	/* set on */
	strne setBit,[gpioAddr,#28]	/* set off */
	.unreq setBit
	.unreq gpioAddr

	pop {pc}		/* return */
	
	
	
	
