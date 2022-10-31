fib.10:
	lui		x5, 0	# 2
	ori		x5, x0, 1	# 2
	ble		x4, x5, ble.24	# 2
	lui		x5, 0	# 3
	ori		x5, x0, 1	# 3
	sub		x5, x4, x5	# 3
	sw		x4, 0(x2)	# 3
	addi	x4, x5, 0
	sw		x1, 4(x2)
	addi	x2, x2, 8	
	jal		x1, fib.10
	addi	x2, x2, -8	
	lw		x1, 4(x2)
	lui		x5, 0	# 3
	ori		x5, x0, 2	# 3
	lw		x6, 0(x2)	# 3
	sub		x5, x6, x5	# 3
	sw		x4, 4(x2)	# 3
	addi	x4, x5, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16	
	jal		x1, fib.10
	addi	x2, x2, -16	
	lw		x1, 12(x2)
	lw		x5, 4(x2)	# 3
	add		x4, x5, x4	# 3
	jalr	x0, x1, 0
ble.24:
	jalr	x0, x1, 0
min_caml_start:
	addi	x2, x2, -112
	lui		x4, 0	# 4
	ori		x4, x0, 30	# 4
	sw		x1, 4(x2)
	addi	x2, x2, 8	
	jal		x1, fib.10
	addi	x2, x2, -8	
	lw		x1, 4(x2)
	sw		x1, 4(x2)
*	addi	x2, x2, 8	
*	jal		x1, min_caml_print_int
	addi	x2, x2, -8	
	lw		x1, 4(x2)
	addi	x10, x4, 0
	addi	x2, x2, 112
