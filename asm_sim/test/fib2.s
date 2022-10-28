fib.9:
*	addi	x5, x0, 1	# 3
*	ble		x4, x5, ble.22	# 3
	addi	x5, x0, 1	# 4
	sub		x5, x4, x5	# 4
	sw		x4, 0(x2)	# 4
	addi	x4, x5, 0
	sw		x1, 4(x2)
*	jal		x0, fib.9
	addi	x2, x2, 8	
	sub		x2, x0, x2	# 4
	addi	x2, x2, 8	# 4
	sub		x2, x0, x2	# 4
	lw		x1, 4(x2)
	ori		x5, 2	# 4
	lw		x6, 0(x2)	# 4
	sub		x5, x6, x5	# 4
	sw		x4, 4(x2)	# 4
	addi	x4, x5, 0
	sw		x1, 12(x2)
*	jal		x0, fib.9
	addi	x2, x2, 16	
	sub		x2, x0, x2	# 4
	addi	x2, x2, 16	# 4
	sub		x2, x0, x2	# 4
	lw		x1, 12(x2)
	lw		x5, 4(x2)	# 4
	add		x4, x5, x4	# 4
	jalr	x0, x1, 0
ble.22:
*	jalr	x0, x1, 0
min_caml_start:
*	addi	x2, x2, -112
*	ori		x4, 1	# 5
*	sw		x1, 4(x2)
*	jal		x0, fib.9
	addi	x2, x2, 8	
	sub		x2, x0, x2	# 5
	addi	x2, x2, 8	# 5
	sub		x2, x0, x2	# 5
	lw		x1, 4(x2)
	addi	x2, x2, 112
	jalr	x0, x1, 0
