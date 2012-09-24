.section .init
.globl _start
_start:
	/* setup GPIO 16 as output */
	ldr r0,=0x20200000 	/* GPIO controler */
	mov r1,#1		/* Enable output */
	lsl r1,#18		/* on GPIO n + 6 */
	str r1,[r0,#4]		/* with n = 10 (second bank) */

	/* play with LED */
	mov r1,#1
	lsl r1,#16

loop$:
	/* delay before turning on */
	mov r2,#0x3F0000
wait1$:
	sub r2,#1
	cmp r2,#0
	bne wait1$

	/* turn on */
	str r1,[r0,#40]

	/* delay before turning off */
	mov r2,#0x3F0000
wait2$:
	sub r2,#1
	cmp r2,#0
	bne wait2$
	
	/* turn off */
	str r1,[r0,#28]

	b loop$
