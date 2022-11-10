	jal		x0, min_caml_start
l.186:	# 6.000000
	.word	6.000000
l.184:	# 5.000000
	.word	5.000000
l.182:	# 4.000000
	.word	4.000000
l.176:	# 3.000000
	.word	3.000000
l.174:	# 2.000000
	.word	2.000000
l.172:	# 1.000000
	.word	1.000000
l.170:	# 1000000.000000
	.word	1000000.000000
getx.87:
	flw		f0, 0(x4)	# 47
	fsub	f10, f10, f10	# 47
	fadd	f10, f10, f0	# 47
	jalr	x0, x1, 0
gety.89:
	flw		f0, 8(x4)	# 48
	fsub	f10, f10, f10	# 48
	fadd	f10, f10, f0	# 48
	jalr	x0, x1, 0
getz.91:
	flw		f0, 16(x4)	# 49
	fsub	f10, f10, f10	# 49
	fadd	f10, f10, f0	# 49
	jalr	x0, x1, 0
inprod.93:
	sw		x4, 0(x2)	# 51
	sw		x5, 4(x2)	# 51
	sw		x1, 12(x2)
	addi	x2, x2, 16	
	jal		x1, getx.87
	addi	x2, x2, -16	
	lw		x1, 12(x2)
	addi	f0, f10, 0	# 51
	lw		x4, 4(x2)	# 51
	fsw		f0, 8(x2)	# 51
	sw		x1, 20(x2)
	addi	x2, x2, 24	
	jal		x1, getx.87
	addi	x2, x2, -24	
	lw		x1, 20(x2)
	addi	f0, f10, 0	# 51
	flw		f1, 8(x2)	# 51
	fmul	f0, f1, f0	# 51
	lw		x4, 0(x2)	# 51
	fsw		f0, 16(x2)	# 51
	sw		x1, 28(x2)
	addi	x2, x2, 32	
	jal		x1, gety.89
	addi	x2, x2, -32	
	lw		x1, 28(x2)
	addi	f0, f10, 0	# 51
	lw		x4, 4(x2)	# 51
	fsw		f0, 24(x2)	# 51
	sw		x1, 36(x2)
	addi	x2, x2, 40	
	jal		x1, gety.89
	addi	x2, x2, -40	
	lw		x1, 36(x2)
	addi	f0, f10, 0	# 51
	flw		f1, 24(x2)	# 51
	fmul	f0, f1, f0	# 51
	flw		f1, 16(x2)	# 51
	fadd	f0, f1, f0	# 51
	lw		x4, 0(x2)	# 51
	fsw		f0, 32(x2)	# 51
	sw		x1, 44(x2)
	addi	x2, x2, 48	
	jal		x1, getz.91
	addi	x2, x2, -48	
	lw		x1, 44(x2)
	addi	f0, f10, 0	# 51
	lw		x4, 4(x2)	# 51
	fsw		f0, 40(x2)	# 51
	sw		x1, 52(x2)
	addi	x2, x2, 56	
	jal		x1, getz.91
	addi	x2, x2, -56	
	lw		x1, 52(x2)
	addi	f0, f10, 0	# 51
	flw		f1, 40(x2)	# 51
	fmul	f0, f1, f0	# 51
	flw		f1, 32(x2)	# 51
	fadd	f10, f1, f0	# 51
	jalr	x0, x1, 0
min_caml_start:
	addi	x2, x2, -112
	lui		x4, %hi(l.170)	# 52
	ori		x4, %lo(l.170)	# 52
	flw		f0, 0(x4)	# 52
	lui		x4, %hi(l.172)	# 52
	ori		x4, %lo(l.172)	# 52
	flw		f1, 0(x4)	# 52
	lui		x4, %hi(l.174)	# 52
	ori		x4, %lo(l.174)	# 52
	flw		f2, 0(x4)	# 52
	lui		x4, %hi(l.176)	# 52
	ori		x4, %lo(l.176)	# 52
	flw		f3, 0(x4)	# 52
	addi	x4, x3, 0	# 52
	addi	x3, x3, 24	# 52
	fsw		f3, 16(x4)	# 52
	fsw		f2, 8(x4)	# 52
	fsw		f1, 0(x4)	# 52
	lui		x5, %hi(l.182)	# 52
	ori		x5, %lo(l.182)	# 52
	flw		f1, 0(x5)	# 52
	lui		x5, %hi(l.184)	# 52
	ori		x5, %lo(l.184)	# 52
	flw		f2, 0(x5)	# 52
	lui		x5, %hi(l.186)	# 52
	ori		x5, %lo(l.186)	# 52
	flw		f3, 0(x5)	# 52
	addi	x5, x3, 0	# 52
	addi	x3, x3, 24	# 52
	fsw		f3, 16(x5)	# 52
	fsw		f2, 8(x5)	# 52
	fsw		f1, 0(x5)	# 52
	fsw		f0, 0(x2)	# 52
	sw		x1, 12(x2)
	addi	x2, x2, 16	
	jal		x1, inprod.93
	addi	x2, x2, -16	
	lw		x1, 12(x2)
	addi	f0, f10, 0	# 52
	flw		f1, 0(x2)	# 52
	fmul	f0, f1, f0	# 52
	sw		x1, 12(x2)
	addi	x2, x2, 16	
*	jal		x1, min_caml_truncat
	addi	x2, x2, -16	
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 52
	sw		x1, 12(x2)
	addi	x2, x2, 16	
*	jal		x1, min_caml_print_int
	addi	x2, x2, -16	
	lw		x1, 12(x2)
	addi	x2, x2, 112
	EXIT
