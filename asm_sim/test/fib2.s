min_caml_start:
	addi	x2, x2, -112
	lui		x4, 0	# 5
	ori		x4, x0, 5	# 5
	sw		x1, 4(x2)
	addi	x2, x2, 8	
	jal		x1, fib.9
	addi	x2, x2, -8	
	lw		x1, 4(x2)
	addi	x10, x4, 0
	addi	x2, x2, 112
	jal		x1, end
fib.9:
	lui		x5, 0	# 3
	ori		x5, x0, 1	# 3
	ble		x4, x5, ble.22	# 3
	lui		x5, 0	# 4
	ori		x5, x0, 1	# 4
	sub		x5, x4, x5	# 4
	sw		x4, 0(x2)	# 4
	addi	x4, x5, 0
	sw		x1, 4(x2)
	addi	x2, x2, 8	
	jal		x1, fib.9
	addi	x2, x2, -8	
	lw		x1, 4(x2)
	lui		x5, 0	# 4
	ori		x5, x0, 2	# 4
	lw		x6, 0(x2)	# 4
	sub		x5, x6, x5	# 4
	sw		x4, 4(x2)	# 4
	addi	x4, x5, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16	
	jal		x1, fib.9
	addi	x2, x2, -16	
	lw		x1, 12(x2)
	lw		x5, 4(x2)	# 4
	add		x4, x5, x4	# 4
	jalr	x0, x1, 0
ble.22:
	jalr	x0, x1, 0
end:
	sw		x10,	0(x0)
