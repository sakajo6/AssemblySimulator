fib.10:
	lui		x5, 1	# 2
	ble		x4, x5, ble.24	# 2
	lui		x5, 1	# 3
	sub		x5, x4, x5	# 3
	sw		x4, 0(x2)	# 3
	addi	x4, x5, 0
	sw		x1, 4(x2)
	jalr	x0, fib.10, 0
	addi	x2, x2, 8	
	sub		x2, x0, x2	# 3
	addi	x2, x2, 8	# 3
	sub		x2, x0, x2	# 3
	lw		x1, 4(x2)
	lui		x5, 2	# 3
	lw		x6, 0(x2)	# 3
	sub		x5, x6, x5	# 3
	sw		x4, 4(x2)	# 3
	addi	x4, x5, 0
	sw		x1, 12(x2)
	jalr	x0, fib.10, 0
	addi	x2, x2, 16	
	sub		x2, x0, x2	# 3
	addi	x2, x2, 16	# 3
	sub		x2, x0, x2	# 3
	lw		x1, 12(x2)
	lw		x5, 4(x2)	# 3
	add		x4, x5, x4	# 3
	jalr	x0, x1, 0
ble.24:
	jalr	x0, x1, 0
.globl	min_caml_start
min_caml_start:
	addi	x2, x2, -112
	lui		x4, 30	# 4
	sw		x1, 4(x2)
	jalr	x0, fib.10, 0
	addi	x2, x2, 8	
	sub		x2, x0, x2	# 4
	addi	x2, x2, 8	# 4
	sub		x2, x0, x2	# 4
	lw		x1, 4(x2)
	sw		x1, 4(x2)
	jalr	x0, min_caml_print_int, 0
	addi	x2, x2, 8	
	sub		x2, x0, x2	# 4
	addi	x2, x2, 8	# 4
	sub		x2, x0, x2	# 4
	lw		x1, 4(x2)
	addi	x2, x2, 112
	jalr	x0, x1, 0
