ble.22:
	jalr	x0, x1, 0
end:
	sw		x10, 0(x0)
min_caml_start:
	addi	x2, x2, -112
	lui		x4, 0
	ori		x4, x0, 10
	sw		x1, 4(x2)
	addi	x2, x2, 8	
	jal		x1, fib.9
	addi	x2, x2, -8	
	lw		x1, 4(x2)
	addi	x10, x4, 0
*	addi	x2, x2, 112
