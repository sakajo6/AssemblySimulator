min_caml_start:
	addi	x4, x0, 0
	addi	x5, x0, 10
	sw		x5, 100(x4)
	lw		x6, 100(x4)
	addi	x6, x6, -2
	addi	x7, x7, 2
	ble		x6, x7, ret01	
	addi	x1, x0, 1
	addi	x2, x0, 1
	addi	x8, x8, 0
fib:
	addi	x3, x2, 0
	add		x2, x1, x2
	addi	x1, x3, 0
	addi	x8, x8, 1
	ble		x8, x6, fib	
	jal		x0, end	
ret01:
	addi	x6, x0, 1
	addi	x2, x6, 0
end:
	sw		x2, 100(x4)
