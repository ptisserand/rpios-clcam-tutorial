.section .init
.globl _start
_start:
	/* setup GPIO 16 as output */
	ldr r0,=0x20200000 	/* GPIO controler */
	mov r1,#1		/* Enable output */
	lsl r1,#18		/* on GPIO n + 6 */
	str r1,[r0,#4]		/* with n = 10 (second bank) */

	/* now turn on LED */
	mov r1,#1		/* Turn on */
	lsl r1,#16
	str r1,[r0,#40]
loop$:
	b loop$
	
	
	