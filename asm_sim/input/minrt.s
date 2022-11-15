l.7351:	# 0.785398
	.word	0.785398
l.7349:	# 1.570796
	.word	1.570796
l.7347:	# 6.283185
	.word	6.283185
l.7345:	# 3.141593
	.word	3.141593
l.7339:	# 128.000000
	.word	128.000000
l.7265:	# 0.900000
	.word	0.900000
l.7067:	# 150.000000
	.word	150.000000
l.7063:	# -150.000000
	.word	-150.000000
l.7029:	# 0.100000
	.word	0.100000
l.7023:	# -2.000000
	.word	-2.000000
l.7019:	# 0.003906
	.word	0.003906
l.6966:	# 20.000000
	.word	20.000000
l.6964:	# 0.050000
	.word	0.050000
l.6953:	# 0.250000
	.word	0.250000
l.6941:	# 10.000000
	.word	10.000000
l.6933:	# 0.300000
	.word	0.300000
l.6931:	# 255.000000
	.word	255.000000
l.6926:	# 0.150000
	.word	0.150000
l.6918:	# 3.141593
	.word	3.141593
l.6916:	# 30.000000
	.word	30.000000
l.6914:	# 15.000000
	.word	15.000000
l.6912:	# 0.000100
	.word	0.000100
l.6821:	# 100000000.000000
	.word	100000000.000000
l.6812:	# 1000000000.000000
	.word	1000000000.000000
l.6770:	# -0.100000
	.word	-0.100000
l.6744:	# 0.010000
	.word	0.010000
l.6742:	# -0.200000
	.word	-0.200000
l.6345:	# 2.000000
	.word	2.000000
l.6275:	# -200.000000
	.word	-200.000000
l.6271:	# 200.000000
	.word	200.000000
l.6263:	# 0.017453
	.word	0.017453
l.6090:	# 0.142857
	.word	0.142857
l.6088:	# 0.200000
	.word	0.200000
l.6086:	# 0.333333
	.word	0.333333
l.6081:	# 0.001389
	.word	0.001389
l.6079:	# 0.041667
	.word	0.041667
l.6074:	# 0.000198
	.word	0.000198
l.6072:	# 0.008333
	.word	0.008333
l.6070:	# 0.166667
	.word	0.166667
l.6068:	# -1.000000
	.word	-1.000000
l.6062:	# 1.000000
	.word	1.000000
l.6060:	# 0.500000
	.word	0.500000
l.6055:	# 0.000000
	.word	0.000000
fiszero.2443:
	lui		x4, %hi(l.6055)	# 1
	ori		x4, %lo(l.6055)	# 1
	flw		f1, 0(x4)	# 1
	feq		f0, f1, feq.9594	# 1
	lui		x10, 0	# 1
	ori		x10, x0, 0	# 1
	jalr	x0, x1, 0
feq.9594:
	lui		x10, 1	# 1
	ori		x10, x0, 1	# 1
	jalr	x0, x1, 0
fispos.2445:
	lui		x4, %hi(l.6055)	# 2
	ori		x4, %lo(l.6055)	# 2
	flw		f1, 0(x4)	# 2
	fle		f0, f1, fle.9595	# 2
	lui		x10, 1	# 2
	ori		x10, x0, 1	# 2
	jalr	x0, x1, 0
fle.9595:
	lui		x10, 0	# 2
	ori		x10, x0, 0	# 2
	jalr	x0, x1, 0
fisneg.2447:
	lui		x4, %hi(l.6055)	# 3
	ori		x4, %lo(l.6055)	# 3
	flw		f1, 0(x4)	# 3
	fle		f1, f0, fle.9596	# 3
	lui		x10, 1	# 3
	ori		x10, x0, 1	# 3
	jalr	x0, x1, 0
fle.9596:
	lui		x10, 0	# 3
	ori		x10, x0, 0	# 3
	jalr	x0, x1, 0
fneg.2449:
	sub	f10, f10, f10	# 4
	sub	f10, f10, f0	# 4
	jalr	x0, x1, 0
fabs.2451:
	lui		x4, %hi(l.6055)	# 5
	ori		x4, %lo(l.6055)	# 5
	flw		f1, 0(x4)	# 5
	fle		f0, f1, fle.9597	# 5
	fsub	f10, f10, f10	# 5
	fadd	f10, f10, f0	# 5
	jalr	x0, x1, 0
fle.9597:
	sub	f10, f10, f10	# 5
	sub	f10, f10, f0	# 5
	jalr	x0, x1, 0
fless.2453:
	fle		f1, f0, fle.9598	# 6
	lui		x10, 1	# 6
	ori		x10, x0, 1	# 6
	jalr	x0, x1, 0
fle.9598:
	lui		x10, 0	# 6
	ori		x10, x0, 0	# 6
	jalr	x0, x1, 0
fhalf.2456:
	lui		x4, %hi(l.6060)	# 7
	ori		x4, %lo(l.6060)	# 7
	flw		f1, 0(x4)	# 7
	fmul	f10, f0, f1	# 7
	jalr	x0, x1, 0
fsqr.2458:
	fmul	f10, f0, f0	# 8
	jalr	x0, x1, 0
floor.2460:
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, min_caml_int_of_float
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 9
	jal		x0, min_caml_float_of_int	# 9
int_of_float.2462:
	lui		x4, %hi(l.6062)	# 10
	ori		x4, %lo(l.6062)	# 10
	flw		f1, 0(x4)	# 10
	fle		f1, f0, fle.9599	# 10
	lui		x10, 0	# 10
	ori		x10, x0, 0	# 10
	jalr	x0, x1, 0
fle.9599:
	lui		x4, %hi(l.6062)	# 10
	ori		x4, %lo(l.6062)	# 10
	flw		f1, 0(x4)	# 10
	fsub	f0, f0, f1	# 10
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, int_of_float.2462
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 10
	addi	x10, x4, 1	# 10
	jalr	x0, x1, 0
float_of_int.2464:
	lui		x5, 1	# 11
	ori		x5, x0, 1	# 11
	ble		x5, x4, ble.9600	# 11
	lui		x4, %hi(l.6055)	# 11
	ori		x4, %lo(l.6055)	# 11
	flw		f10, 0(x4)	# 11
	jalr	x0, x1, 0
ble.9600:
	lui		x5, 1	# 11
	ori		x5, x0, 1	# 11
	sub		x4, x4, x5	# 11
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, float_of_int.2464
	addi	x2, x2, -8
	lw		x1, 4(x2)
	fsub	f0, f0, f0	# 11
	fadd	f0, f0, f10	# 11
	lui		x4, %hi(l.6062)	# 11
	ori		x4, %lo(l.6062)	# 11
	flw		f1, 0(x4)	# 11
	fadd	f10, f0, f1	# 11
	jalr	x0, x1, 0
sin.2470:
	flw		f1, 32(x27)	# 27
	flw		f2, 24(x27)	# 27
	flw		f3, 16(x27)	# 27
	flw		f4, 8(x27)	# 27
	lui		x4, %hi(l.6055)	# 27
	ori		x4, %lo(l.6055)	# 27
	flw		f5, 0(x4)	# 27
	fle		f5, f0, fle.9601	# 27
	fadd	f0, f0, f3	# 27
	lw		x31, 0(x27)	# 27
	jalr	x0, x31, 0	# 27
fle.9601:
	fle		f0, f3, fle.9602	# 28
	fsub	f0, f0, f3	# 28
	lw		x31, 0(x27)	# 28
	jalr	x0, x31, 0	# 28
fle.9602:
	fle		f0, f4, fle.9603	# 29
	lui		x4, %hi(l.6068)	# 29
	ori		x4, %lo(l.6068)	# 29
	flw		f1, 0(x4)	# 29
	fsub	f0, f0, f4	# 29
	fsw		f1, 0(x2)	# 29
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	fsub	f0, f0, f0	# 29
	fadd	f0, f0, f10	# 29
	flw		f1, 0(x2)	# 29
	fmul	f10, f1, f0	# 29
	jalr	x0, x1, 0
fle.9603:
	fle		f0, f2, fle.9604	# 30
	fsub	f0, f4, f0	# 30
	lw		x31, 0(x27)	# 30
	jalr	x0, x31, 0	# 30
fle.9604:
	fle		f0, f1, fle.9605	# 31
	fsub	f0, f2, f0	# 31
	jal		x0, min_caml_cos	# 31
fle.9605:
	fmul	f1, f0, f0	# 33
	fmul	f2, f0, f1	# 34
	lui		x4, %hi(l.6070)	# 35
	ori		x4, %lo(l.6070)	# 35
	flw		f3, 0(x4)	# 35
	fmul	f3, f3, f2	# 35
	fsub	f0, f0, f3	# 35
	lui		x4, %hi(l.6072)	# 35
	ori		x4, %lo(l.6072)	# 35
	flw		f3, 0(x4)	# 35
	fmul	f3, f3, f1	# 35
	fmul	f3, f3, f2	# 35
	fadd	f0, f0, f3	# 35
	lui		x4, %hi(l.6074)	# 35
	ori		x4, %lo(l.6074)	# 35
	flw		f3, 0(x4)	# 35
	fmul	f3, f3, f1	# 35
	fmul	f1, f3, f1	# 35
	fmul	f1, f1, f2	# 35
	fsub	f10, f0, f1	# 35
	jalr	x0, x1, 0
cos.2472:
	lw		x4, 24(x27)	# 38
	flw		f1, 16(x27)	# 38
	flw		f2, 8(x27)	# 38
	lui		x5, %hi(l.6055)	# 38
	ori		x5, %lo(l.6055)	# 38
	flw		f3, 0(x5)	# 38
	fle		f3, f0, fle.9606	# 38
	fadd	f0, f0, f2	# 38
	addi	x27, x4, 0
	lw		x31, 0(x27)	# 38
	jalr	x0, x31, 0	# 38
fle.9606:
	fle		f0, f1, fle.9607	# 39
	fsub	f0, f2, f0	# 39
	addi	x27, x4, 0
	lw		x31, 0(x27)	# 39
	jalr	x0, x31, 0	# 39
fle.9607:
	fmul	f0, f0, f0	# 41
	fmul	f1, f0, f0	# 42
	lui		x4, %hi(l.6062)	# 43
	ori		x4, %lo(l.6062)	# 43
	flw		f2, 0(x4)	# 43
	lui		x4, %hi(l.6060)	# 43
	ori		x4, %lo(l.6060)	# 43
	flw		f3, 0(x4)	# 43
	fmul	f3, f3, f0	# 43
	fsub	f2, f2, f3	# 43
	lui		x4, %hi(l.6079)	# 43
	ori		x4, %lo(l.6079)	# 43
	flw		f3, 0(x4)	# 43
	fmul	f3, f3, f1	# 43
	fadd	f2, f2, f3	# 43
	lui		x4, %hi(l.6081)	# 43
	ori		x4, %lo(l.6081)	# 43
	flw		f3, 0(x4)	# 43
	fmul	f0, f3, f0	# 43
	fmul	f0, f0, f1	# 43
	fsub	f10, f2, f0	# 43
	jalr	x0, x1, 0
atan.2474:
	flw		f1, 8(x27)	# 46
	lui		x4, %hi(l.6055)	# 46
	ori		x4, %lo(l.6055)	# 46
	flw		f2, 0(x4)	# 46
	fle		f2, f0, fle.9608	# 46
	sub	f0, f0, f0	# 46
	sub	f0, f0, f0	# 46
	sw		x1, 4(x2)
	addi	x2, x2, 8
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -8
	lw		x1, 4(x2)
	fsub	f0, f0, f0	# 46
	fadd	f0, f0, f10	# 46
	sub	f10, f10, f10	# 46
	sub	f10, f10, f0	# 46
	jalr	x0, x1, 0
fle.9608:
	lui		x4, %hi(l.6062)	# 47
	ori		x4, %lo(l.6062)	# 47
	flw		f2, 0(x4)	# 47
	fle		f0, f2, fle.9609	# 47
	lui		x4, %hi(l.6062)	# 47
	ori		x4, %lo(l.6062)	# 47
	flw		f2, 0(x4)	# 47
	fdiv	f0, f2, f0	# 47
	fsw		f1, 0(x2)	# 47
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	fsub	f0, f0, f0	# 47
	fadd	f0, f0, f10	# 47
	flw		f1, 0(x2)	# 47
	fsub	f10, f1, f0	# 47
	jalr	x0, x1, 0
fle.9609:
	fmul	f1, f0, f0	# 49
	fmul	f2, f0, f1	# 50
	lui		x4, %hi(l.6086)	# 51
	ori		x4, %lo(l.6086)	# 51
	flw		f3, 0(x4)	# 51
	fmul	f3, f3, f2	# 51
	fsub	f0, f0, f3	# 51
	lui		x4, %hi(l.6088)	# 51
	ori		x4, %lo(l.6088)	# 51
	flw		f3, 0(x4)	# 51
	fmul	f3, f3, f1	# 51
	fmul	f3, f3, f2	# 51
	fadd	f0, f0, f3	# 51
	lui		x4, %hi(l.6090)	# 51
	ori		x4, %lo(l.6090)	# 51
	flw		f3, 0(x4)	# 51
	fmul	f3, f3, f1	# 51
	fmul	f1, f3, f1	# 51
	fmul	f1, f1, f2	# 51
	fsub	f10, f0, f1	# 51
	jalr	x0, x1, 0
xor.2506:
	lui		x6, 0	# 185
	ori		x6, x0, 0	# 185
	beq		x4, x6, beq.9610	# 185
	lui		x4, 0	# 185
	ori		x4, x0, 0	# 185
	beq		x5, x4, beq.9611	# 185
	lui		x10, 0	# 185
	ori		x10, x0, 0	# 185
	jalr	x0, x1, 0
beq.9611:
	lui		x10, 1	# 185
	ori		x10, x0, 1	# 185
	jalr	x0, x1, 0
beq.9610:
	addi	x10, x5, 0	# 185
	jalr	x0, x1, 0
sgn.2509:
	fsw		f0, 0(x2)	# 193
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, fiszero.2443
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 193
	lui		x5, 0	# 193
	ori		x5, x0, 0	# 193
	beq		x4, x5, beq.9612	# 193
	lui		x4, %hi(l.6055)	# 193
	ori		x4, %lo(l.6055)	# 193
	flw		f10, 0(x4)	# 193
	jalr	x0, x1, 0
beq.9612:
	flw		f0, 0(x2)	# 194
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, fispos.2445
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 194
	lui		x5, 0	# 194
	ori		x5, x0, 0	# 194
	beq		x4, x5, beq.9613	# 194
	lui		x4, %hi(l.6062)	# 194
	ori		x4, %lo(l.6062)	# 194
	flw		f10, 0(x4)	# 194
	jalr	x0, x1, 0
beq.9613:
	lui		x4, %hi(l.6068)	# 195
	ori		x4, %lo(l.6068)	# 195
	flw		f10, 0(x4)	# 195
	jalr	x0, x1, 0
fneg_cond.2511:
	lui		x5, 0	# 200
	ori		x5, x0, 0	# 200
	beq		x4, x5, beq.9614	# 200
	fsub	f10, f10, f10	# 200
	fadd	f10, f10, f0	# 200
	jalr	x0, x1, 0
beq.9614:
	jal		x0, fneg.2449	# 200
add_mod5.2514:
	add		x4, x4, x5	# 205
	lui		x5, 5	# 206
	ori		x5, x0, 5	# 206
	ble		x5, x4, ble.9615	# 206
	addi	x10, x4, 0	# 206
	jalr	x0, x1, 0
ble.9615:
	lui		x5, 5	# 206
	ori		x5, x0, 5	# 206
	sub		x10, x4, x5	# 206
	jalr	x0, x1, 0
vecset.2517:
	lui		x5, 0	# 221
	ori		x5, x0, 0	# 221
	mul		x5, x5, 8	# 221
	add		x5, x4, x5	# 221
	fsw		f0, 0(x5)	# 221
	lui		x5, 1	# 222
	ori		x5, x0, 1	# 222
	mul		x5, x5, 8	# 222
	add		x5, x4, x5	# 222
	fsw		f1, 0(x5)	# 222
	lui		x5, 2	# 223
	ori		x5, x0, 2	# 223
	mul		x5, x5, 8	# 223
	add		x4, x4, x5	# 223
	fsw		f2, 0(x4)	# 223
	jalr	x0, x1, 0
vecfill.2522:
	lui		x5, 0	# 228
	ori		x5, x0, 0	# 228
	mul		x5, x5, 8	# 228
	add		x5, x4, x5	# 228
	fsw		f0, 0(x5)	# 228
	lui		x5, 1	# 229
	ori		x5, x0, 1	# 229
	mul		x5, x5, 8	# 229
	add		x5, x4, x5	# 229
	fsw		f0, 0(x5)	# 229
	lui		x5, 2	# 230
	ori		x5, x0, 2	# 230
	mul		x5, x5, 8	# 230
	add		x4, x4, x5	# 230
	fsw		f0, 0(x4)	# 230
	jalr	x0, x1, 0
vecbzero.2525:
	lui		x5, %hi(l.6055)	# 235
	ori		x5, %lo(l.6055)	# 235
	flw		f0, 0(x5)	# 235
	jal		x0, vecfill.2522	# 235
veccpy.2527:
	lui		x6, 0	# 240
	ori		x6, x0, 0	# 240
	lui		x7, 0	# 240
	ori		x7, x0, 0	# 240
	mul		x7, x7, 8	# 240
	add		x7, x5, x7	# 240
	flw		f0, 0(x7)	# 240
	mul		x6, x6, 8	# 240
	add		x6, x4, x6	# 240
	fsw		f0, 0(x6)	# 240
	lui		x6, 1	# 241
	ori		x6, x0, 1	# 241
	lui		x7, 1	# 241
	ori		x7, x0, 1	# 241
	mul		x7, x7, 8	# 241
	add		x7, x5, x7	# 241
	flw		f0, 0(x7)	# 241
	mul		x6, x6, 8	# 241
	add		x6, x4, x6	# 241
	fsw		f0, 0(x6)	# 241
	lui		x6, 2	# 242
	ori		x6, x0, 2	# 242
	lui		x7, 2	# 242
	ori		x7, x0, 2	# 242
	mul		x7, x7, 8	# 242
	add		x5, x5, x7	# 242
	flw		f0, 0(x5)	# 242
	mul		x5, x6, 8	# 242
	add		x4, x4, x5	# 242
	fsw		f0, 0(x4)	# 242
	jalr	x0, x1, 0
vecunit_sgn.2530:
	lui		x6, 0	# 264
	ori		x6, x0, 0	# 264
	mul		x6, x6, 8	# 264
	add		x6, x4, x6	# 264
	flw		f0, 0(x6)	# 264
	sw		x5, 0(x2)	# 264
	sw		x4, 4(x2)	# 264
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, fsqr.2458
	addi	x2, x2, -16
	lw		x1, 12(x2)
	fsub	f0, f0, f0	# 264
	fadd	f0, f0, f10	# 264
	lui		x4, 1	# 264
	ori		x4, x0, 1	# 264
	mul		x4, x4, 8	# 264
	lw		x5, 4(x2)	# 264
	add		x4, x5, x4	# 264
	flw		f1, 0(x4)	# 264
	fsw		f0, 8(x2)	# 264
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fsqr.2458
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 264
	fadd	f0, f0, f10	# 264
	flw		f1, 8(x2)	# 264
	fadd	f0, f1, f0	# 264
	lui		x4, 2	# 264
	ori		x4, x0, 2	# 264
	mul		x4, x4, 8	# 264
	lw		x5, 4(x2)	# 264
	add		x4, x5, x4	# 264
	flw		f1, 0(x4)	# 264
	fsw		f0, 16(x2)	# 264
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, fsqr.2458
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 264
	fadd	f0, f0, f10	# 264
	flw		f1, 16(x2)	# 264
	fadd	f0, f1, f0	# 264
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, min_caml_sqrt
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 264
	fadd	f0, f0, f10	# 264
	fsw		f0, 24(x2)	# 265
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fiszero.2443
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 265
	lui		x5, 0	# 265
	ori		x5, x0, 0	# 265
	beq		x4, x5, beq.9619	# 265
	lui		x4, %hi(l.6062)	# 265
	ori		x4, %lo(l.6062)	# 265
	flw		f0, 0(x4)	# 265
	jal		x0, beq_cont.9620	# 265
beq.9619:
	lui		x4, 0	# 265
	ori		x4, x0, 0	# 265
	lw		x5, 0(x2)	# 265
	beq		x5, x4, beq.9621	# 265
	lui		x4, %hi(l.6068)	# 265
	ori		x4, %lo(l.6068)	# 265
	flw		f0, 0(x4)	# 265
	flw		f1, 24(x2)	# 265
	fdiv	f0, f0, f1	# 265
	jal		x0, beq_cont.9622	# 265
beq.9621:
	lui		x4, %hi(l.6062)	# 265
	ori		x4, %lo(l.6062)	# 265
	flw		f0, 0(x4)	# 265
	flw		f1, 24(x2)	# 265
	fdiv	f0, f0, f1	# 265
beq_cont.9622:
beq_cont.9620:
	lui		x4, 0	# 266
	ori		x4, x0, 0	# 266
	lui		x5, 0	# 266
	ori		x5, x0, 0	# 266
	mul		x5, x5, 8	# 266
	lw		x6, 4(x2)	# 266
	add		x5, x6, x5	# 266
	flw		f1, 0(x5)	# 266
	fmul	f1, f1, f0	# 266
	mul		x4, x4, 8	# 266
	add		x4, x6, x4	# 266
	fsw		f1, 0(x4)	# 266
	lui		x4, 1	# 267
	ori		x4, x0, 1	# 267
	lui		x5, 1	# 267
	ori		x5, x0, 1	# 267
	mul		x5, x5, 8	# 267
	add		x5, x6, x5	# 267
	flw		f1, 0(x5)	# 267
	fmul	f1, f1, f0	# 267
	mul		x4, x4, 8	# 267
	add		x4, x6, x4	# 267
	fsw		f1, 0(x4)	# 267
	lui		x4, 2	# 268
	ori		x4, x0, 2	# 268
	lui		x5, 2	# 268
	ori		x5, x0, 2	# 268
	mul		x5, x5, 8	# 268
	add		x5, x6, x5	# 268
	flw		f1, 0(x5)	# 268
	fmul	f0, f1, f0	# 268
	mul		x4, x4, 8	# 268
	add		x4, x6, x4	# 268
	fsw		f0, 0(x4)	# 268
	jalr	x0, x1, 0
veciprod.2533:
	lui		x6, 0	# 273
	ori		x6, x0, 0	# 273
	mul		x6, x6, 8	# 273
	add		x6, x4, x6	# 273
	flw		f0, 0(x6)	# 273
	lui		x6, 0	# 273
	ori		x6, x0, 0	# 273
	mul		x6, x6, 8	# 273
	add		x6, x5, x6	# 273
	flw		f1, 0(x6)	# 273
	fmul	f0, f0, f1	# 273
	lui		x6, 1	# 273
	ori		x6, x0, 1	# 273
	mul		x6, x6, 8	# 273
	add		x6, x4, x6	# 273
	flw		f1, 0(x6)	# 273
	lui		x6, 1	# 273
	ori		x6, x0, 1	# 273
	mul		x6, x6, 8	# 273
	add		x6, x5, x6	# 273
	flw		f2, 0(x6)	# 273
	fmul	f1, f1, f2	# 273
	fadd	f0, f0, f1	# 273
	lui		x6, 2	# 273
	ori		x6, x0, 2	# 273
	mul		x6, x6, 8	# 273
	add		x4, x4, x6	# 273
	flw		f1, 0(x4)	# 273
	lui		x4, 2	# 273
	ori		x4, x0, 2	# 273
	mul		x4, x4, 8	# 273
	add		x4, x5, x4	# 273
	flw		f2, 0(x4)	# 273
	fmul	f1, f1, f2	# 273
	fadd	f10, f0, f1	# 273
	jalr	x0, x1, 0
veciprod2.2536:
	lui		x5, 0	# 278
	ori		x5, x0, 0	# 278
	mul		x5, x5, 8	# 278
	add		x5, x4, x5	# 278
	flw		f3, 0(x5)	# 278
	fmul	f0, f3, f0	# 278
	lui		x5, 1	# 278
	ori		x5, x0, 1	# 278
	mul		x5, x5, 8	# 278
	add		x5, x4, x5	# 278
	flw		f3, 0(x5)	# 278
	fmul	f1, f3, f1	# 278
	fadd	f0, f0, f1	# 278
	lui		x5, 2	# 278
	ori		x5, x0, 2	# 278
	mul		x5, x5, 8	# 278
	add		x4, x4, x5	# 278
	flw		f1, 0(x4)	# 278
	fmul	f1, f1, f2	# 278
	fadd	f10, f0, f1	# 278
	jalr	x0, x1, 0
vecaccum.2541:
	lui		x6, 0	# 283
	ori		x6, x0, 0	# 283
	lui		x7, 0	# 283
	ori		x7, x0, 0	# 283
	mul		x7, x7, 8	# 283
	add		x7, x4, x7	# 283
	flw		f1, 0(x7)	# 283
	lui		x7, 0	# 283
	ori		x7, x0, 0	# 283
	mul		x7, x7, 8	# 283
	add		x7, x5, x7	# 283
	flw		f2, 0(x7)	# 283
	fmul	f2, f0, f2	# 283
	fadd	f1, f1, f2	# 283
	mul		x6, x6, 8	# 283
	add		x6, x4, x6	# 283
	fsw		f1, 0(x6)	# 283
	lui		x6, 1	# 284
	ori		x6, x0, 1	# 284
	lui		x7, 1	# 284
	ori		x7, x0, 1	# 284
	mul		x7, x7, 8	# 284
	add		x7, x4, x7	# 284
	flw		f1, 0(x7)	# 284
	lui		x7, 1	# 284
	ori		x7, x0, 1	# 284
	mul		x7, x7, 8	# 284
	add		x7, x5, x7	# 284
	flw		f2, 0(x7)	# 284
	fmul	f2, f0, f2	# 284
	fadd	f1, f1, f2	# 284
	mul		x6, x6, 8	# 284
	add		x6, x4, x6	# 284
	fsw		f1, 0(x6)	# 284
	lui		x6, 2	# 285
	ori		x6, x0, 2	# 285
	lui		x7, 2	# 285
	ori		x7, x0, 2	# 285
	mul		x7, x7, 8	# 285
	add		x7, x4, x7	# 285
	flw		f1, 0(x7)	# 285
	lui		x7, 2	# 285
	ori		x7, x0, 2	# 285
	mul		x7, x7, 8	# 285
	add		x5, x5, x7	# 285
	flw		f2, 0(x5)	# 285
	fmul	f0, f0, f2	# 285
	fadd	f0, f1, f0	# 285
	mul		x5, x6, 8	# 285
	add		x4, x4, x5	# 285
	fsw		f0, 0(x4)	# 285
	jalr	x0, x1, 0
vecadd.2545:
	lui		x6, 0	# 290
	ori		x6, x0, 0	# 290
	lui		x7, 0	# 290
	ori		x7, x0, 0	# 290
	mul		x7, x7, 8	# 290
	add		x7, x4, x7	# 290
	flw		f0, 0(x7)	# 290
	lui		x7, 0	# 290
	ori		x7, x0, 0	# 290
	mul		x7, x7, 8	# 290
	add		x7, x5, x7	# 290
	flw		f1, 0(x7)	# 290
	fadd	f0, f0, f1	# 290
	mul		x6, x6, 8	# 290
	add		x6, x4, x6	# 290
	fsw		f0, 0(x6)	# 290
	lui		x6, 1	# 291
	ori		x6, x0, 1	# 291
	lui		x7, 1	# 291
	ori		x7, x0, 1	# 291
	mul		x7, x7, 8	# 291
	add		x7, x4, x7	# 291
	flw		f0, 0(x7)	# 291
	lui		x7, 1	# 291
	ori		x7, x0, 1	# 291
	mul		x7, x7, 8	# 291
	add		x7, x5, x7	# 291
	flw		f1, 0(x7)	# 291
	fadd	f0, f0, f1	# 291
	mul		x6, x6, 8	# 291
	add		x6, x4, x6	# 291
	fsw		f0, 0(x6)	# 291
	lui		x6, 2	# 292
	ori		x6, x0, 2	# 292
	lui		x7, 2	# 292
	ori		x7, x0, 2	# 292
	mul		x7, x7, 8	# 292
	add		x7, x4, x7	# 292
	flw		f0, 0(x7)	# 292
	lui		x7, 2	# 292
	ori		x7, x0, 2	# 292
	mul		x7, x7, 8	# 292
	add		x5, x5, x7	# 292
	flw		f1, 0(x5)	# 292
	fadd	f0, f0, f1	# 292
	mul		x5, x6, 8	# 292
	add		x4, x4, x5	# 292
	fsw		f0, 0(x4)	# 292
	jalr	x0, x1, 0
vecscale.2548:
	lui		x5, 0	# 306
	ori		x5, x0, 0	# 306
	lui		x6, 0	# 306
	ori		x6, x0, 0	# 306
	mul		x6, x6, 8	# 306
	add		x6, x4, x6	# 306
	flw		f1, 0(x6)	# 306
	fmul	f1, f1, f0	# 306
	mul		x5, x5, 8	# 306
	add		x5, x4, x5	# 306
	fsw		f1, 0(x5)	# 306
	lui		x5, 1	# 307
	ori		x5, x0, 1	# 307
	lui		x6, 1	# 307
	ori		x6, x0, 1	# 307
	mul		x6, x6, 8	# 307
	add		x6, x4, x6	# 307
	flw		f1, 0(x6)	# 307
	fmul	f1, f1, f0	# 307
	mul		x5, x5, 8	# 307
	add		x5, x4, x5	# 307
	fsw		f1, 0(x5)	# 307
	lui		x5, 2	# 308
	ori		x5, x0, 2	# 308
	lui		x6, 2	# 308
	ori		x6, x0, 2	# 308
	mul		x6, x6, 8	# 308
	add		x6, x4, x6	# 308
	flw		f1, 0(x6)	# 308
	fmul	f0, f1, f0	# 308
	mul		x5, x5, 8	# 308
	add		x4, x4, x5	# 308
	fsw		f0, 0(x4)	# 308
	jalr	x0, x1, 0
vecaccumv.2551:
	lui		x7, 0	# 313
	ori		x7, x0, 0	# 313
	lui		x8, 0	# 313
	ori		x8, x0, 0	# 313
	mul		x8, x8, 8	# 313
	add		x8, x4, x8	# 313
	flw		f0, 0(x8)	# 313
	lui		x8, 0	# 313
	ori		x8, x0, 0	# 313
	mul		x8, x8, 8	# 313
	add		x8, x5, x8	# 313
	flw		f1, 0(x8)	# 313
	lui		x8, 0	# 313
	ori		x8, x0, 0	# 313
	mul		x8, x8, 8	# 313
	add		x8, x6, x8	# 313
	flw		f2, 0(x8)	# 313
	fmul	f1, f1, f2	# 313
	fadd	f0, f0, f1	# 313
	mul		x7, x7, 8	# 313
	add		x7, x4, x7	# 313
	fsw		f0, 0(x7)	# 313
	lui		x7, 1	# 314
	ori		x7, x0, 1	# 314
	lui		x8, 1	# 314
	ori		x8, x0, 1	# 314
	mul		x8, x8, 8	# 314
	add		x8, x4, x8	# 314
	flw		f0, 0(x8)	# 314
	lui		x8, 1	# 314
	ori		x8, x0, 1	# 314
	mul		x8, x8, 8	# 314
	add		x8, x5, x8	# 314
	flw		f1, 0(x8)	# 314
	lui		x8, 1	# 314
	ori		x8, x0, 1	# 314
	mul		x8, x8, 8	# 314
	add		x8, x6, x8	# 314
	flw		f2, 0(x8)	# 314
	fmul	f1, f1, f2	# 314
	fadd	f0, f0, f1	# 314
	mul		x7, x7, 8	# 314
	add		x7, x4, x7	# 314
	fsw		f0, 0(x7)	# 314
	lui		x7, 2	# 315
	ori		x7, x0, 2	# 315
	lui		x8, 2	# 315
	ori		x8, x0, 2	# 315
	mul		x8, x8, 8	# 315
	add		x8, x4, x8	# 315
	flw		f0, 0(x8)	# 315
	lui		x8, 2	# 315
	ori		x8, x0, 2	# 315
	mul		x8, x8, 8	# 315
	add		x5, x5, x8	# 315
	flw		f1, 0(x5)	# 315
	lui		x5, 2	# 315
	ori		x5, x0, 2	# 315
	mul		x5, x5, 8	# 315
	add		x5, x6, x5	# 315
	flw		f2, 0(x5)	# 315
	fmul	f1, f1, f2	# 315
	fadd	f0, f0, f1	# 315
	mul		x5, x7, 8	# 315
	add		x4, x4, x5	# 315
	fsw		f0, 0(x4)	# 315
	jalr	x0, x1, 0
o_texturetype.2555:
	lw		x4, 0(x4)	# 324
	addi	x10, x4, 0	# 329
	jalr	x0, x1, 0
o_form.2557:
	lw		x4, 4(x4)	# 334
	addi	x10, x4, 0	# 339
	jalr	x0, x1, 0
o_reflectiontype.2559:
	lw		x4, 8(x4)	# 344
	addi	x10, x4, 0	# 349
	jalr	x0, x1, 0
o_isinvert.2561:
	lw		x4, 24(x4)	# 354
	addi	x10, x4, 0	# 358
	jalr	x0, x1, 0
o_isrot.2563:
	lw		x4, 12(x4)	# 363
	addi	x10, x4, 0	# 367
	jalr	x0, x1, 0
o_param_a.2565:
	lw		x4, 16(x4)	# 372
	lui		x5, 0	# 377
	ori		x5, x0, 0	# 377
	mul		x5, x5, 8	# 377
	add		x4, x4, x5	# 377
	flw		f10, 0(x4)	# 377
	jalr	x0, x1, 0
o_param_b.2567:
	lw		x4, 16(x4)	# 382
	lui		x5, 1	# 387
	ori		x5, x0, 1	# 387
	mul		x5, x5, 8	# 387
	add		x4, x4, x5	# 387
	flw		f10, 0(x4)	# 387
	jalr	x0, x1, 0
o_param_c.2569:
	lw		x4, 16(x4)	# 392
	lui		x5, 2	# 397
	ori		x5, x0, 2	# 397
	mul		x5, x5, 8	# 397
	add		x4, x4, x5	# 397
	flw		f10, 0(x4)	# 397
	jalr	x0, x1, 0
o_param_abc.2571:
	lw		x4, 16(x4)	# 402
	addi	x10, x4, 0	# 407
	jalr	x0, x1, 0
o_param_x.2573:
	lw		x4, 20(x4)	# 412
	lui		x5, 0	# 417
	ori		x5, x0, 0	# 417
	mul		x5, x5, 8	# 417
	add		x4, x4, x5	# 417
	flw		f10, 0(x4)	# 417
	jalr	x0, x1, 0
o_param_y.2575:
	lw		x4, 20(x4)	# 422
	lui		x5, 1	# 427
	ori		x5, x0, 1	# 427
	mul		x5, x5, 8	# 427
	add		x4, x4, x5	# 427
	flw		f10, 0(x4)	# 427
	jalr	x0, x1, 0
o_param_z.2577:
	lw		x4, 20(x4)	# 432
	lui		x5, 2	# 437
	ori		x5, x0, 2	# 437
	mul		x5, x5, 8	# 437
	add		x4, x4, x5	# 437
	flw		f10, 0(x4)	# 437
	jalr	x0, x1, 0
o_diffuse.2579:
	lw		x4, 28(x4)	# 442
	lui		x5, 0	# 447
	ori		x5, x0, 0	# 447
	mul		x5, x5, 8	# 447
	add		x4, x4, x5	# 447
	flw		f10, 0(x4)	# 447
	jalr	x0, x1, 0
o_hilight.2581:
	lw		x4, 28(x4)	# 452
	lui		x5, 1	# 457
	ori		x5, x0, 1	# 457
	mul		x5, x5, 8	# 457
	add		x4, x4, x5	# 457
	flw		f10, 0(x4)	# 457
	jalr	x0, x1, 0
o_color_red.2583:
	lw		x4, 32(x4)	# 462
	lui		x5, 0	# 467
	ori		x5, x0, 0	# 467
	mul		x5, x5, 8	# 467
	add		x4, x4, x5	# 467
	flw		f10, 0(x4)	# 467
	jalr	x0, x1, 0
o_color_green.2585:
	lw		x4, 32(x4)	# 472
	lui		x5, 1	# 477
	ori		x5, x0, 1	# 477
	mul		x5, x5, 8	# 477
	add		x4, x4, x5	# 477
	flw		f10, 0(x4)	# 477
	jalr	x0, x1, 0
o_color_blue.2587:
	lw		x4, 32(x4)	# 482
	lui		x5, 2	# 487
	ori		x5, x0, 2	# 487
	mul		x5, x5, 8	# 487
	add		x4, x4, x5	# 487
	flw		f10, 0(x4)	# 487
	jalr	x0, x1, 0
o_param_r1.2589:
	lw		x4, 36(x4)	# 492
	lui		x5, 0	# 497
	ori		x5, x0, 0	# 497
	mul		x5, x5, 8	# 497
	add		x4, x4, x5	# 497
	flw		f10, 0(x4)	# 497
	jalr	x0, x1, 0
o_param_r2.2591:
	lw		x4, 36(x4)	# 502
	lui		x5, 1	# 507
	ori		x5, x0, 1	# 507
	mul		x5, x5, 8	# 507
	add		x4, x4, x5	# 507
	flw		f10, 0(x4)	# 507
	jalr	x0, x1, 0
o_param_r3.2593:
	lw		x4, 36(x4)	# 512
	lui		x5, 2	# 517
	ori		x5, x0, 2	# 517
	mul		x5, x5, 8	# 517
	add		x4, x4, x5	# 517
	flw		f10, 0(x4)	# 517
	jalr	x0, x1, 0
o_param_ctbl.2595:
	lw		x4, 40(x4)	# 529
	addi	x10, x4, 0	# 534
	jalr	x0, x1, 0
p_rgb.2597:
	lw		x4, 0(x4)	# 543
	addi	x10, x4, 0	# 545
	jalr	x0, x1, 0
p_intersection_points.2599:
	lw		x4, 4(x4)	# 550
	addi	x10, x4, 0	# 552
	jalr	x0, x1, 0
p_surface_ids.2601:
	lw		x4, 8(x4)	# 558
	addi	x10, x4, 0	# 560
	jalr	x0, x1, 0
p_calc_diffuse.2603:
	lw		x4, 12(x4)	# 565
	addi	x10, x4, 0	# 567
	jalr	x0, x1, 0
p_energy.2605:
	lw		x4, 16(x4)	# 572
	addi	x10, x4, 0	# 574
	jalr	x0, x1, 0
p_received_ray_20percent.2607:
	lw		x4, 20(x4)	# 579
	addi	x10, x4, 0	# 581
	jalr	x0, x1, 0
p_group_id.2609:
	lw		x4, 24(x4)	# 595
	lui		x5, 0	# 597
	ori		x5, x0, 0	# 597
	mul		x5, x5, 4	# 597
	add		x4, x4, x5	# 597
	lw		x10, 0(x4)	# 597
	jalr	x0, x1, 0
p_set_group_id.2611:
	lw		x4, 24(x4)	# 602
	lui		x6, 0	# 604
	ori		x6, x0, 0	# 604
	mul		x6, x6, 4	# 604
	add		x4, x4, x6	# 604
	sw		x5, 0(x4)	# 604
	jalr	x0, x1, 0
p_nvectors.2614:
	lw		x4, 28(x4)	# 609
	addi	x10, x4, 0	# 611
	jalr	x0, x1, 0
d_vec.2616:
	lw		x4, 0(x4)	# 620
	addi	x10, x4, 0	# 621
	jalr	x0, x1, 0
d_const.2618:
	lw		x4, 4(x4)	# 626
	addi	x10, x4, 0	# 627
	jalr	x0, x1, 0
r_surface_id.2620:
	lw		x4, 0(x4)	# 636
	addi	x10, x4, 0	# 637
	jalr	x0, x1, 0
r_dvec.2622:
	lw		x4, 4(x4)	# 642
	addi	x10, x4, 0	# 643
	jalr	x0, x1, 0
r_bright.2624:
	flw		f0, 8(x4)	# 649
	fsub	f10, f10, f10	# 649
	fadd	f10, f10, f0	# 649
	jalr	x0, x1, 0
rad.2626:
	lui		x4, %hi(l.6263)	# 658
	ori		x4, %lo(l.6263)	# 658
	flw		f1, 0(x4)	# 658
	fmul	f10, f0, f1	# 658
	jalr	x0, x1, 0
read_screen_settings.2628:
	lw		x4, 28(x27)	# 665
	lw		x5, 24(x27)	# 665
	lw		x6, 20(x27)	# 665
	lw		x7, 16(x27)	# 665
	lw		x8, 12(x27)	# 665
	lw		x9, 8(x27)	# 665
	lw		x11, 4(x27)	# 665
	lui		x12, 0	# 665
	ori		x12, x0, 0	# 665
	sw		x4, 0(x2)	# 665
	sw		x7, 4(x2)	# 665
	sw		x8, 8(x2)	# 665
	sw		x6, 12(x2)	# 665
	sw		x5, 16(x2)	# 665
	sw		x11, 20(x2)	# 665
	sw		x9, 24(x2)	# 665
	sw		x12, 28(x2)	# 665
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, min_caml_read_float
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 665
	fadd	f0, f0, f10	# 665
	lw		x4, 28(x2)	# 665
	mul		x4, x4, 8	# 665
	lw		x5, 24(x2)	# 665
	add		x4, x5, x4	# 665
	fsw		f0, 0(x4)	# 665
	lui		x4, 1	# 666
	ori		x4, x0, 1	# 666
	sw		x4, 32(x2)	# 666
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, min_caml_read_float
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 666
	fadd	f0, f0, f10	# 666
	lw		x4, 32(x2)	# 666
	mul		x4, x4, 8	# 666
	lw		x5, 24(x2)	# 666
	add		x4, x5, x4	# 666
	fsw		f0, 0(x4)	# 666
	lui		x4, 2	# 667
	ori		x4, x0, 2	# 667
	sw		x4, 36(x2)	# 667
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, min_caml_read_float
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 667
	fadd	f0, f0, f10	# 667
	lw		x4, 36(x2)	# 667
	mul		x4, x4, 8	# 667
	lw		x5, 24(x2)	# 667
	add		x4, x5, x4	# 667
	fsw		f0, 0(x4)	# 667
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, min_caml_read_float
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 669
	fadd	f0, f0, f10	# 669
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, rad.2626
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 669
	fadd	f0, f0, f10	# 669
	lw		x27, 20(x2)	# 670
	fsw		f0, 40(x2)	# 670
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 670
	fadd	f0, f0, f10	# 670
	flw		f1, 40(x2)	# 671
	lw		x27, 16(x2)	# 671
	fsw		f0, 48(x2)	# 671
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 671
	fadd	f0, f0, f10	# 671
	fsw		f0, 56(x2)	# 672
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, min_caml_read_float
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 672
	fadd	f0, f0, f10	# 672
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, rad.2626
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 672
	fadd	f0, f0, f10	# 672
	lw		x27, 20(x2)	# 673
	fsw		f0, 64(x2)	# 673
	sw		x1, 76(x2)
	addi	x2, x2, 80
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 673
	fadd	f0, f0, f10	# 673
	flw		f1, 64(x2)	# 674
	lw		x27, 16(x2)	# 674
	fsw		f0, 72(x2)	# 674
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 84(x2)
	addi	x2, x2, 88
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 674
	fadd	f0, f0, f10	# 674
	lui		x4, 0	# 676
	ori		x4, x0, 0	# 676
	flw		f1, 48(x2)	# 676
	fmul	f2, f1, f0	# 676
	lui		x5, %hi(l.6271)	# 676
	ori		x5, %lo(l.6271)	# 676
	flw		f3, 0(x5)	# 676
	fmul	f2, f2, f3	# 676
	mul		x4, x4, 8	# 676
	lw		x5, 12(x2)	# 676
	add		x4, x5, x4	# 676
	fsw		f2, 0(x4)	# 676
	lui		x4, 1	# 677
	ori		x4, x0, 1	# 677
	lui		x6, %hi(l.6275)	# 677
	ori		x6, %lo(l.6275)	# 677
	flw		f2, 0(x6)	# 677
	flw		f3, 56(x2)	# 677
	fmul	f2, f3, f2	# 677
	mul		x4, x4, 8	# 677
	add		x4, x5, x4	# 677
	fsw		f2, 0(x4)	# 677
	lui		x4, 2	# 678
	ori		x4, x0, 2	# 678
	flw		f2, 72(x2)	# 678
	fmul	f4, f1, f2	# 678
	lui		x6, %hi(l.6271)	# 678
	ori		x6, %lo(l.6271)	# 678
	flw		f5, 0(x6)	# 678
	fmul	f4, f4, f5	# 678
	mul		x4, x4, 8	# 678
	add		x4, x5, x4	# 678
	fsw		f4, 0(x4)	# 678
	lui		x4, 0	# 680
	ori		x4, x0, 0	# 680
	mul		x4, x4, 8	# 680
	lw		x6, 8(x2)	# 680
	add		x4, x6, x4	# 680
	fsw		f2, 0(x4)	# 680
	lui		x4, 1	# 681
	ori		x4, x0, 1	# 681
	lui		x7, %hi(l.6055)	# 681
	ori		x7, %lo(l.6055)	# 681
	flw		f4, 0(x7)	# 681
	mul		x4, x4, 8	# 681
	add		x4, x6, x4	# 681
	fsw		f4, 0(x4)	# 681
	lui		x4, 2	# 682
	ori		x4, x0, 2	# 682
	fsw		f0, 80(x2)	# 682
	sw		x4, 88(x2)	# 682
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, fneg.2449
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 682
	fadd	f0, f0, f10	# 682
	lw		x4, 88(x2)	# 682
	mul		x4, x4, 8	# 682
	lw		x5, 8(x2)	# 682
	add		x4, x5, x4	# 682
	fsw		f0, 0(x4)	# 682
	lui		x4, 0	# 684
	ori		x4, x0, 0	# 684
	flw		f0, 56(x2)	# 684
	sw		x4, 92(x2)	# 684
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, fneg.2449
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f0, f0, f0	# 684
	fadd	f0, f0, f10	# 684
	flw		f1, 80(x2)	# 684
	fmul	f0, f0, f1	# 684
	lw		x4, 92(x2)	# 684
	mul		x4, x4, 8	# 684
	lw		x5, 4(x2)	# 684
	add		x4, x5, x4	# 684
	fsw		f0, 0(x4)	# 684
	lui		x4, 1	# 685
	ori		x4, x0, 1	# 685
	flw		f0, 48(x2)	# 685
	sw		x4, 96(x2)	# 685
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, fneg.2449
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f0, f0, f0	# 685
	fadd	f0, f0, f10	# 685
	lw		x4, 96(x2)	# 685
	mul		x4, x4, 8	# 685
	lw		x5, 4(x2)	# 685
	add		x4, x5, x4	# 685
	fsw		f0, 0(x4)	# 685
	lui		x4, 2	# 686
	ori		x4, x0, 2	# 686
	flw		f0, 56(x2)	# 686
	sw		x4, 100(x2)	# 686
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, fneg.2449
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 686
	fadd	f0, f0, f10	# 686
	flw		f1, 72(x2)	# 686
	fmul	f0, f0, f1	# 686
	lw		x4, 100(x2)	# 686
	mul		x4, x4, 8	# 686
	lw		x5, 4(x2)	# 686
	add		x4, x5, x4	# 686
	fsw		f0, 0(x4)	# 686
	lui		x4, 0	# 688
	ori		x4, x0, 0	# 688
	lui		x5, 0	# 688
	ori		x5, x0, 0	# 688
	mul		x5, x5, 8	# 688
	lw		x6, 24(x2)	# 688
	add		x5, x6, x5	# 688
	flw		f0, 0(x5)	# 688
	lui		x5, 0	# 688
	ori		x5, x0, 0	# 688
	mul		x5, x5, 8	# 688
	lw		x7, 12(x2)	# 688
	add		x5, x7, x5	# 688
	flw		f1, 0(x5)	# 688
	fsub	f0, f0, f1	# 688
	mul		x4, x4, 8	# 688
	lw		x5, 0(x2)	# 688
	add		x4, x5, x4	# 688
	fsw		f0, 0(x4)	# 688
	lui		x4, 1	# 689
	ori		x4, x0, 1	# 689
	lui		x8, 1	# 689
	ori		x8, x0, 1	# 689
	mul		x8, x8, 8	# 689
	add		x8, x6, x8	# 689
	flw		f0, 0(x8)	# 689
	lui		x8, 1	# 689
	ori		x8, x0, 1	# 689
	mul		x8, x8, 8	# 689
	add		x8, x7, x8	# 689
	flw		f1, 0(x8)	# 689
	fsub	f0, f0, f1	# 689
	mul		x4, x4, 8	# 689
	add		x4, x5, x4	# 689
	fsw		f0, 0(x4)	# 689
	lui		x4, 2	# 690
	ori		x4, x0, 2	# 690
	lui		x8, 2	# 690
	ori		x8, x0, 2	# 690
	mul		x8, x8, 8	# 690
	add		x6, x6, x8	# 690
	flw		f0, 0(x6)	# 690
	lui		x6, 2	# 690
	ori		x6, x0, 2	# 690
	mul		x6, x6, 8	# 690
	add		x6, x7, x6	# 690
	flw		f1, 0(x6)	# 690
	fsub	f0, f0, f1	# 690
	mul		x4, x4, 8	# 690
	add		x4, x5, x4	# 690
	fsw		f0, 0(x4)	# 690
	jalr	x0, x1, 0
read_light.2630:
	lw		x4, 16(x27)	# 697
	lw		x5, 12(x27)	# 697
	lw		x6, 8(x27)	# 697
	lw		x7, 4(x27)	# 697
	sw		x7, 0(x2)	# 697
	sw		x6, 4(x2)	# 697
	sw		x5, 8(x2)	# 697
	sw		x4, 12(x2)	# 697
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_read_int
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 697
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_read_float
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 700
	fadd	f0, f0, f10	# 700
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, rad.2626
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 700
	fadd	f0, f0, f10	# 700
	lw		x27, 12(x2)	# 701
	fsw		f0, 16(x2)	# 701
	sw		x1, 28(x2)
	addi	x2, x2, 32
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 701
	fadd	f0, f0, f10	# 701
	lui		x4, 1	# 702
	ori		x4, x0, 1	# 702
	sw		x4, 24(x2)	# 702
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, fneg.2449
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 702
	fadd	f0, f0, f10	# 702
	lw		x4, 24(x2)	# 702
	mul		x4, x4, 8	# 702
	lw		x5, 8(x2)	# 702
	add		x4, x5, x4	# 702
	fsw		f0, 0(x4)	# 702
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, min_caml_read_float
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 703
	fadd	f0, f0, f10	# 703
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, rad.2626
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 703
	fadd	f0, f0, f10	# 703
	flw		f1, 16(x2)	# 704
	lw		x27, 4(x2)	# 704
	fsw		f0, 32(x2)	# 704
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 44(x2)
	addi	x2, x2, 48
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 704
	fadd	f0, f0, f10	# 704
	flw		f1, 32(x2)	# 705
	lw		x27, 12(x2)	# 705
	fsw		f0, 40(x2)	# 705
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 705
	fadd	f0, f0, f10	# 705
	lui		x4, 0	# 706
	ori		x4, x0, 0	# 706
	flw		f1, 40(x2)	# 706
	fmul	f0, f1, f0	# 706
	mul		x4, x4, 8	# 706
	lw		x5, 8(x2)	# 706
	add		x4, x5, x4	# 706
	fsw		f0, 0(x4)	# 706
	flw		f0, 32(x2)	# 707
	lw		x27, 4(x2)	# 707
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 707
	fadd	f0, f0, f10	# 707
	lui		x4, 2	# 708
	ori		x4, x0, 2	# 708
	flw		f1, 40(x2)	# 708
	fmul	f0, f1, f0	# 708
	mul		x4, x4, 8	# 708
	lw		x5, 8(x2)	# 708
	add		x4, x5, x4	# 708
	fsw		f0, 0(x4)	# 708
	lui		x4, 0	# 709
	ori		x4, x0, 0	# 709
	sw		x4, 48(x2)	# 709
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, min_caml_read_float
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 709
	fadd	f0, f0, f10	# 709
	lw		x4, 48(x2)	# 709
	mul		x4, x4, 8	# 709
	lw		x5, 0(x2)	# 709
	add		x4, x5, x4	# 709
	fsw		f0, 0(x4)	# 709
	jalr	x0, x1, 0
rotate_quadratic_matrix.2632:
	lw		x6, 8(x27)	# 719
	lw		x27, 4(x27)	# 719
	lui		x7, 0	# 719
	ori		x7, x0, 0	# 719
	mul		x7, x7, 8	# 719
	add		x7, x5, x7	# 719
	flw		f0, 0(x7)	# 719
	sw		x4, 0(x2)	# 719
	sw		x27, 4(x2)	# 719
	sw		x6, 8(x2)	# 719
	sw		x5, 12(x2)	# 719
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 719
	fadd	f0, f0, f10	# 719
	lui		x4, 0	# 720
	ori		x4, x0, 0	# 720
	mul		x4, x4, 8	# 720
	lw		x5, 12(x2)	# 720
	add		x4, x5, x4	# 720
	flw		f1, 0(x4)	# 720
	lw		x27, 8(x2)	# 720
	fsw		f0, 16(x2)	# 720
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 28(x2)
	addi	x2, x2, 32
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 720
	fadd	f0, f0, f10	# 720
	lui		x4, 1	# 721
	ori		x4, x0, 1	# 721
	mul		x4, x4, 8	# 721
	lw		x5, 12(x2)	# 721
	add		x4, x5, x4	# 721
	flw		f1, 0(x4)	# 721
	lw		x27, 4(x2)	# 721
	fsw		f0, 24(x2)	# 721
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 721
	fadd	f0, f0, f10	# 721
	lui		x4, 1	# 722
	ori		x4, x0, 1	# 722
	mul		x4, x4, 8	# 722
	lw		x5, 12(x2)	# 722
	add		x4, x5, x4	# 722
	flw		f1, 0(x4)	# 722
	lw		x27, 8(x2)	# 722
	fsw		f0, 32(x2)	# 722
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 44(x2)
	addi	x2, x2, 48
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 722
	fadd	f0, f0, f10	# 722
	lui		x4, 2	# 723
	ori		x4, x0, 2	# 723
	mul		x4, x4, 8	# 723
	lw		x5, 12(x2)	# 723
	add		x4, x5, x4	# 723
	flw		f1, 0(x4)	# 723
	lw		x27, 4(x2)	# 723
	fsw		f0, 40(x2)	# 723
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 723
	fadd	f0, f0, f10	# 723
	lui		x4, 2	# 724
	ori		x4, x0, 2	# 724
	mul		x4, x4, 8	# 724
	lw		x5, 12(x2)	# 724
	add		x4, x5, x4	# 724
	flw		f1, 0(x4)	# 724
	lw		x27, 8(x2)	# 724
	fsw		f0, 48(x2)	# 724
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 724
	fadd	f0, f0, f10	# 724
	flw		f1, 48(x2)	# 726
	flw		f2, 32(x2)	# 726
	fmul	f3, f2, f1	# 726
	flw		f4, 40(x2)	# 727
	flw		f5, 24(x2)	# 727
	fmul	f6, f5, f4	# 727
	fmul	f6, f6, f1	# 727
	flw		f7, 16(x2)	# 727
	fmul	f8, f7, f0	# 727
	fsub	f6, f6, f8	# 727
	fmul	f8, f7, f4	# 728
	fmul	f8, f8, f1	# 728
	fmul	f9, f5, f0	# 728
	fadd	f8, f8, f9	# 728
	fmul	f9, f2, f0	# 730
	fmul	f11, f5, f4	# 731
	fmul	f11, f11, f0	# 731
	fmul	f12, f7, f1	# 731
	fadd	f11, f11, f12	# 731
	fmul	f12, f7, f4	# 732
	fmul	f0, f12, f0	# 732
	fmul	f1, f5, f1	# 732
	fsub	f0, f0, f1	# 732
	fsw		f0, 56(x2)	# 734
	fsw		f8, 64(x2)	# 734
	fsw		f11, 72(x2)	# 734
	fsw		f6, 80(x2)	# 734
	fsw		f9, 88(x2)	# 734
	fsw		f3, 96(x2)	# 734
	fsub	f0, f0, f0
	fadd	f0, f0, f4
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, fneg.2449
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 734
	fadd	f0, f0, f10	# 734
	flw		f1, 32(x2)	# 735
	flw		f2, 24(x2)	# 735
	fmul	f2, f2, f1	# 735
	flw		f3, 16(x2)	# 736
	fmul	f1, f3, f1	# 736
	lui		x4, 0	# 739
	ori		x4, x0, 0	# 739
	mul		x4, x4, 8	# 739
	lw		x5, 0(x2)	# 739
	add		x4, x5, x4	# 739
	flw		f3, 0(x4)	# 739
	lui		x4, 1	# 740
	ori		x4, x0, 1	# 740
	mul		x4, x4, 8	# 740
	add		x4, x5, x4	# 740
	flw		f4, 0(x4)	# 740
	lui		x4, 2	# 741
	ori		x4, x0, 2	# 741
	mul		x4, x4, 8	# 741
	add		x4, x5, x4	# 741
	flw		f5, 0(x4)	# 741
	lui		x4, 0	# 746
	ori		x4, x0, 0	# 746
	flw		f6, 96(x2)	# 746
	fsw		f1, 104(x2)	# 746
	fsw		f2, 112(x2)	# 746
	sw		x4, 120(x2)	# 746
	fsw		f5, 128(x2)	# 746
	fsw		f0, 136(x2)	# 746
	fsw		f4, 144(x2)	# 746
	fsw		f3, 152(x2)	# 746
	fsub	f0, f0, f0
	fadd	f0, f0, f6
	sw		x1, 164(x2)
	addi	x2, x2, 168
	jal		x1, fsqr.2458
	addi	x2, x2, -168
	lw		x1, 164(x2)
	fsub	f0, f0, f0	# 746
	fadd	f0, f0, f10	# 746
	flw		f1, 152(x2)	# 746
	fmul	f0, f1, f0	# 746
	flw		f2, 88(x2)	# 746
	fsw		f0, 160(x2)	# 746
	fsub	f0, f0, f0
	fadd	f0, f0, f2
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, fsqr.2458
	addi	x2, x2, -176
	lw		x1, 172(x2)
	fsub	f0, f0, f0	# 746
	fadd	f0, f0, f10	# 746
	flw		f1, 144(x2)	# 746
	fmul	f0, f1, f0	# 746
	flw		f2, 160(x2)	# 746
	fadd	f0, f2, f0	# 746
	flw		f2, 136(x2)	# 746
	fsw		f0, 168(x2)	# 746
	fsub	f0, f0, f0
	fadd	f0, f0, f2
	sw		x1, 180(x2)
	addi	x2, x2, 184
	jal		x1, fsqr.2458
	addi	x2, x2, -184
	lw		x1, 180(x2)
	fsub	f0, f0, f0	# 746
	fadd	f0, f0, f10	# 746
	flw		f1, 128(x2)	# 746
	fmul	f0, f1, f0	# 746
	flw		f2, 168(x2)	# 746
	fadd	f0, f2, f0	# 746
	lw		x4, 120(x2)	# 746
	mul		x4, x4, 8	# 746
	lw		x5, 0(x2)	# 746
	add		x4, x5, x4	# 746
	fsw		f0, 0(x4)	# 746
	lui		x4, 1	# 747
	ori		x4, x0, 1	# 747
	flw		f0, 80(x2)	# 747
	sw		x4, 176(x2)	# 747
	sw		x1, 180(x2)
	addi	x2, x2, 184
	jal		x1, fsqr.2458
	addi	x2, x2, -184
	lw		x1, 180(x2)
	fsub	f0, f0, f0	# 747
	fadd	f0, f0, f10	# 747
	flw		f1, 152(x2)	# 747
	fmul	f0, f1, f0	# 747
	flw		f2, 72(x2)	# 747
	fsw		f0, 184(x2)	# 747
	fsub	f0, f0, f0
	fadd	f0, f0, f2
	sw		x1, 196(x2)
	addi	x2, x2, 200
	jal		x1, fsqr.2458
	addi	x2, x2, -200
	lw		x1, 196(x2)
	fsub	f0, f0, f0	# 747
	fadd	f0, f0, f10	# 747
	flw		f1, 144(x2)	# 747
	fmul	f0, f1, f0	# 747
	flw		f2, 184(x2)	# 747
	fadd	f0, f2, f0	# 747
	flw		f2, 112(x2)	# 747
	fsw		f0, 192(x2)	# 747
	fsub	f0, f0, f0
	fadd	f0, f0, f2
	sw		x1, 204(x2)
	addi	x2, x2, 208
	jal		x1, fsqr.2458
	addi	x2, x2, -208
	lw		x1, 204(x2)
	fsub	f0, f0, f0	# 747
	fadd	f0, f0, f10	# 747
	flw		f1, 128(x2)	# 747
	fmul	f0, f1, f0	# 747
	flw		f2, 192(x2)	# 747
	fadd	f0, f2, f0	# 747
	lw		x4, 176(x2)	# 747
	mul		x4, x4, 8	# 747
	lw		x5, 0(x2)	# 747
	add		x4, x5, x4	# 747
	fsw		f0, 0(x4)	# 747
	lui		x4, 2	# 748
	ori		x4, x0, 2	# 748
	flw		f0, 64(x2)	# 748
	sw		x4, 200(x2)	# 748
	sw		x1, 204(x2)
	addi	x2, x2, 208
	jal		x1, fsqr.2458
	addi	x2, x2, -208
	lw		x1, 204(x2)
	fsub	f0, f0, f0	# 748
	fadd	f0, f0, f10	# 748
	flw		f1, 152(x2)	# 748
	fmul	f0, f1, f0	# 748
	flw		f2, 56(x2)	# 748
	fsw		f0, 208(x2)	# 748
	fsub	f0, f0, f0
	fadd	f0, f0, f2
	sw		x1, 220(x2)
	addi	x2, x2, 224
	jal		x1, fsqr.2458
	addi	x2, x2, -224
	lw		x1, 220(x2)
	fsub	f0, f0, f0	# 748
	fadd	f0, f0, f10	# 748
	flw		f1, 144(x2)	# 748
	fmul	f0, f1, f0	# 748
	flw		f2, 208(x2)	# 748
	fadd	f0, f2, f0	# 748
	flw		f2, 104(x2)	# 748
	fsw		f0, 216(x2)	# 748
	fsub	f0, f0, f0
	fadd	f0, f0, f2
	sw		x1, 228(x2)
	addi	x2, x2, 232
	jal		x1, fsqr.2458
	addi	x2, x2, -232
	lw		x1, 228(x2)
	fsub	f0, f0, f0	# 748
	fadd	f0, f0, f10	# 748
	flw		f1, 128(x2)	# 748
	fmul	f0, f1, f0	# 748
	flw		f2, 216(x2)	# 748
	fadd	f0, f2, f0	# 748
	lw		x4, 200(x2)	# 748
	mul		x4, x4, 8	# 748
	lw		x5, 0(x2)	# 748
	add		x4, x5, x4	# 748
	fsw		f0, 0(x4)	# 748
	lui		x4, 0	# 751
	ori		x4, x0, 0	# 751
	lui		x5, %hi(l.6345)	# 751
	ori		x5, %lo(l.6345)	# 751
	flw		f0, 0(x5)	# 751
	flw		f2, 80(x2)	# 751
	flw		f3, 152(x2)	# 751
	fmul	f4, f3, f2	# 751
	flw		f5, 64(x2)	# 751
	fmul	f4, f4, f5	# 751
	flw		f6, 72(x2)	# 751
	flw		f7, 144(x2)	# 751
	fmul	f8, f7, f6	# 751
	flw		f9, 56(x2)	# 751
	fmul	f8, f8, f9	# 751
	fadd	f4, f4, f8	# 751
	flw		f8, 112(x2)	# 751
	fmul	f11, f1, f8	# 751
	flw		f12, 104(x2)	# 751
	fmul	f11, f11, f12	# 751
	fadd	f4, f4, f11	# 751
	fmul	f0, f0, f4	# 751
	mul		x4, x4, 8	# 751
	lw		x5, 12(x2)	# 751
	add		x4, x5, x4	# 751
	fsw		f0, 0(x4)	# 751
	lui		x4, 1	# 752
	ori		x4, x0, 1	# 752
	lui		x6, %hi(l.6345)	# 752
	ori		x6, %lo(l.6345)	# 752
	flw		f0, 0(x6)	# 752
	flw		f4, 96(x2)	# 752
	fmul	f11, f3, f4	# 752
	fmul	f5, f11, f5	# 752
	flw		f11, 88(x2)	# 752
	fmul	f13, f7, f11	# 752
	fmul	f9, f13, f9	# 752
	fadd	f5, f5, f9	# 752
	flw		f9, 136(x2)	# 752
	fmul	f13, f1, f9	# 752
	fmul	f12, f13, f12	# 752
	fadd	f5, f5, f12	# 752
	fmul	f0, f0, f5	# 752
	mul		x4, x4, 8	# 752
	add		x4, x5, x4	# 752
	fsw		f0, 0(x4)	# 752
	lui		x4, 2	# 753
	ori		x4, x0, 2	# 753
	lui		x6, %hi(l.6345)	# 753
	ori		x6, %lo(l.6345)	# 753
	flw		f0, 0(x6)	# 753
	fmul	f3, f3, f4	# 753
	fmul	f2, f3, f2	# 753
	fmul	f3, f7, f11	# 753
	fmul	f3, f3, f6	# 753
	fadd	f2, f2, f3	# 753
	fmul	f1, f1, f9	# 753
	fmul	f1, f1, f8	# 753
	fadd	f1, f2, f1	# 753
	fmul	f0, f0, f1	# 753
	mul		x4, x4, 8	# 753
	add		x4, x5, x4	# 753
	fsw		f0, 0(x4)	# 753
	jalr	x0, x1, 0
read_nth_object.2635:
	lw		x5, 8(x27)	# 760
	lw		x6, 4(x27)	# 760
	sw		x5, 0(x2)	# 760
	sw		x6, 4(x2)	# 760
	sw		x4, 8(x2)	# 760
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_read_int
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 760
	lui		x5, -1	# 761
	ori		x5, x0, -1	# 761
	beq		x4, x5, beq.9636	# 761
	sw		x4, 12(x2)	# 763
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_read_int
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 763
	sw		x4, 16(x2)	# 764
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_read_int
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 764
	sw		x4, 20(x2)	# 765
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, min_caml_read_int
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 765
	lui		x5, 3	# 767
	ori		x5, x0, 3	# 767
	lui		x6, %hi(l.6055)	# 767
	ori		x6, %lo(l.6055)	# 767
	flw		f0, 0(x6)	# 767
	sw		x4, 24(x2)	# 767
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 767
	lui		x5, 0	# 768
	ori		x5, x0, 0	# 768
	sw		x4, 28(x2)	# 768
	sw		x5, 32(x2)	# 768
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, min_caml_read_float
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 768
	fadd	f0, f0, f10	# 768
	lw		x4, 32(x2)	# 768
	mul		x4, x4, 8	# 768
	lw		x5, 28(x2)	# 768
	add		x4, x5, x4	# 768
	fsw		f0, 0(x4)	# 768
	lui		x4, 1	# 769
	ori		x4, x0, 1	# 769
	sw		x4, 36(x2)	# 769
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, min_caml_read_float
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 769
	fadd	f0, f0, f10	# 769
	lw		x4, 36(x2)	# 769
	mul		x4, x4, 8	# 769
	lw		x5, 28(x2)	# 769
	add		x4, x5, x4	# 769
	fsw		f0, 0(x4)	# 769
	lui		x4, 2	# 770
	ori		x4, x0, 2	# 770
	sw		x4, 40(x2)	# 770
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, min_caml_read_float
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 770
	fadd	f0, f0, f10	# 770
	lw		x4, 40(x2)	# 770
	mul		x4, x4, 8	# 770
	lw		x5, 28(x2)	# 770
	add		x4, x5, x4	# 770
	fsw		f0, 0(x4)	# 770
	lui		x4, 3	# 772
	ori		x4, x0, 3	# 772
	lui		x6, %hi(l.6055)	# 772
	ori		x6, %lo(l.6055)	# 772
	flw		f0, 0(x6)	# 772
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 772
	lui		x5, 0	# 773
	ori		x5, x0, 0	# 773
	sw		x4, 44(x2)	# 773
	sw		x5, 48(x2)	# 773
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, min_caml_read_float
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 773
	fadd	f0, f0, f10	# 773
	lw		x4, 48(x2)	# 773
	mul		x4, x4, 8	# 773
	lw		x5, 44(x2)	# 773
	add		x4, x5, x4	# 773
	fsw		f0, 0(x4)	# 773
	lui		x4, 1	# 774
	ori		x4, x0, 1	# 774
	sw		x4, 52(x2)	# 774
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, min_caml_read_float
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 774
	fadd	f0, f0, f10	# 774
	lw		x4, 52(x2)	# 774
	mul		x4, x4, 8	# 774
	lw		x5, 44(x2)	# 774
	add		x4, x5, x4	# 774
	fsw		f0, 0(x4)	# 774
	lui		x4, 2	# 775
	ori		x4, x0, 2	# 775
	sw		x4, 56(x2)	# 775
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, min_caml_read_float
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 775
	fadd	f0, f0, f10	# 775
	lw		x4, 56(x2)	# 775
	mul		x4, x4, 8	# 775
	lw		x5, 44(x2)	# 775
	add		x4, x5, x4	# 775
	fsw		f0, 0(x4)	# 775
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, min_caml_read_float
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 777
	fadd	f0, f0, f10	# 777
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, fisneg.2447
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 777
	lui		x5, 2	# 779
	ori		x5, x0, 2	# 779
	lui		x6, %hi(l.6055)	# 779
	ori		x6, %lo(l.6055)	# 779
	flw		f0, 0(x6)	# 779
	sw		x4, 60(x2)	# 779
	addi	x4, x5, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 779
	lui		x5, 0	# 780
	ori		x5, x0, 0	# 780
	sw		x4, 64(x2)	# 780
	sw		x5, 68(x2)	# 780
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, min_caml_read_float
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 780
	fadd	f0, f0, f10	# 780
	lw		x4, 68(x2)	# 780
	mul		x4, x4, 8	# 780
	lw		x5, 64(x2)	# 780
	add		x4, x5, x4	# 780
	fsw		f0, 0(x4)	# 780
	lui		x4, 1	# 781
	ori		x4, x0, 1	# 781
	sw		x4, 72(x2)	# 781
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, min_caml_read_float
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 781
	fadd	f0, f0, f10	# 781
	lw		x4, 72(x2)	# 781
	mul		x4, x4, 8	# 781
	lw		x5, 64(x2)	# 781
	add		x4, x5, x4	# 781
	fsw		f0, 0(x4)	# 781
	lui		x4, 3	# 783
	ori		x4, x0, 3	# 783
	lui		x6, %hi(l.6055)	# 783
	ori		x6, %lo(l.6055)	# 783
	flw		f0, 0(x6)	# 783
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 783
	lui		x5, 0	# 784
	ori		x5, x0, 0	# 784
	sw		x4, 76(x2)	# 784
	sw		x5, 80(x2)	# 784
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, min_caml_read_float
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 784
	fadd	f0, f0, f10	# 784
	lw		x4, 80(x2)	# 784
	mul		x4, x4, 8	# 784
	lw		x5, 76(x2)	# 784
	add		x4, x5, x4	# 784
	fsw		f0, 0(x4)	# 784
	lui		x4, 1	# 785
	ori		x4, x0, 1	# 785
	sw		x4, 84(x2)	# 785
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, min_caml_read_float
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 785
	fadd	f0, f0, f10	# 785
	lw		x4, 84(x2)	# 785
	mul		x4, x4, 8	# 785
	lw		x5, 76(x2)	# 785
	add		x4, x5, x4	# 785
	fsw		f0, 0(x4)	# 785
	lui		x4, 2	# 786
	ori		x4, x0, 2	# 786
	sw		x4, 88(x2)	# 786
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, min_caml_read_float
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 786
	fadd	f0, f0, f10	# 786
	lw		x4, 88(x2)	# 786
	mul		x4, x4, 8	# 786
	lw		x5, 76(x2)	# 786
	add		x4, x5, x4	# 786
	fsw		f0, 0(x4)	# 786
	lui		x4, 3	# 788
	ori		x4, x0, 3	# 788
	lui		x6, %hi(l.6055)	# 788
	ori		x6, %lo(l.6055)	# 788
	flw		f0, 0(x6)	# 788
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 788
	lui		x5, 0	# 789
	ori		x5, x0, 0	# 789
	lw		x6, 24(x2)	# 789
	sw		x4, 92(x2)	# 789
	beq		x6, x5, beq.9637	# 789
	lui		x5, 0	# 791
	ori		x5, x0, 0	# 791
	sw		x5, 96(x2)	# 791
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, min_caml_read_float
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f0, f0, f0	# 791
	fadd	f0, f0, f10	# 791
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, rad.2626
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f0, f0, f0	# 791
	fadd	f0, f0, f10	# 791
	lw		x4, 96(x2)	# 791
	mul		x4, x4, 8	# 791
	lw		x5, 92(x2)	# 791
	add		x4, x5, x4	# 791
	fsw		f0, 0(x4)	# 791
	lui		x4, 1	# 792
	ori		x4, x0, 1	# 792
	sw		x4, 100(x2)	# 792
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, min_caml_read_float
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 792
	fadd	f0, f0, f10	# 792
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, rad.2626
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 792
	fadd	f0, f0, f10	# 792
	lw		x4, 100(x2)	# 792
	mul		x4, x4, 8	# 792
	lw		x5, 92(x2)	# 792
	add		x4, x5, x4	# 792
	fsw		f0, 0(x4)	# 792
	lui		x4, 2	# 793
	ori		x4, x0, 2	# 793
	sw		x4, 104(x2)	# 793
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, min_caml_read_float
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 793
	fadd	f0, f0, f10	# 793
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, rad.2626
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 793
	fadd	f0, f0, f10	# 793
	lw		x4, 104(x2)	# 793
	mul		x4, x4, 8	# 793
	lw		x5, 92(x2)	# 793
	add		x4, x5, x4	# 793
	fsw		f0, 0(x4)	# 793
	jal		x0, beq_cont.9638	# 789
beq.9637:
beq_cont.9638:
	lui		x4, 2	# 800
	ori		x4, x0, 2	# 800
	lw		x5, 16(x2)	# 800
	beq		x5, x4, beq.9639	# 800
	lw		x4, 60(x2)	# 800
	jal		x0, beq_cont.9640	# 800
beq.9639:
	lui		x4, 1	# 800
	ori		x4, x0, 1	# 800
beq_cont.9640:
	lui		x6, 4	# 801
	ori		x6, x0, 4	# 801
	lui		x7, %hi(l.6055)	# 801
	ori		x7, %lo(l.6055)	# 801
	flw		f0, 0(x7)	# 801
	sw		x4, 108(x2)	# 801
	addi	x4, x6, 0
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -120
	lw		x1, 116(x2)
	addi	x4, x10, 0	# 801
	addi	x5, x3, 0	# 804
	addi	x3, x3, 48	# 804
	sw		x4, 40(x5)	# 804
	lw		x4, 92(x2)	# 804
	sw		x4, 36(x5)	# 804
	lw		x6, 76(x2)	# 804
	sw		x6, 32(x5)	# 804
	lw		x6, 64(x2)	# 804
	sw		x6, 28(x5)	# 804
	lw		x6, 108(x2)	# 804
	sw		x6, 24(x5)	# 804
	lw		x6, 44(x2)	# 804
	sw		x6, 20(x5)	# 804
	lw		x6, 28(x2)	# 804
	sw		x6, 16(x5)	# 804
	lw		x7, 24(x2)	# 804
	sw		x7, 12(x5)	# 804
	lw		x8, 20(x2)	# 804
	sw		x8, 8(x5)	# 804
	lw		x8, 16(x2)	# 804
	sw		x8, 4(x5)	# 804
	lw		x9, 12(x2)	# 804
	sw		x9, 0(x5)	# 804
	lw		x9, 8(x2)	# 812
	mul		x9, x9, 4	# 812
	lw		x11, 4(x2)	# 812
	add		x9, x11, x9	# 812
	sw		x5, 0(x9)	# 812
	lui		x5, 3	# 814
	ori		x5, x0, 3	# 814
	beq		x8, x5, beq.9641	# 814
	lui		x5, 2	# 824
	ori		x5, x0, 2	# 824
	beq		x8, x5, beq.9643	# 824
	jal		x0, beq_cont.9644	# 824
beq.9643:
	lui		x5, 0	# 826
	ori		x5, x0, 0	# 826
	lw		x8, 60(x2)	# 826
	beq		x8, x5, beq.9645	# 826
	lui		x5, 0	# 826
	ori		x5, x0, 0	# 826
	jal		x0, beq_cont.9646	# 826
beq.9645:
	lui		x5, 1	# 826
	ori		x5, x0, 1	# 826
beq_cont.9646:
	addi	x4, x6, 0
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, vecunit_sgn.2530
	addi	x2, x2, -120
	lw		x1, 116(x2)
beq_cont.9644:
	jal		x0, beq_cont.9642	# 814
beq.9641:
	lui		x5, 0	# 817
	ori		x5, x0, 0	# 817
	mul		x5, x5, 8	# 817
	add		x5, x6, x5	# 817
	flw		f0, 0(x5)	# 817
	lui		x5, 0	# 818
	ori		x5, x0, 0	# 818
	sw		x5, 112(x2)	# 818
	fsw		f0, 120(x2)	# 818
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, fiszero.2443
	addi	x2, x2, -136
	lw		x1, 132(x2)
	addi	x4, x10, 0	# 818
	lui		x5, 0	# 818
	ori		x5, x0, 0	# 818
	beq		x4, x5, beq.9648	# 818
	lui		x4, %hi(l.6055)	# 818
	ori		x4, %lo(l.6055)	# 818
	flw		f0, 0(x4)	# 818
	jal		x0, beq_cont.9649	# 818
beq.9648:
	flw		f0, 120(x2)	# 818
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, sgn.2509
	addi	x2, x2, -136
	lw		x1, 132(x2)
	fsub	f0, f0, f0	# 818
	fadd	f0, f0, f10	# 818
	flw		f1, 120(x2)	# 818
	fsw		f0, 128(x2)	# 818
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, fsqr.2458
	addi	x2, x2, -144
	lw		x1, 140(x2)
	fsub	f0, f0, f0	# 818
	fadd	f0, f0, f10	# 818
	flw		f1, 128(x2)	# 818
	fdiv	f0, f1, f0	# 818
beq_cont.9649:
	lw		x4, 112(x2)	# 818
	mul		x4, x4, 8	# 818
	lw		x5, 28(x2)	# 818
	add		x4, x5, x4	# 818
	fsw		f0, 0(x4)	# 818
	lui		x4, 1	# 819
	ori		x4, x0, 1	# 819
	mul		x4, x4, 8	# 819
	add		x4, x5, x4	# 819
	flw		f0, 0(x4)	# 819
	lui		x4, 1	# 820
	ori		x4, x0, 1	# 820
	sw		x4, 136(x2)	# 820
	fsw		f0, 144(x2)	# 820
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, fiszero.2443
	addi	x2, x2, -160
	lw		x1, 156(x2)
	addi	x4, x10, 0	# 820
	lui		x5, 0	# 820
	ori		x5, x0, 0	# 820
	beq		x4, x5, beq.9651	# 820
	lui		x4, %hi(l.6055)	# 820
	ori		x4, %lo(l.6055)	# 820
	flw		f0, 0(x4)	# 820
	jal		x0, beq_cont.9652	# 820
beq.9651:
	flw		f0, 144(x2)	# 820
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, sgn.2509
	addi	x2, x2, -160
	lw		x1, 156(x2)
	fsub	f0, f0, f0	# 820
	fadd	f0, f0, f10	# 820
	flw		f1, 144(x2)	# 820
	fsw		f0, 152(x2)	# 820
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 164(x2)
	addi	x2, x2, 168
	jal		x1, fsqr.2458
	addi	x2, x2, -168
	lw		x1, 164(x2)
	fsub	f0, f0, f0	# 820
	fadd	f0, f0, f10	# 820
	flw		f1, 152(x2)	# 820
	fdiv	f0, f1, f0	# 820
beq_cont.9652:
	lw		x4, 136(x2)	# 820
	mul		x4, x4, 8	# 820
	lw		x5, 28(x2)	# 820
	add		x4, x5, x4	# 820
	fsw		f0, 0(x4)	# 820
	lui		x4, 2	# 821
	ori		x4, x0, 2	# 821
	mul		x4, x4, 8	# 821
	add		x4, x5, x4	# 821
	flw		f0, 0(x4)	# 821
	lui		x4, 2	# 822
	ori		x4, x0, 2	# 822
	sw		x4, 160(x2)	# 822
	fsw		f0, 168(x2)	# 822
	sw		x1, 180(x2)
	addi	x2, x2, 184
	jal		x1, fiszero.2443
	addi	x2, x2, -184
	lw		x1, 180(x2)
	addi	x4, x10, 0	# 822
	lui		x5, 0	# 822
	ori		x5, x0, 0	# 822
	beq		x4, x5, beq.9654	# 822
	lui		x4, %hi(l.6055)	# 822
	ori		x4, %lo(l.6055)	# 822
	flw		f0, 0(x4)	# 822
	jal		x0, beq_cont.9655	# 822
beq.9654:
	flw		f0, 168(x2)	# 822
	sw		x1, 180(x2)
	addi	x2, x2, 184
	jal		x1, sgn.2509
	addi	x2, x2, -184
	lw		x1, 180(x2)
	fsub	f0, f0, f0	# 822
	fadd	f0, f0, f10	# 822
	flw		f1, 168(x2)	# 822
	fsw		f0, 176(x2)	# 822
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 188(x2)
	addi	x2, x2, 192
	jal		x1, fsqr.2458
	addi	x2, x2, -192
	lw		x1, 188(x2)
	fsub	f0, f0, f0	# 822
	fadd	f0, f0, f10	# 822
	flw		f1, 176(x2)	# 822
	fdiv	f0, f1, f0	# 822
beq_cont.9655:
	lw		x4, 160(x2)	# 822
	mul		x4, x4, 8	# 822
	lw		x5, 28(x2)	# 822
	add		x4, x5, x4	# 822
	fsw		f0, 0(x4)	# 822
beq_cont.9642:
	lui		x4, 0	# 830
	ori		x4, x0, 0	# 830
	lw		x5, 24(x2)	# 830
	beq		x5, x4, beq.9656	# 830
	lw		x4, 28(x2)	# 831
	lw		x5, 92(x2)	# 831
	lw		x27, 0(x2)	# 831
	sw		x1, 188(x2)
	addi	x2, x2, 192
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -192
	lw		x1, 188(x2)
	jal		x0, beq_cont.9657	# 830
beq.9656:
beq_cont.9657:
	lui		x10, 1	# 834
	ori		x10, x0, 1	# 834
	jalr	x0, x1, 0
beq.9636:
	lui		x10, 0	# 837
	ori		x10, x0, 0	# 837
	jalr	x0, x1, 0
read_object.2637:
	lw		x5, 8(x27)	# 842
	lw		x6, 4(x27)	# 842
	lui		x7, 60	# 842
	ori		x7, x0, 60	# 842
	ble		x7, x4, ble.9658	# 842
	sw		x27, 0(x2)	# 843
	sw		x4, 4(x2)	# 843
	sw		x6, 8(x2)	# 843
	addi	x27, x5, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 843
	lui		x5, 0	# 843
	ori		x5, x0, 0	# 843
	beq		x4, x5, beq.9659	# 843
	lw		x4, 4(x2)	# 844
	addi	x4, x4, 1	# 844
	lw		x27, 0(x2)	# 844
	lw		x31, 0(x27)	# 844
	jalr	x0, x31, 0	# 844
beq.9659:
	lui		x4, 0	# 846
	ori		x4, x0, 0	# 846
	mul		x4, x4, 4	# 846
	lw		x5, 8(x2)	# 846
	add		x4, x5, x4	# 846
	lw		x5, 4(x2)	# 846
	sw		x5, 0(x4)	# 846
	jalr	x0, x1, 0
ble.9658:
	jalr	x0, x1, 0
read_all_object.2639:
	lw		x27, 4(x27)	# 851
	lui		x4, 0	# 851
	ori		x4, x0, 0	# 851
	lw		x31, 0(x27)	# 851
	jalr	x0, x31, 0	# 851
read_net_item.2641:
	sw		x4, 0(x2)	# 858
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, min_caml_read_int
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 858
	lui		x5, -1	# 859
	ori		x5, x0, -1	# 859
	beq		x4, x5, beq.9662	# 859
	lw		x5, 0(x2)	# 861
	addi	x6, x5, 1	# 861
	sw		x4, 4(x2)	# 861
	addi	x4, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, read_net_item.2641
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 861
	lw		x5, 0(x2)	# 862
	mul		x5, x5, 4	# 862
	add		x5, x4, x5	# 862
	lw		x6, 4(x2)	# 862
	sw		x6, 0(x5)	# 862
	addi	x10, x4, 0	# 862
	jalr	x0, x1, 0
beq.9662:
	lw		x4, 0(x2)	# 859
	addi	x4, x4, 1	# 859
	lui		x5, -1	# 859
	ori		x5, x0, -1	# 859
	jal		x0, min_caml_create_array	# 859
read_or_network.2643:
	lui		x5, 0	# 866
	ori		x5, x0, 0	# 866
	sw		x4, 0(x2)	# 866
	addi	x4, x5, 0
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, read_net_item.2641
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x5, x10, 0	# 866
	lui		x4, 0	# 867
	ori		x4, x0, 0	# 867
	mul		x4, x4, 4	# 867
	add		x4, x5, x4	# 867
	lw		x4, 0(x4)	# 867
	lui		x6, -1	# 867
	ori		x6, x0, -1	# 867
	beq		x4, x6, beq.9663	# 867
	lw		x4, 0(x2)	# 870
	addi	x6, x4, 1	# 870
	sw		x5, 4(x2)	# 870
	addi	x4, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, read_or_network.2643
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 870
	lw		x5, 0(x2)	# 871
	mul		x5, x5, 4	# 871
	add		x5, x4, x5	# 871
	lw		x6, 4(x2)	# 871
	sw		x6, 0(x5)	# 871
	addi	x10, x4, 0	# 871
	jalr	x0, x1, 0
beq.9663:
	lw		x4, 0(x2)	# 868
	addi	x4, x4, 1	# 868
	jal		x0, min_caml_create_array	# 868
read_and_network.2645:
	lw		x5, 4(x27)	# 875
	lui		x6, 0	# 875
	ori		x6, x0, 0	# 875
	sw		x27, 0(x2)	# 875
	sw		x5, 4(x2)	# 875
	sw		x4, 8(x2)	# 875
	addi	x4, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, read_net_item.2641
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 875
	lui		x5, 0	# 876
	ori		x5, x0, 0	# 876
	mul		x5, x5, 4	# 876
	add		x5, x4, x5	# 876
	lw		x5, 0(x5)	# 876
	lui		x6, -1	# 876
	ori		x6, x0, -1	# 876
	beq		x5, x6, beq.9664	# 876
	lw		x5, 8(x2)	# 878
	mul		x6, x5, 4	# 878
	lw		x7, 4(x2)	# 878
	add		x6, x7, x6	# 878
	sw		x4, 0(x6)	# 878
	addi	x4, x5, 1	# 879
	lw		x27, 0(x2)	# 879
	lw		x31, 0(x27)	# 879
	jalr	x0, x31, 0	# 879
beq.9664:
	jalr	x0, x1, 0
read_parameter.2647:
	lw		x4, 20(x27)	# 885
	lw		x5, 16(x27)	# 885
	lw		x6, 12(x27)	# 885
	lw		x7, 8(x27)	# 885
	lw		x8, 4(x27)	# 885
	sw		x8, 0(x2)	# 885
	sw		x6, 4(x2)	# 885
	sw		x7, 8(x2)	# 885
	sw		x5, 12(x2)	# 885
	addi	x27, x4, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lw		x27, 12(x2)	# 886
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lw		x27, 8(x2)	# 887
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lui		x4, 0	# 888
	ori		x4, x0, 0	# 888
	lw		x27, 4(x2)	# 888
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lui		x4, 0	# 889
	ori		x4, x0, 0	# 889
	lui		x5, 0	# 889
	ori		x5, x0, 0	# 889
	sw		x4, 16(x2)	# 889
	addi	x4, x5, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, read_or_network.2643
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 889
	lw		x5, 16(x2)	# 889
	mul		x5, x5, 4	# 889
	lw		x6, 0(x2)	# 889
	add		x5, x6, x5	# 889
	sw		x4, 0(x5)	# 889
	jalr	x0, x1, 0
solver_rect_surface.2649:
	lw		x9, 4(x27)	# 909
	mul		x11, x6, 8	# 909
	add		x11, x5, x11	# 909
	flw		f3, 0(x11)	# 909
	sw		x9, 0(x2)	# 909
	fsw		f2, 8(x2)	# 909
	sw		x8, 16(x2)	# 909
	fsw		f1, 24(x2)	# 909
	sw		x7, 32(x2)	# 909
	fsw		f0, 40(x2)	# 909
	sw		x5, 48(x2)	# 909
	sw		x6, 52(x2)	# 909
	sw		x4, 56(x2)	# 909
	fsub	f0, f0, f0
	fadd	f0, f0, f3
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, fiszero.2443
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 909
	lui		x5, 0	# 909
	ori		x5, x0, 0	# 909
	beq		x4, x5, beq.9670	# 909
	lui		x10, 0	# 909
	ori		x10, x0, 0	# 909
	jalr	x0, x1, 0
beq.9670:
	lw		x4, 56(x2)	# 910
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_param_abc.2571
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 910
	lw		x5, 56(x2)	# 911
	sw		x4, 60(x2)	# 911
	addi	x4, x5, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, o_isinvert.2561
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 911
	lw		x5, 52(x2)	# 911
	mul		x6, x5, 8	# 911
	lw		x7, 48(x2)	# 911
	add		x6, x7, x6	# 911
	flw		f0, 0(x6)	# 911
	sw		x4, 64(x2)	# 911
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fisneg.2447
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x5, x10, 0	# 911
	lw		x4, 64(x2)	# 911
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, xor.2506
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 911
	lw		x5, 52(x2)	# 911
	mul		x6, x5, 8	# 911
	lw		x7, 60(x2)	# 911
	add		x6, x7, x6	# 911
	flw		f0, 0(x6)	# 911
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fneg_cond.2511
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 911
	fadd	f0, f0, f10	# 911
	flw		f1, 40(x2)	# 913
	fsub	f0, f0, f1	# 913
	lw		x4, 52(x2)	# 913
	mul		x4, x4, 8	# 913
	lw		x5, 48(x2)	# 913
	add		x4, x5, x4	# 913
	flw		f1, 0(x4)	# 913
	fdiv	f0, f0, f1	# 913
	lw		x4, 32(x2)	# 914
	mul		x6, x4, 8	# 914
	add		x6, x5, x6	# 914
	flw		f1, 0(x6)	# 914
	fmul	f1, f0, f1	# 914
	flw		f2, 24(x2)	# 914
	fadd	f1, f1, f2	# 914
	fsw		f0, 72(x2)	# 914
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fabs.2451
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 914
	fadd	f0, f0, f10	# 914
	lw		x4, 32(x2)	# 914
	mul		x4, x4, 8	# 914
	lw		x5, 60(x2)	# 914
	add		x4, x5, x4	# 914
	flw		f1, 0(x4)	# 914
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fless.2453
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 914
	lui		x5, 0	# 914
	ori		x5, x0, 0	# 914
	beq		x4, x5, beq.9672	# 914
	lw		x4, 16(x2)	# 915
	mul		x5, x4, 8	# 915
	lw		x6, 48(x2)	# 915
	add		x5, x6, x5	# 915
	flw		f0, 0(x5)	# 915
	flw		f1, 72(x2)	# 915
	fmul	f0, f1, f0	# 915
	flw		f2, 8(x2)	# 915
	fadd	f0, f0, f2	# 915
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fabs.2451
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 915
	fadd	f0, f0, f10	# 915
	lw		x4, 16(x2)	# 915
	mul		x4, x4, 8	# 915
	lw		x5, 60(x2)	# 915
	add		x4, x5, x4	# 915
	flw		f1, 0(x4)	# 915
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fless.2453
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 915
	lui		x5, 0	# 915
	ori		x5, x0, 0	# 915
	beq		x4, x5, beq.9673	# 915
	lui		x4, 0	# 916
	ori		x4, x0, 0	# 916
	mul		x4, x4, 8	# 916
	lw		x5, 0(x2)	# 916
	add		x4, x5, x4	# 916
	flw		f0, 72(x2)	# 916
	fsw		f0, 0(x4)	# 916
	lui		x10, 1	# 916
	ori		x10, x0, 1	# 916
	jalr	x0, x1, 0
beq.9673:
	lui		x10, 0	# 917
	ori		x10, x0, 0	# 917
	jalr	x0, x1, 0
beq.9672:
	lui		x10, 0	# 918
	ori		x10, x0, 0	# 918
	jalr	x0, x1, 0
solver_rect.2658:
	lw		x27, 4(x27)	# 924
	lui		x6, 0	# 924
	ori		x6, x0, 0	# 924
	lui		x7, 1	# 924
	ori		x7, x0, 1	# 924
	lui		x8, 2	# 924
	ori		x8, x0, 2	# 924
	fsw		f0, 0(x2)	# 924
	fsw		f2, 8(x2)	# 924
	fsw		f1, 16(x2)	# 924
	sw		x5, 24(x2)	# 924
	sw		x4, 28(x2)	# 924
	sw		x27, 32(x2)	# 924
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 924
	lui		x5, 0	# 924
	ori		x5, x0, 0	# 924
	beq		x4, x5, beq.9674	# 924
	lui		x10, 1	# 924
	ori		x10, x0, 1	# 924
	jalr	x0, x1, 0
beq.9674:
	lui		x6, 1	# 925
	ori		x6, x0, 1	# 925
	lui		x7, 2	# 925
	ori		x7, x0, 2	# 925
	lui		x8, 0	# 925
	ori		x8, x0, 0	# 925
	flw		f0, 16(x2)	# 925
	flw		f1, 8(x2)	# 925
	flw		f2, 0(x2)	# 925
	lw		x4, 28(x2)	# 925
	lw		x5, 24(x2)	# 925
	lw		x27, 32(x2)	# 925
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 925
	lui		x5, 0	# 925
	ori		x5, x0, 0	# 925
	beq		x4, x5, beq.9675	# 925
	lui		x10, 2	# 925
	ori		x10, x0, 2	# 925
	jalr	x0, x1, 0
beq.9675:
	lui		x6, 2	# 926
	ori		x6, x0, 2	# 926
	lui		x7, 0	# 926
	ori		x7, x0, 0	# 926
	lui		x8, 1	# 926
	ori		x8, x0, 1	# 926
	flw		f0, 8(x2)	# 926
	flw		f1, 0(x2)	# 926
	flw		f2, 16(x2)	# 926
	lw		x4, 28(x2)	# 926
	lw		x5, 24(x2)	# 926
	lw		x27, 32(x2)	# 926
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 926
	lui		x5, 0	# 926
	ori		x5, x0, 0	# 926
	beq		x4, x5, beq.9676	# 926
	lui		x10, 3	# 926
	ori		x10, x0, 3	# 926
	jalr	x0, x1, 0
beq.9676:
	lui		x10, 0	# 927
	ori		x10, x0, 0	# 927
	jalr	x0, x1, 0
solver_surface.2664:
	lw		x6, 4(x27)	# 935
	sw		x6, 0(x2)	# 935
	fsw		f2, 8(x2)	# 935
	fsw		f1, 16(x2)	# 935
	fsw		f0, 24(x2)	# 935
	sw		x5, 32(x2)	# 935
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_param_abc.2571
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x5, x10, 0	# 935
	lw		x4, 32(x2)	# 936
	sw		x5, 36(x2)	# 936
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, veciprod.2533
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 936
	fadd	f0, f0, f10	# 936
	fsw		f0, 40(x2)	# 937
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fispos.2445
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 937
	lui		x5, 0	# 937
	ori		x5, x0, 0	# 937
	beq		x4, x5, beq.9678	# 937
	lui		x4, 0	# 938
	ori		x4, x0, 0	# 938
	flw		f0, 24(x2)	# 938
	flw		f1, 16(x2)	# 938
	flw		f2, 8(x2)	# 938
	lw		x5, 36(x2)	# 938
	sw		x4, 48(x2)	# 938
	addi	x4, x5, 0
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, veciprod2.2536
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 938
	fadd	f0, f0, f10	# 938
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fneg.2449
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 938
	fadd	f0, f0, f10	# 938
	flw		f1, 40(x2)	# 938
	fdiv	f0, f0, f1	# 938
	lw		x4, 48(x2)	# 938
	mul		x4, x4, 8	# 938
	lw		x5, 0(x2)	# 938
	add		x4, x5, x4	# 938
	fsw		f0, 0(x4)	# 938
	lui		x10, 1	# 939
	ori		x10, x0, 1	# 939
	jalr	x0, x1, 0
beq.9678:
	lui		x10, 0	# 940
	ori		x10, x0, 0	# 940
	jalr	x0, x1, 0
quadratic.2670:
	fsw		f0, 0(x2)	# 948
	fsw		f2, 8(x2)	# 948
	fsw		f1, 16(x2)	# 948
	sw		x4, 24(x2)	# 948
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, fsqr.2458
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 948
	fadd	f0, f0, f10	# 948
	lw		x4, 24(x2)	# 948
	fsw		f0, 32(x2)	# 948
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_param_a.2565
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 948
	fadd	f0, f0, f10	# 948
	flw		f1, 32(x2)	# 948
	fmul	f0, f1, f0	# 948
	flw		f1, 16(x2)	# 948
	fsw		f0, 40(x2)	# 948
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fsqr.2458
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 948
	fadd	f0, f0, f10	# 948
	lw		x4, 24(x2)	# 948
	fsw		f0, 48(x2)	# 948
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_param_b.2567
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 948
	fadd	f0, f0, f10	# 948
	flw		f1, 48(x2)	# 948
	fmul	f0, f1, f0	# 948
	flw		f1, 40(x2)	# 948
	fadd	f0, f1, f0	# 948
	flw		f1, 8(x2)	# 948
	fsw		f0, 56(x2)	# 948
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fsqr.2458
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 948
	fadd	f0, f0, f10	# 948
	lw		x4, 24(x2)	# 948
	fsw		f0, 64(x2)	# 948
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_c.2569
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 948
	fadd	f0, f0, f10	# 948
	flw		f1, 64(x2)	# 948
	fmul	f0, f1, f0	# 948
	flw		f1, 56(x2)	# 948
	fadd	f0, f1, f0	# 948
	lw		x4, 24(x2)	# 950
	fsw		f0, 72(x2)	# 950
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, o_isrot.2563
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 950
	lui		x5, 0	# 950
	ori		x5, x0, 0	# 950
	beq		x4, x5, beq.9680	# 950
	flw		f0, 8(x2)	# 954
	flw		f1, 16(x2)	# 954
	fmul	f2, f1, f0	# 954
	lw		x4, 24(x2)	# 954
	fsw		f2, 80(x2)	# 954
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, o_param_r1.2589
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 954
	fadd	f0, f0, f10	# 954
	flw		f1, 80(x2)	# 954
	fmul	f0, f1, f0	# 954
	flw		f1, 72(x2)	# 953
	fadd	f0, f1, f0	# 953
	flw		f1, 0(x2)	# 955
	flw		f2, 8(x2)	# 955
	fmul	f2, f2, f1	# 955
	lw		x4, 24(x2)	# 955
	fsw		f0, 88(x2)	# 955
	fsw		f2, 96(x2)	# 955
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, o_param_r2.2591
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 955
	fadd	f0, f0, f10	# 955
	flw		f1, 96(x2)	# 955
	fmul	f0, f1, f0	# 955
	flw		f1, 88(x2)	# 953
	fadd	f0, f1, f0	# 953
	flw		f1, 16(x2)	# 956
	flw		f2, 0(x2)	# 956
	fmul	f1, f2, f1	# 956
	lw		x4, 24(x2)	# 956
	fsw		f0, 104(x2)	# 956
	fsw		f1, 112(x2)	# 956
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, o_param_r3.2593
	addi	x2, x2, -128
	lw		x1, 124(x2)
	fsub	f0, f0, f0	# 956
	fadd	f0, f0, f10	# 956
	flw		f1, 112(x2)	# 956
	fmul	f0, f1, f0	# 956
	flw		f1, 104(x2)	# 953
	fadd	f10, f1, f0	# 953
	jalr	x0, x1, 0
beq.9680:
	flw		f0, 72(x2)	# 951
	fsub	f10, f10, f10	# 951
	fadd	f10, f10, f0	# 951
	jalr	x0, x1, 0
bilinear.2675:
	fmul	f6, f0, f3	# 962
	fsw		f3, 0(x2)	# 962
	fsw		f0, 8(x2)	# 962
	fsw		f5, 16(x2)	# 962
	fsw		f2, 24(x2)	# 962
	sw		x4, 32(x2)	# 962
	fsw		f4, 40(x2)	# 962
	fsw		f1, 48(x2)	# 962
	fsw		f6, 56(x2)	# 962
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, o_param_a.2565
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 962
	fadd	f0, f0, f10	# 962
	flw		f1, 56(x2)	# 962
	fmul	f0, f1, f0	# 962
	flw		f1, 40(x2)	# 963
	flw		f2, 48(x2)	# 963
	fmul	f3, f2, f1	# 963
	lw		x4, 32(x2)	# 963
	fsw		f0, 64(x2)	# 963
	fsw		f3, 72(x2)	# 963
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, o_param_b.2567
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 963
	fadd	f0, f0, f10	# 963
	flw		f1, 72(x2)	# 963
	fmul	f0, f1, f0	# 963
	flw		f1, 64(x2)	# 962
	fadd	f0, f1, f0	# 962
	flw		f1, 16(x2)	# 964
	flw		f2, 24(x2)	# 964
	fmul	f3, f2, f1	# 964
	lw		x4, 32(x2)	# 964
	fsw		f0, 80(x2)	# 964
	fsw		f3, 88(x2)	# 964
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, o_param_c.2569
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f0, f0, f0	# 964
	fadd	f0, f0, f10	# 964
	flw		f1, 88(x2)	# 964
	fmul	f0, f1, f0	# 964
	flw		f1, 80(x2)	# 962
	fadd	f0, f1, f0	# 962
	lw		x4, 32(x2)	# 966
	fsw		f0, 96(x2)	# 966
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, o_isrot.2563
	addi	x2, x2, -112
	lw		x1, 108(x2)
	addi	x4, x10, 0	# 966
	lui		x5, 0	# 966
	ori		x5, x0, 0	# 966
	beq		x4, x5, beq.9682	# 966
	flw		f0, 40(x2)	# 970
	flw		f1, 24(x2)	# 970
	fmul	f2, f1, f0	# 970
	flw		f3, 16(x2)	# 970
	flw		f4, 48(x2)	# 970
	fmul	f5, f4, f3	# 970
	fadd	f2, f2, f5	# 970
	lw		x4, 32(x2)	# 970
	fsw		f2, 104(x2)	# 970
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, o_param_r1.2589
	addi	x2, x2, -120
	lw		x1, 116(x2)
	fsub	f0, f0, f0	# 970
	fadd	f0, f0, f10	# 970
	flw		f1, 104(x2)	# 970
	fmul	f0, f1, f0	# 970
	flw		f1, 16(x2)	# 971
	flw		f2, 8(x2)	# 971
	fmul	f1, f2, f1	# 971
	flw		f3, 0(x2)	# 971
	flw		f4, 24(x2)	# 971
	fmul	f4, f4, f3	# 971
	fadd	f1, f1, f4	# 971
	lw		x4, 32(x2)	# 971
	fsw		f0, 112(x2)	# 971
	fsw		f1, 120(x2)	# 971
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, o_param_r2.2591
	addi	x2, x2, -136
	lw		x1, 132(x2)
	fsub	f0, f0, f0	# 971
	fadd	f0, f0, f10	# 971
	flw		f1, 120(x2)	# 971
	fmul	f0, f1, f0	# 971
	flw		f1, 112(x2)	# 970
	fadd	f0, f1, f0	# 970
	flw		f1, 40(x2)	# 972
	flw		f2, 8(x2)	# 972
	fmul	f1, f2, f1	# 972
	flw		f2, 0(x2)	# 972
	flw		f3, 48(x2)	# 972
	fmul	f2, f3, f2	# 972
	fadd	f1, f1, f2	# 972
	lw		x4, 32(x2)	# 972
	fsw		f0, 128(x2)	# 972
	fsw		f1, 136(x2)	# 972
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, o_param_r3.2593
	addi	x2, x2, -152
	lw		x1, 148(x2)
	fsub	f0, f0, f0	# 972
	fadd	f0, f0, f10	# 972
	flw		f1, 136(x2)	# 972
	fmul	f0, f1, f0	# 972
	flw		f1, 128(x2)	# 970
	fadd	f0, f1, f0	# 970
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, fhalf.2456
	addi	x2, x2, -152
	lw		x1, 148(x2)
	fsub	f0, f0, f0	# 969
	fadd	f0, f0, f10	# 969
	flw		f1, 96(x2)	# 969
	fadd	f10, f1, f0	# 969
	jalr	x0, x1, 0
beq.9682:
	flw		f0, 96(x2)	# 967
	fsub	f10, f10, f10	# 967
	fadd	f10, f10, f0	# 967
	jalr	x0, x1, 0
solver_second.2683:
	lw		x6, 4(x27)	# 987
	lui		x7, 0	# 987
	ori		x7, x0, 0	# 987
	mul		x7, x7, 8	# 987
	add		x7, x5, x7	# 987
	flw		f3, 0(x7)	# 987
	lui		x7, 1	# 987
	ori		x7, x0, 1	# 987
	mul		x7, x7, 8	# 987
	add		x7, x5, x7	# 987
	flw		f4, 0(x7)	# 987
	lui		x7, 2	# 987
	ori		x7, x0, 2	# 987
	mul		x7, x7, 8	# 987
	add		x7, x5, x7	# 987
	flw		f5, 0(x7)	# 987
	sw		x6, 0(x2)	# 987
	fsw		f2, 8(x2)	# 987
	fsw		f1, 16(x2)	# 987
	fsw		f0, 24(x2)	# 987
	sw		x4, 32(x2)	# 987
	sw		x5, 36(x2)	# 987
	fsub	f2, f2, f2
	fadd	f2, f2, f5
	fsub	f1, f1, f1
	fadd	f1, f1, f4
	fsub	f0, f0, f0
	fadd	f0, f0, f3
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, quadratic.2670
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 987
	fadd	f0, f0, f10	# 987
	fsw		f0, 40(x2)	# 989
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fiszero.2443
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 989
	lui		x5, 0	# 989
	ori		x5, x0, 0	# 989
	beq		x4, x5, beq.9684	# 989
	lui		x10, 0	# 990
	ori		x10, x0, 0	# 990
	jalr	x0, x1, 0
beq.9684:
	lui		x4, 0	# 994
	ori		x4, x0, 0	# 994
	mul		x4, x4, 8	# 994
	lw		x5, 36(x2)	# 994
	add		x4, x5, x4	# 994
	flw		f0, 0(x4)	# 994
	lui		x4, 1	# 994
	ori		x4, x0, 1	# 994
	mul		x4, x4, 8	# 994
	add		x4, x5, x4	# 994
	flw		f1, 0(x4)	# 994
	lui		x4, 2	# 994
	ori		x4, x0, 2	# 994
	mul		x4, x4, 8	# 994
	add		x4, x5, x4	# 994
	flw		f2, 0(x4)	# 994
	flw		f3, 24(x2)	# 994
	flw		f4, 16(x2)	# 994
	flw		f5, 8(x2)	# 994
	lw		x4, 32(x2)	# 994
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, bilinear.2675
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 994
	fadd	f0, f0, f10	# 994
	flw		f1, 24(x2)	# 996
	flw		f2, 16(x2)	# 996
	flw		f3, 8(x2)	# 996
	lw		x4, 32(x2)	# 996
	fsw		f0, 48(x2)	# 996
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	fsub	f1, f1, f1
	fadd	f1, f1, f2
	fsub	f2, f2, f2
	fadd	f2, f2, f3
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, quadratic.2670
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 996
	fadd	f0, f0, f10	# 996
	lw		x4, 32(x2)	# 997
	fsw		f0, 56(x2)	# 997
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, o_form.2557
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 997
	lui		x5, 3	# 997
	ori		x5, x0, 3	# 997
	beq		x4, x5, beq.9685	# 997
	flw		f0, 56(x2)	# 997
	jal		x0, beq_cont.9686	# 997
beq.9685:
	lui		x4, %hi(l.6062)	# 997
	ori		x4, %lo(l.6062)	# 997
	flw		f0, 0(x4)	# 997
	flw		f1, 56(x2)	# 997
	fsub	f0, f1, f0	# 997
beq_cont.9686:
	flw		f1, 48(x2)	# 999
	fsw		f0, 64(x2)	# 999
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fsqr.2458
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 999
	fadd	f0, f0, f10	# 999
	flw		f1, 64(x2)	# 999
	flw		f2, 40(x2)	# 999
	fmul	f1, f2, f1	# 999
	fsub	f0, f0, f1	# 999
	fsw		f0, 72(x2)	# 1001
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fispos.2445
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 1001
	lui		x5, 0	# 1001
	ori		x5, x0, 0	# 1001
	beq		x4, x5, beq.9687	# 1001
	flw		f0, 72(x2)	# 1002
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, min_caml_sqrt
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1002
	fadd	f0, f0, f10	# 1002
	lw		x4, 32(x2)	# 1003
	fsw		f0, 80(x2)	# 1003
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, o_isinvert.2561
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 1003
	lui		x5, 0	# 1003
	ori		x5, x0, 0	# 1003
	beq		x4, x5, beq.9688	# 1003
	flw		f0, 80(x2)	# 1003
	jal		x0, beq_cont.9689	# 1003
beq.9688:
	flw		f0, 80(x2)	# 1003
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, fneg.2449
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 1003
	fadd	f0, f0, f10	# 1003
beq_cont.9689:
	lui		x4, 0	# 1004
	ori		x4, x0, 0	# 1004
	flw		f1, 48(x2)	# 1004
	fsub	f0, f0, f1	# 1004
	flw		f1, 40(x2)	# 1004
	fdiv	f0, f0, f1	# 1004
	mul		x4, x4, 8	# 1004
	lw		x5, 0(x2)	# 1004
	add		x4, x5, x4	# 1004
	fsw		f0, 0(x4)	# 1004
	lui		x10, 1	# 1004
	ori		x10, x0, 1	# 1004
	jalr	x0, x1, 0
beq.9687:
	lui		x10, 0	# 1007
	ori		x10, x0, 0	# 1007
	jalr	x0, x1, 0
solver.2689:
	lw		x7, 16(x27)	# 1013
	lw		x8, 12(x27)	# 1013
	lw		x9, 8(x27)	# 1013
	lw		x11, 4(x27)	# 1013
	mul		x4, x4, 4	# 1013
	add		x4, x11, x4	# 1013
	lw		x4, 0(x4)	# 1013
	lui		x11, 0	# 1015
	ori		x11, x0, 0	# 1015
	mul		x11, x11, 8	# 1015
	add		x11, x6, x11	# 1015
	flw		f0, 0(x11)	# 1015
	sw		x8, 0(x2)	# 1015
	sw		x7, 4(x2)	# 1015
	sw		x5, 8(x2)	# 1015
	sw		x9, 12(x2)	# 1015
	sw		x4, 16(x2)	# 1015
	sw		x6, 20(x2)	# 1015
	fsw		f0, 24(x2)	# 1015
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_param_x.2573
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1015
	fadd	f0, f0, f10	# 1015
	flw		f1, 24(x2)	# 1015
	fsub	f0, f1, f0	# 1015
	lui		x4, 1	# 1016
	ori		x4, x0, 1	# 1016
	mul		x4, x4, 8	# 1016
	lw		x5, 20(x2)	# 1016
	add		x4, x5, x4	# 1016
	flw		f1, 0(x4)	# 1016
	lw		x4, 16(x2)	# 1016
	fsw		f0, 32(x2)	# 1016
	fsw		f1, 40(x2)	# 1016
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, o_param_y.2575
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 1016
	fadd	f0, f0, f10	# 1016
	flw		f1, 40(x2)	# 1016
	fsub	f0, f1, f0	# 1016
	lui		x4, 2	# 1017
	ori		x4, x0, 2	# 1017
	mul		x4, x4, 8	# 1017
	lw		x5, 20(x2)	# 1017
	add		x4, x5, x4	# 1017
	flw		f1, 0(x4)	# 1017
	lw		x4, 16(x2)	# 1017
	fsw		f0, 48(x2)	# 1017
	fsw		f1, 56(x2)	# 1017
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, o_param_z.2577
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1017
	fadd	f0, f0, f10	# 1017
	flw		f1, 56(x2)	# 1017
	fsub	f0, f1, f0	# 1017
	lw		x4, 16(x2)	# 1018
	fsw		f0, 64(x2)	# 1018
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_form.2557
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1018
	lui		x5, 1	# 1020
	ori		x5, x0, 1	# 1020
	beq		x4, x5, beq.9690	# 1020
	lui		x5, 2	# 1021
	ori		x5, x0, 2	# 1021
	beq		x4, x5, beq.9691	# 1021
	flw		f0, 32(x2)	# 1022
	flw		f1, 48(x2)	# 1022
	flw		f2, 64(x2)	# 1022
	lw		x4, 16(x2)	# 1022
	lw		x5, 8(x2)	# 1022
	lw		x27, 0(x2)	# 1022
	lw		x31, 0(x27)	# 1022
	jalr	x0, x31, 0	# 1022
beq.9691:
	flw		f0, 32(x2)	# 1021
	flw		f1, 48(x2)	# 1021
	flw		f2, 64(x2)	# 1021
	lw		x4, 16(x2)	# 1021
	lw		x5, 8(x2)	# 1021
	lw		x27, 4(x2)	# 1021
	lw		x31, 0(x27)	# 1021
	jalr	x0, x31, 0	# 1021
beq.9690:
	flw		f0, 32(x2)	# 1020
	flw		f1, 48(x2)	# 1020
	flw		f2, 64(x2)	# 1020
	lw		x4, 16(x2)	# 1020
	lw		x5, 8(x2)	# 1020
	lw		x27, 12(x2)	# 1020
	lw		x31, 0(x27)	# 1020
	jalr	x0, x31, 0	# 1020
solver_rect_fast.2693:
	lw		x7, 4(x27)	# 1045
	lui		x8, 0	# 1045
	ori		x8, x0, 0	# 1045
	mul		x8, x8, 8	# 1045
	add		x8, x6, x8	# 1045
	flw		f3, 0(x8)	# 1045
	fsub	f3, f3, f0	# 1045
	lui		x8, 1	# 1045
	ori		x8, x0, 1	# 1045
	mul		x8, x8, 8	# 1045
	add		x8, x6, x8	# 1045
	flw		f4, 0(x8)	# 1045
	fmul	f3, f3, f4	# 1045
	lui		x8, 1	# 1047
	ori		x8, x0, 1	# 1047
	mul		x8, x8, 8	# 1047
	add		x8, x5, x8	# 1047
	flw		f4, 0(x8)	# 1047
	fmul	f4, f3, f4	# 1047
	fadd	f4, f4, f1	# 1047
	sw		x7, 0(x2)	# 1047
	fsw		f0, 8(x2)	# 1047
	fsw		f1, 16(x2)	# 1047
	sw		x6, 24(x2)	# 1047
	fsw		f2, 32(x2)	# 1047
	fsw		f3, 40(x2)	# 1047
	sw		x5, 48(x2)	# 1047
	sw		x4, 52(x2)	# 1047
	fsub	f0, f0, f0
	fadd	f0, f0, f4
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, fabs.2451
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1047
	fadd	f0, f0, f10	# 1047
	lw		x4, 52(x2)	# 1047
	fsw		f0, 56(x2)	# 1047
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, o_param_b.2567
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f1, f1, f1	# 1047
	fadd	f1, f1, f10	# 1047
	flw		f0, 56(x2)	# 1047
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fless.2453
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 1047
	lui		x5, 0	# 1047
	ori		x5, x0, 0	# 1047
	beq		x4, x5, beq.9694	# 1047
	lui		x4, 2	# 1048
	ori		x4, x0, 2	# 1048
	mul		x4, x4, 8	# 1048
	lw		x5, 48(x2)	# 1048
	add		x4, x5, x4	# 1048
	flw		f0, 0(x4)	# 1048
	flw		f1, 40(x2)	# 1048
	fmul	f0, f1, f0	# 1048
	flw		f2, 32(x2)	# 1048
	fadd	f0, f0, f2	# 1048
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fabs.2451
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1048
	fadd	f0, f0, f10	# 1048
	lw		x4, 52(x2)	# 1048
	fsw		f0, 64(x2)	# 1048
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_c.2569
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f1, f1, f1	# 1048
	fadd	f1, f1, f10	# 1048
	flw		f0, 64(x2)	# 1048
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fless.2453
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1048
	lui		x5, 0	# 1048
	ori		x5, x0, 0	# 1048
	beq		x4, x5, beq.9696	# 1048
	lui		x4, 1	# 1049
	ori		x4, x0, 1	# 1049
	mul		x4, x4, 8	# 1049
	lw		x5, 24(x2)	# 1049
	add		x4, x5, x4	# 1049
	flw		f0, 0(x4)	# 1049
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fiszero.2443
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1049
	lui		x5, 0	# 1049
	ori		x5, x0, 0	# 1049
	beq		x4, x5, beq.9698	# 1049
	lui		x4, 0	# 1049
	ori		x4, x0, 0	# 1049
	jal		x0, beq_cont.9699	# 1049
beq.9698:
	lui		x4, 1	# 1049
	ori		x4, x0, 1	# 1049
beq_cont.9699:
	jal		x0, beq_cont.9697	# 1048
beq.9696:
	lui		x4, 0	# 1050
	ori		x4, x0, 0	# 1050
beq_cont.9697:
	jal		x0, beq_cont.9695	# 1047
beq.9694:
	lui		x4, 0	# 1051
	ori		x4, x0, 0	# 1051
beq_cont.9695:
	lui		x5, 0	# 1046
	ori		x5, x0, 0	# 1046
	beq		x4, x5, beq.9700	# 1046
	lui		x4, 0	# 1053
	ori		x4, x0, 0	# 1053
	mul		x4, x4, 8	# 1053
	lw		x5, 0(x2)	# 1053
	add		x4, x5, x4	# 1053
	flw		f0, 40(x2)	# 1053
	fsw		f0, 0(x4)	# 1053
	lui		x10, 1	# 1053
	ori		x10, x0, 1	# 1053
	jalr	x0, x1, 0
beq.9700:
	lui		x4, 2	# 1054
	ori		x4, x0, 2	# 1054
	mul		x4, x4, 8	# 1054
	lw		x5, 24(x2)	# 1054
	add		x4, x5, x4	# 1054
	flw		f0, 0(x4)	# 1054
	flw		f1, 16(x2)	# 1054
	fsub	f0, f0, f1	# 1054
	lui		x4, 3	# 1054
	ori		x4, x0, 3	# 1054
	mul		x4, x4, 8	# 1054
	add		x4, x5, x4	# 1054
	flw		f2, 0(x4)	# 1054
	fmul	f0, f0, f2	# 1054
	lui		x4, 0	# 1056
	ori		x4, x0, 0	# 1056
	mul		x4, x4, 8	# 1056
	lw		x6, 48(x2)	# 1056
	add		x4, x6, x4	# 1056
	flw		f2, 0(x4)	# 1056
	fmul	f2, f0, f2	# 1056
	flw		f3, 8(x2)	# 1056
	fadd	f2, f2, f3	# 1056
	fsw		f0, 72(x2)	# 1056
	fsub	f0, f0, f0
	fadd	f0, f0, f2
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fabs.2451
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1056
	fadd	f0, f0, f10	# 1056
	lw		x4, 52(x2)	# 1056
	fsw		f0, 80(x2)	# 1056
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, o_param_a.2565
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f1, f1, f1	# 1056
	fadd	f1, f1, f10	# 1056
	flw		f0, 80(x2)	# 1056
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, fless.2453
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 1056
	lui		x5, 0	# 1056
	ori		x5, x0, 0	# 1056
	beq		x4, x5, beq.9701	# 1056
	lui		x4, 2	# 1057
	ori		x4, x0, 2	# 1057
	mul		x4, x4, 8	# 1057
	lw		x5, 48(x2)	# 1057
	add		x4, x5, x4	# 1057
	flw		f0, 0(x4)	# 1057
	flw		f1, 72(x2)	# 1057
	fmul	f0, f1, f0	# 1057
	flw		f2, 32(x2)	# 1057
	fadd	f0, f0, f2	# 1057
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, fabs.2451
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 1057
	fadd	f0, f0, f10	# 1057
	lw		x4, 52(x2)	# 1057
	fsw		f0, 88(x2)	# 1057
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, o_param_c.2569
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f1, f1, f1	# 1057
	fadd	f1, f1, f10	# 1057
	flw		f0, 88(x2)	# 1057
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, fless.2453
	addi	x2, x2, -104
	lw		x1, 100(x2)
	addi	x4, x10, 0	# 1057
	lui		x5, 0	# 1057
	ori		x5, x0, 0	# 1057
	beq		x4, x5, beq.9703	# 1057
	lui		x4, 3	# 1058
	ori		x4, x0, 3	# 1058
	mul		x4, x4, 8	# 1058
	lw		x5, 24(x2)	# 1058
	add		x4, x5, x4	# 1058
	flw		f0, 0(x4)	# 1058
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, fiszero.2443
	addi	x2, x2, -104
	lw		x1, 100(x2)
	addi	x4, x10, 0	# 1058
	lui		x5, 0	# 1058
	ori		x5, x0, 0	# 1058
	beq		x4, x5, beq.9705	# 1058
	lui		x4, 0	# 1058
	ori		x4, x0, 0	# 1058
	jal		x0, beq_cont.9706	# 1058
beq.9705:
	lui		x4, 1	# 1058
	ori		x4, x0, 1	# 1058
beq_cont.9706:
	jal		x0, beq_cont.9704	# 1057
beq.9703:
	lui		x4, 0	# 1059
	ori		x4, x0, 0	# 1059
beq_cont.9704:
	jal		x0, beq_cont.9702	# 1056
beq.9701:
	lui		x4, 0	# 1060
	ori		x4, x0, 0	# 1060
beq_cont.9702:
	lui		x5, 0	# 1055
	ori		x5, x0, 0	# 1055
	beq		x4, x5, beq.9707	# 1055
	lui		x4, 0	# 1062
	ori		x4, x0, 0	# 1062
	mul		x4, x4, 8	# 1062
	lw		x5, 0(x2)	# 1062
	add		x4, x5, x4	# 1062
	flw		f0, 72(x2)	# 1062
	fsw		f0, 0(x4)	# 1062
	lui		x10, 2	# 1062
	ori		x10, x0, 2	# 1062
	jalr	x0, x1, 0
beq.9707:
	lui		x4, 4	# 1063
	ori		x4, x0, 4	# 1063
	mul		x4, x4, 8	# 1063
	lw		x5, 24(x2)	# 1063
	add		x4, x5, x4	# 1063
	flw		f0, 0(x4)	# 1063
	flw		f1, 32(x2)	# 1063
	fsub	f0, f0, f1	# 1063
	lui		x4, 5	# 1063
	ori		x4, x0, 5	# 1063
	mul		x4, x4, 8	# 1063
	add		x4, x5, x4	# 1063
	flw		f1, 0(x4)	# 1063
	fmul	f0, f0, f1	# 1063
	lui		x4, 0	# 1065
	ori		x4, x0, 0	# 1065
	mul		x4, x4, 8	# 1065
	lw		x6, 48(x2)	# 1065
	add		x4, x6, x4	# 1065
	flw		f1, 0(x4)	# 1065
	fmul	f1, f0, f1	# 1065
	flw		f2, 8(x2)	# 1065
	fadd	f1, f1, f2	# 1065
	fsw		f0, 96(x2)	# 1065
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, fabs.2451
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1065
	fadd	f0, f0, f10	# 1065
	lw		x4, 52(x2)	# 1065
	fsw		f0, 104(x2)	# 1065
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, o_param_a.2565
	addi	x2, x2, -120
	lw		x1, 116(x2)
	fsub	f1, f1, f1	# 1065
	fadd	f1, f1, f10	# 1065
	flw		f0, 104(x2)	# 1065
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, fless.2453
	addi	x2, x2, -120
	lw		x1, 116(x2)
	addi	x4, x10, 0	# 1065
	lui		x5, 0	# 1065
	ori		x5, x0, 0	# 1065
	beq		x4, x5, beq.9708	# 1065
	lui		x4, 1	# 1066
	ori		x4, x0, 1	# 1066
	mul		x4, x4, 8	# 1066
	lw		x5, 48(x2)	# 1066
	add		x4, x5, x4	# 1066
	flw		f0, 0(x4)	# 1066
	flw		f1, 96(x2)	# 1066
	fmul	f0, f1, f0	# 1066
	flw		f2, 16(x2)	# 1066
	fadd	f0, f0, f2	# 1066
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, fabs.2451
	addi	x2, x2, -120
	lw		x1, 116(x2)
	fsub	f0, f0, f0	# 1066
	fadd	f0, f0, f10	# 1066
	lw		x4, 52(x2)	# 1066
	fsw		f0, 112(x2)	# 1066
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, o_param_b.2567
	addi	x2, x2, -128
	lw		x1, 124(x2)
	fsub	f1, f1, f1	# 1066
	fadd	f1, f1, f10	# 1066
	flw		f0, 112(x2)	# 1066
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, fless.2453
	addi	x2, x2, -128
	lw		x1, 124(x2)
	addi	x4, x10, 0	# 1066
	lui		x5, 0	# 1066
	ori		x5, x0, 0	# 1066
	beq		x4, x5, beq.9710	# 1066
	lui		x4, 5	# 1067
	ori		x4, x0, 5	# 1067
	mul		x4, x4, 8	# 1067
	lw		x5, 24(x2)	# 1067
	add		x4, x5, x4	# 1067
	flw		f0, 0(x4)	# 1067
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, fiszero.2443
	addi	x2, x2, -128
	lw		x1, 124(x2)
	addi	x4, x10, 0	# 1067
	lui		x5, 0	# 1067
	ori		x5, x0, 0	# 1067
	beq		x4, x5, beq.9712	# 1067
	lui		x4, 0	# 1067
	ori		x4, x0, 0	# 1067
	jal		x0, beq_cont.9713	# 1067
beq.9712:
	lui		x4, 1	# 1067
	ori		x4, x0, 1	# 1067
beq_cont.9713:
	jal		x0, beq_cont.9711	# 1066
beq.9710:
	lui		x4, 0	# 1068
	ori		x4, x0, 0	# 1068
beq_cont.9711:
	jal		x0, beq_cont.9709	# 1065
beq.9708:
	lui		x4, 0	# 1069
	ori		x4, x0, 0	# 1069
beq_cont.9709:
	lui		x5, 0	# 1064
	ori		x5, x0, 0	# 1064
	beq		x4, x5, beq.9714	# 1064
	lui		x4, 0	# 1071
	ori		x4, x0, 0	# 1071
	mul		x4, x4, 8	# 1071
	lw		x5, 0(x2)	# 1071
	add		x4, x5, x4	# 1071
	flw		f0, 96(x2)	# 1071
	fsw		f0, 0(x4)	# 1071
	lui		x10, 3	# 1071
	ori		x10, x0, 3	# 1071
	jalr	x0, x1, 0
beq.9714:
	lui		x10, 0	# 1073
	ori		x10, x0, 0	# 1073
	jalr	x0, x1, 0
solver_surface_fast.2700:
	lw		x4, 4(x27)	# 1078
	lui		x6, 0	# 1078
	ori		x6, x0, 0	# 1078
	mul		x6, x6, 8	# 1078
	add		x6, x5, x6	# 1078
	flw		f3, 0(x6)	# 1078
	sw		x4, 0(x2)	# 1078
	fsw		f2, 8(x2)	# 1078
	fsw		f1, 16(x2)	# 1078
	fsw		f0, 24(x2)	# 1078
	sw		x5, 32(x2)	# 1078
	fsub	f0, f0, f0
	fadd	f0, f0, f3
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fisneg.2447
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1078
	lui		x5, 0	# 1078
	ori		x5, x0, 0	# 1078
	beq		x4, x5, beq.9716	# 1078
	lui		x4, 0	# 1079
	ori		x4, x0, 0	# 1079
	lui		x5, 1	# 1080
	ori		x5, x0, 1	# 1080
	mul		x5, x5, 8	# 1080
	lw		x6, 32(x2)	# 1080
	add		x5, x6, x5	# 1080
	flw		f0, 0(x5)	# 1080
	flw		f1, 24(x2)	# 1080
	fmul	f0, f0, f1	# 1080
	lui		x5, 2	# 1080
	ori		x5, x0, 2	# 1080
	mul		x5, x5, 8	# 1080
	add		x5, x6, x5	# 1080
	flw		f1, 0(x5)	# 1080
	flw		f2, 16(x2)	# 1080
	fmul	f1, f1, f2	# 1080
	fadd	f0, f0, f1	# 1080
	lui		x5, 3	# 1080
	ori		x5, x0, 3	# 1080
	mul		x5, x5, 8	# 1080
	add		x5, x6, x5	# 1080
	flw		f1, 0(x5)	# 1080
	flw		f2, 8(x2)	# 1080
	fmul	f1, f1, f2	# 1080
	fadd	f0, f0, f1	# 1080
	mul		x4, x4, 8	# 1079
	lw		x5, 0(x2)	# 1079
	add		x4, x5, x4	# 1079
	fsw		f0, 0(x4)	# 1079
	lui		x10, 1	# 1081
	ori		x10, x0, 1	# 1081
	jalr	x0, x1, 0
beq.9716:
	lui		x10, 0	# 1082
	ori		x10, x0, 0	# 1082
	jalr	x0, x1, 0
solver_second_fast.2706:
	lw		x6, 4(x27)	# 1088
	lui		x7, 0	# 1088
	ori		x7, x0, 0	# 1088
	mul		x7, x7, 8	# 1088
	add		x7, x5, x7	# 1088
	flw		f3, 0(x7)	# 1088
	sw		x6, 0(x2)	# 1089
	fsw		f3, 8(x2)	# 1089
	sw		x4, 16(x2)	# 1089
	fsw		f2, 24(x2)	# 1089
	fsw		f1, 32(x2)	# 1089
	fsw		f0, 40(x2)	# 1089
	sw		x5, 48(x2)	# 1089
	fsub	f0, f0, f0
	fadd	f0, f0, f3
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fiszero.2443
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1089
	lui		x5, 0	# 1089
	ori		x5, x0, 0	# 1089
	beq		x4, x5, beq.9719	# 1089
	lui		x10, 0	# 1090
	ori		x10, x0, 0	# 1090
	jalr	x0, x1, 0
beq.9719:
	lui		x4, 1	# 1092
	ori		x4, x0, 1	# 1092
	mul		x4, x4, 8	# 1092
	lw		x5, 48(x2)	# 1092
	add		x4, x5, x4	# 1092
	flw		f0, 0(x4)	# 1092
	flw		f1, 40(x2)	# 1092
	fmul	f0, f0, f1	# 1092
	lui		x4, 2	# 1092
	ori		x4, x0, 2	# 1092
	mul		x4, x4, 8	# 1092
	add		x4, x5, x4	# 1092
	flw		f2, 0(x4)	# 1092
	flw		f3, 32(x2)	# 1092
	fmul	f2, f2, f3	# 1092
	fadd	f0, f0, f2	# 1092
	lui		x4, 3	# 1092
	ori		x4, x0, 3	# 1092
	mul		x4, x4, 8	# 1092
	add		x4, x5, x4	# 1092
	flw		f2, 0(x4)	# 1092
	flw		f4, 24(x2)	# 1092
	fmul	f2, f2, f4	# 1092
	fadd	f0, f0, f2	# 1092
	lw		x4, 16(x2)	# 1093
	fsw		f0, 56(x2)	# 1093
	fsub	f2, f2, f2
	fadd	f2, f2, f4
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	fsub	f1, f1, f1
	fadd	f1, f1, f3
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, quadratic.2670
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1093
	fadd	f0, f0, f10	# 1093
	lw		x4, 16(x2)	# 1094
	fsw		f0, 64(x2)	# 1094
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_form.2557
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1094
	lui		x5, 3	# 1094
	ori		x5, x0, 3	# 1094
	beq		x4, x5, beq.9721	# 1094
	flw		f0, 64(x2)	# 1094
	jal		x0, beq_cont.9722	# 1094
beq.9721:
	lui		x4, %hi(l.6062)	# 1094
	ori		x4, %lo(l.6062)	# 1094
	flw		f0, 0(x4)	# 1094
	flw		f1, 64(x2)	# 1094
	fsub	f0, f1, f0	# 1094
beq_cont.9722:
	flw		f1, 56(x2)	# 1095
	fsw		f0, 72(x2)	# 1095
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fsqr.2458
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1095
	fadd	f0, f0, f10	# 1095
	flw		f1, 72(x2)	# 1095
	flw		f2, 8(x2)	# 1095
	fmul	f1, f2, f1	# 1095
	fsub	f0, f0, f1	# 1095
	fsw		f0, 80(x2)	# 1096
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, fispos.2445
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 1096
	lui		x5, 0	# 1096
	ori		x5, x0, 0	# 1096
	beq		x4, x5, beq.9723	# 1096
	lw		x4, 16(x2)	# 1097
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, o_isinvert.2561
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 1097
	lui		x5, 0	# 1097
	ori		x5, x0, 0	# 1097
	beq		x4, x5, beq.9724	# 1097
	lui		x4, 0	# 1098
	ori		x4, x0, 0	# 1098
	flw		f0, 80(x2)	# 1098
	sw		x4, 88(x2)	# 1098
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, min_caml_sqrt
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 1098
	fadd	f0, f0, f10	# 1098
	flw		f1, 56(x2)	# 1098
	fadd	f0, f1, f0	# 1098
	lui		x4, 4	# 1098
	ori		x4, x0, 4	# 1098
	mul		x4, x4, 8	# 1098
	lw		x5, 48(x2)	# 1098
	add		x4, x5, x4	# 1098
	flw		f1, 0(x4)	# 1098
	fmul	f0, f0, f1	# 1098
	lw		x4, 88(x2)	# 1098
	mul		x4, x4, 8	# 1098
	lw		x5, 0(x2)	# 1098
	add		x4, x5, x4	# 1098
	fsw		f0, 0(x4)	# 1098
	jal		x0, beq_cont.9725	# 1097
beq.9724:
	lui		x4, 0	# 1100
	ori		x4, x0, 0	# 1100
	flw		f0, 80(x2)	# 1100
	sw		x4, 92(x2)	# 1100
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, min_caml_sqrt
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f0, f0, f0	# 1100
	fadd	f0, f0, f10	# 1100
	flw		f1, 56(x2)	# 1100
	fsub	f0, f1, f0	# 1100
	lui		x4, 4	# 1100
	ori		x4, x0, 4	# 1100
	mul		x4, x4, 8	# 1100
	lw		x5, 48(x2)	# 1100
	add		x4, x5, x4	# 1100
	flw		f1, 0(x4)	# 1100
	fmul	f0, f0, f1	# 1100
	lw		x4, 92(x2)	# 1100
	mul		x4, x4, 8	# 1100
	lw		x5, 0(x2)	# 1100
	add		x4, x5, x4	# 1100
	fsw		f0, 0(x4)	# 1100
beq_cont.9725:
	lui		x10, 1	# 1101
	ori		x10, x0, 1	# 1101
	jalr	x0, x1, 0
beq.9723:
	lui		x10, 0	# 1102
	ori		x10, x0, 0	# 1102
	jalr	x0, x1, 0
solver_fast.2712:
	lw		x7, 16(x27)	# 1107
	lw		x8, 12(x27)	# 1107
	lw		x9, 8(x27)	# 1107
	lw		x11, 4(x27)	# 1107
	mul		x12, x4, 4	# 1107
	add		x11, x11, x12	# 1107
	lw		x11, 0(x11)	# 1107
	lui		x12, 0	# 1108
	ori		x12, x0, 0	# 1108
	mul		x12, x12, 8	# 1108
	add		x12, x6, x12	# 1108
	flw		f0, 0(x12)	# 1108
	sw		x8, 0(x2)	# 1108
	sw		x7, 4(x2)	# 1108
	sw		x9, 8(x2)	# 1108
	sw		x4, 12(x2)	# 1108
	sw		x5, 16(x2)	# 1108
	sw		x11, 20(x2)	# 1108
	sw		x6, 24(x2)	# 1108
	fsw		f0, 32(x2)	# 1108
	addi	x4, x11, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_param_x.2573
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 1108
	fadd	f0, f0, f10	# 1108
	flw		f1, 32(x2)	# 1108
	fsub	f0, f1, f0	# 1108
	lui		x4, 1	# 1109
	ori		x4, x0, 1	# 1109
	mul		x4, x4, 8	# 1109
	lw		x5, 24(x2)	# 1109
	add		x4, x5, x4	# 1109
	flw		f1, 0(x4)	# 1109
	lw		x4, 20(x2)	# 1109
	fsw		f0, 40(x2)	# 1109
	fsw		f1, 48(x2)	# 1109
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_param_y.2575
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1109
	fadd	f0, f0, f10	# 1109
	flw		f1, 48(x2)	# 1109
	fsub	f0, f1, f0	# 1109
	lui		x4, 2	# 1110
	ori		x4, x0, 2	# 1110
	mul		x4, x4, 8	# 1110
	lw		x5, 24(x2)	# 1110
	add		x4, x5, x4	# 1110
	flw		f1, 0(x4)	# 1110
	lw		x4, 20(x2)	# 1110
	fsw		f0, 56(x2)	# 1110
	fsw		f1, 64(x2)	# 1110
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_z.2577
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1110
	fadd	f0, f0, f10	# 1110
	flw		f1, 64(x2)	# 1110
	fsub	f0, f1, f0	# 1110
	lw		x4, 16(x2)	# 1111
	fsw		f0, 72(x2)	# 1111
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, d_const.2618
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 1111
	lw		x5, 12(x2)	# 1112
	mul		x5, x5, 4	# 1112
	add		x4, x4, x5	# 1112
	lw		x4, 0(x4)	# 1112
	lw		x5, 20(x2)	# 1113
	sw		x4, 80(x2)	# 1113
	addi	x4, x5, 0
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, o_form.2557
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 1113
	lui		x5, 1	# 1114
	ori		x5, x0, 1	# 1114
	beq		x4, x5, beq.9727	# 1114
	lui		x5, 2	# 1116
	ori		x5, x0, 2	# 1116
	beq		x4, x5, beq.9728	# 1116
	flw		f0, 40(x2)	# 1119
	flw		f1, 56(x2)	# 1119
	flw		f2, 72(x2)	# 1119
	lw		x4, 20(x2)	# 1119
	lw		x5, 80(x2)	# 1119
	lw		x27, 0(x2)	# 1119
	lw		x31, 0(x27)	# 1119
	jalr	x0, x31, 0	# 1119
beq.9728:
	flw		f0, 40(x2)	# 1117
	flw		f1, 56(x2)	# 1117
	flw		f2, 72(x2)	# 1117
	lw		x4, 20(x2)	# 1117
	lw		x5, 80(x2)	# 1117
	lw		x27, 4(x2)	# 1117
	lw		x31, 0(x27)	# 1117
	jalr	x0, x31, 0	# 1117
beq.9727:
	lw		x4, 16(x2)	# 1115
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, d_vec.2616
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x5, x10, 0	# 1115
	flw		f0, 40(x2)	# 1115
	flw		f1, 56(x2)	# 1115
	flw		f2, 72(x2)	# 1115
	lw		x4, 20(x2)	# 1115
	lw		x6, 80(x2)	# 1115
	lw		x27, 8(x2)	# 1115
	lw		x31, 0(x27)	# 1115
	jalr	x0, x31, 0	# 1115
solver_surface_fast2.2716:
	lw		x4, 4(x27)	# 1127
	lui		x7, 0	# 1127
	ori		x7, x0, 0	# 1127
	mul		x7, x7, 8	# 1127
	add		x7, x5, x7	# 1127
	flw		f0, 0(x7)	# 1127
	sw		x4, 0(x2)	# 1127
	sw		x6, 4(x2)	# 1127
	sw		x5, 8(x2)	# 1127
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, fisneg.2447
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 1127
	lui		x5, 0	# 1127
	ori		x5, x0, 0	# 1127
	beq		x4, x5, beq.9729	# 1127
	lui		x4, 0	# 1128
	ori		x4, x0, 0	# 1128
	lui		x5, 0	# 1128
	ori		x5, x0, 0	# 1128
	mul		x5, x5, 8	# 1128
	lw		x6, 8(x2)	# 1128
	add		x5, x6, x5	# 1128
	flw		f0, 0(x5)	# 1128
	lui		x5, 3	# 1128
	ori		x5, x0, 3	# 1128
	mul		x5, x5, 8	# 1128
	lw		x6, 4(x2)	# 1128
	add		x5, x6, x5	# 1128
	flw		f1, 0(x5)	# 1128
	fmul	f0, f0, f1	# 1128
	mul		x4, x4, 8	# 1128
	lw		x5, 0(x2)	# 1128
	add		x4, x5, x4	# 1128
	fsw		f0, 0(x4)	# 1128
	lui		x10, 1	# 1129
	ori		x10, x0, 1	# 1129
	jalr	x0, x1, 0
beq.9729:
	lui		x10, 0	# 1130
	ori		x10, x0, 0	# 1130
	jalr	x0, x1, 0
solver_second_fast2.2723:
	lw		x7, 4(x27)	# 1136
	lui		x8, 0	# 1136
	ori		x8, x0, 0	# 1136
	mul		x8, x8, 8	# 1136
	add		x8, x5, x8	# 1136
	flw		f3, 0(x8)	# 1136
	sw		x7, 0(x2)	# 1137
	sw		x4, 4(x2)	# 1137
	fsw		f3, 8(x2)	# 1137
	sw		x6, 16(x2)	# 1137
	fsw		f2, 24(x2)	# 1137
	fsw		f1, 32(x2)	# 1137
	fsw		f0, 40(x2)	# 1137
	sw		x5, 48(x2)	# 1137
	fsub	f0, f0, f0
	fadd	f0, f0, f3
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fiszero.2443
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1137
	lui		x5, 0	# 1137
	ori		x5, x0, 0	# 1137
	beq		x4, x5, beq.9731	# 1137
	lui		x10, 0	# 1138
	ori		x10, x0, 0	# 1138
	jalr	x0, x1, 0
beq.9731:
	lui		x4, 1	# 1140
	ori		x4, x0, 1	# 1140
	mul		x4, x4, 8	# 1140
	lw		x5, 48(x2)	# 1140
	add		x4, x5, x4	# 1140
	flw		f0, 0(x4)	# 1140
	flw		f1, 40(x2)	# 1140
	fmul	f0, f0, f1	# 1140
	lui		x4, 2	# 1140
	ori		x4, x0, 2	# 1140
	mul		x4, x4, 8	# 1140
	add		x4, x5, x4	# 1140
	flw		f1, 0(x4)	# 1140
	flw		f2, 32(x2)	# 1140
	fmul	f1, f1, f2	# 1140
	fadd	f0, f0, f1	# 1140
	lui		x4, 3	# 1140
	ori		x4, x0, 3	# 1140
	mul		x4, x4, 8	# 1140
	add		x4, x5, x4	# 1140
	flw		f1, 0(x4)	# 1140
	flw		f2, 24(x2)	# 1140
	fmul	f1, f1, f2	# 1140
	fadd	f0, f0, f1	# 1140
	lui		x4, 3	# 1141
	ori		x4, x0, 3	# 1141
	mul		x4, x4, 8	# 1141
	lw		x6, 16(x2)	# 1141
	add		x4, x6, x4	# 1141
	flw		f1, 0(x4)	# 1141
	fsw		f0, 56(x2)	# 1142
	fsw		f1, 64(x2)	# 1142
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fsqr.2458
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1142
	fadd	f0, f0, f10	# 1142
	flw		f1, 64(x2)	# 1142
	flw		f2, 8(x2)	# 1142
	fmul	f1, f2, f1	# 1142
	fsub	f0, f0, f1	# 1142
	fsw		f0, 72(x2)	# 1143
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fispos.2445
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 1143
	lui		x5, 0	# 1143
	ori		x5, x0, 0	# 1143
	beq		x4, x5, beq.9733	# 1143
	lw		x4, 4(x2)	# 1144
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, o_isinvert.2561
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 1144
	lui		x5, 0	# 1144
	ori		x5, x0, 0	# 1144
	beq		x4, x5, beq.9734	# 1144
	lui		x4, 0	# 1145
	ori		x4, x0, 0	# 1145
	flw		f0, 72(x2)	# 1145
	sw		x4, 80(x2)	# 1145
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, min_caml_sqrt
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1145
	fadd	f0, f0, f10	# 1145
	flw		f1, 56(x2)	# 1145
	fadd	f0, f1, f0	# 1145
	lui		x4, 4	# 1145
	ori		x4, x0, 4	# 1145
	mul		x4, x4, 8	# 1145
	lw		x5, 48(x2)	# 1145
	add		x4, x5, x4	# 1145
	flw		f1, 0(x4)	# 1145
	fmul	f0, f0, f1	# 1145
	lw		x4, 80(x2)	# 1145
	mul		x4, x4, 8	# 1145
	lw		x5, 0(x2)	# 1145
	add		x4, x5, x4	# 1145
	fsw		f0, 0(x4)	# 1145
	jal		x0, beq_cont.9735	# 1144
beq.9734:
	lui		x4, 0	# 1147
	ori		x4, x0, 0	# 1147
	flw		f0, 72(x2)	# 1147
	sw		x4, 84(x2)	# 1147
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, min_caml_sqrt
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 1147
	fadd	f0, f0, f10	# 1147
	flw		f1, 56(x2)	# 1147
	fsub	f0, f1, f0	# 1147
	lui		x4, 4	# 1147
	ori		x4, x0, 4	# 1147
	mul		x4, x4, 8	# 1147
	lw		x5, 48(x2)	# 1147
	add		x4, x5, x4	# 1147
	flw		f1, 0(x4)	# 1147
	fmul	f0, f0, f1	# 1147
	lw		x4, 84(x2)	# 1147
	mul		x4, x4, 8	# 1147
	lw		x5, 0(x2)	# 1147
	add		x4, x5, x4	# 1147
	fsw		f0, 0(x4)	# 1147
beq_cont.9735:
	lui		x10, 1	# 1148
	ori		x10, x0, 1	# 1148
	jalr	x0, x1, 0
beq.9733:
	lui		x10, 0	# 1149
	ori		x10, x0, 0	# 1149
	jalr	x0, x1, 0
solver_fast2.2730:
	lw		x6, 16(x27)	# 1154
	lw		x7, 12(x27)	# 1154
	lw		x8, 8(x27)	# 1154
	lw		x9, 4(x27)	# 1154
	mul		x11, x4, 4	# 1154
	add		x9, x9, x11	# 1154
	lw		x9, 0(x9)	# 1154
	sw		x7, 0(x2)	# 1155
	sw		x6, 4(x2)	# 1155
	sw		x8, 8(x2)	# 1155
	sw		x9, 12(x2)	# 1155
	sw		x4, 16(x2)	# 1155
	sw		x5, 20(x2)	# 1155
	addi	x4, x9, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, o_param_ctbl.2595
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1155
	lui		x5, 0	# 1156
	ori		x5, x0, 0	# 1156
	mul		x5, x5, 8	# 1156
	add		x5, x4, x5	# 1156
	flw		f0, 0(x5)	# 1156
	lui		x5, 1	# 1157
	ori		x5, x0, 1	# 1157
	mul		x5, x5, 8	# 1157
	add		x5, x4, x5	# 1157
	flw		f1, 0(x5)	# 1157
	lui		x5, 2	# 1158
	ori		x5, x0, 2	# 1158
	mul		x5, x5, 8	# 1158
	add		x5, x4, x5	# 1158
	flw		f2, 0(x5)	# 1158
	lw		x5, 20(x2)	# 1159
	sw		x4, 24(x2)	# 1159
	fsw		f2, 32(x2)	# 1159
	fsw		f1, 40(x2)	# 1159
	fsw		f0, 48(x2)	# 1159
	addi	x4, x5, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, d_const.2618
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 1159
	lw		x5, 16(x2)	# 1160
	mul		x5, x5, 4	# 1160
	add		x4, x4, x5	# 1160
	lw		x4, 0(x4)	# 1160
	lw		x5, 12(x2)	# 1161
	sw		x4, 56(x2)	# 1161
	addi	x4, x5, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_form.2557
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 1161
	lui		x5, 1	# 1162
	ori		x5, x0, 1	# 1162
	beq		x4, x5, beq.9737	# 1162
	lui		x5, 2	# 1164
	ori		x5, x0, 2	# 1164
	beq		x4, x5, beq.9738	# 1164
	flw		f0, 48(x2)	# 1167
	flw		f1, 40(x2)	# 1167
	flw		f2, 32(x2)	# 1167
	lw		x4, 12(x2)	# 1167
	lw		x5, 56(x2)	# 1167
	lw		x6, 24(x2)	# 1167
	lw		x27, 0(x2)	# 1167
	lw		x31, 0(x27)	# 1167
	jalr	x0, x31, 0	# 1167
beq.9738:
	flw		f0, 48(x2)	# 1165
	flw		f1, 40(x2)	# 1165
	flw		f2, 32(x2)	# 1165
	lw		x4, 12(x2)	# 1165
	lw		x5, 56(x2)	# 1165
	lw		x6, 24(x2)	# 1165
	lw		x27, 4(x2)	# 1165
	lw		x31, 0(x27)	# 1165
	jalr	x0, x31, 0	# 1165
beq.9737:
	lw		x4, 20(x2)	# 1163
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, d_vec.2616
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x5, x10, 0	# 1163
	flw		f0, 48(x2)	# 1163
	flw		f1, 40(x2)	# 1163
	flw		f2, 32(x2)	# 1163
	lw		x4, 12(x2)	# 1163
	lw		x6, 56(x2)	# 1163
	lw		x27, 8(x2)	# 1163
	lw		x31, 0(x27)	# 1163
	jalr	x0, x31, 0	# 1163
setup_rect_table.2733:
	lui		x6, 6	# 1176
	ori		x6, x0, 6	# 1176
	lui		x7, %hi(l.6055)	# 1176
	ori		x7, %lo(l.6055)	# 1176
	flw		f0, 0(x7)	# 1176
	sw		x5, 0(x2)	# 1176
	sw		x4, 4(x2)	# 1176
	addi	x4, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 1176
	lui		x5, 0	# 1178
	ori		x5, x0, 0	# 1178
	mul		x5, x5, 8	# 1178
	lw		x6, 4(x2)	# 1178
	add		x5, x6, x5	# 1178
	flw		f0, 0(x5)	# 1178
	sw		x4, 8(x2)	# 1178
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, fiszero.2443
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 1178
	lui		x5, 0	# 1178
	ori		x5, x0, 0	# 1178
	beq		x4, x5, beq.9739	# 1178
	lui		x4, 1	# 1179
	ori		x4, x0, 1	# 1179
	lui		x5, %hi(l.6055)	# 1179
	ori		x5, %lo(l.6055)	# 1179
	flw		f0, 0(x5)	# 1179
	mul		x4, x4, 8	# 1179
	lw		x5, 8(x2)	# 1179
	add		x4, x5, x4	# 1179
	fsw		f0, 0(x4)	# 1179
	jal		x0, beq_cont.9740	# 1178
beq.9739:
	lui		x4, 0	# 1182
	ori		x4, x0, 0	# 1182
	lw		x5, 0(x2)	# 1182
	sw		x4, 12(x2)	# 1182
	addi	x4, x5, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_isinvert.2561
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1182
	lui		x5, 0	# 1182
	ori		x5, x0, 0	# 1182
	mul		x5, x5, 8	# 1182
	lw		x6, 4(x2)	# 1182
	add		x5, x6, x5	# 1182
	flw		f0, 0(x5)	# 1182
	sw		x4, 16(x2)	# 1182
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fisneg.2447
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x5, x10, 0	# 1182
	lw		x4, 16(x2)	# 1182
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, xor.2506
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1182
	lw		x5, 0(x2)	# 1182
	sw		x4, 20(x2)	# 1182
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, o_param_a.2565
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 1182
	fadd	f0, f0, f10	# 1182
	lw		x4, 20(x2)	# 1182
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, fneg_cond.2511
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 1182
	fadd	f0, f0, f10	# 1182
	lw		x4, 12(x2)	# 1182
	mul		x4, x4, 8	# 1182
	lw		x5, 8(x2)	# 1182
	add		x4, x5, x4	# 1182
	fsw		f0, 0(x4)	# 1182
	lui		x4, 1	# 1184
	ori		x4, x0, 1	# 1184
	lui		x6, %hi(l.6062)	# 1184
	ori		x6, %lo(l.6062)	# 1184
	flw		f0, 0(x6)	# 1184
	lui		x6, 0	# 1184
	ori		x6, x0, 0	# 1184
	mul		x6, x6, 8	# 1184
	lw		x7, 4(x2)	# 1184
	add		x6, x7, x6	# 1184
	flw		f1, 0(x6)	# 1184
	fdiv	f0, f0, f1	# 1184
	mul		x4, x4, 8	# 1184
	add		x4, x5, x4	# 1184
	fsw		f0, 0(x4)	# 1184
beq_cont.9740:
	lui		x4, 1	# 1186
	ori		x4, x0, 1	# 1186
	mul		x4, x4, 8	# 1186
	lw		x6, 4(x2)	# 1186
	add		x4, x6, x4	# 1186
	flw		f0, 0(x4)	# 1186
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, fiszero.2443
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1186
	lui		x5, 0	# 1186
	ori		x5, x0, 0	# 1186
	beq		x4, x5, beq.9741	# 1186
	lui		x4, 3	# 1187
	ori		x4, x0, 3	# 1187
	lui		x5, %hi(l.6055)	# 1187
	ori		x5, %lo(l.6055)	# 1187
	flw		f0, 0(x5)	# 1187
	mul		x4, x4, 8	# 1187
	lw		x5, 8(x2)	# 1187
	add		x4, x5, x4	# 1187
	fsw		f0, 0(x4)	# 1187
	jal		x0, beq_cont.9742	# 1186
beq.9741:
	lui		x4, 2	# 1189
	ori		x4, x0, 2	# 1189
	lw		x5, 0(x2)	# 1189
	sw		x4, 24(x2)	# 1189
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, o_isinvert.2561
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1189
	lui		x5, 1	# 1189
	ori		x5, x0, 1	# 1189
	mul		x5, x5, 8	# 1189
	lw		x6, 4(x2)	# 1189
	add		x5, x6, x5	# 1189
	flw		f0, 0(x5)	# 1189
	sw		x4, 28(x2)	# 1189
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fisneg.2447
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x5, x10, 0	# 1189
	lw		x4, 28(x2)	# 1189
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, xor.2506
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1189
	lw		x5, 0(x2)	# 1189
	sw		x4, 32(x2)	# 1189
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_param_b.2567
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1189
	fadd	f0, f0, f10	# 1189
	lw		x4, 32(x2)	# 1189
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fneg_cond.2511
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1189
	fadd	f0, f0, f10	# 1189
	lw		x4, 24(x2)	# 1189
	mul		x4, x4, 8	# 1189
	lw		x5, 8(x2)	# 1189
	add		x4, x5, x4	# 1189
	fsw		f0, 0(x4)	# 1189
	lui		x4, 3	# 1190
	ori		x4, x0, 3	# 1190
	lui		x6, %hi(l.6062)	# 1190
	ori		x6, %lo(l.6062)	# 1190
	flw		f0, 0(x6)	# 1190
	lui		x6, 1	# 1190
	ori		x6, x0, 1	# 1190
	mul		x6, x6, 8	# 1190
	lw		x7, 4(x2)	# 1190
	add		x6, x7, x6	# 1190
	flw		f1, 0(x6)	# 1190
	fdiv	f0, f0, f1	# 1190
	mul		x4, x4, 8	# 1190
	add		x4, x5, x4	# 1190
	fsw		f0, 0(x4)	# 1190
beq_cont.9742:
	lui		x4, 2	# 1192
	ori		x4, x0, 2	# 1192
	mul		x4, x4, 8	# 1192
	lw		x6, 4(x2)	# 1192
	add		x4, x6, x4	# 1192
	flw		f0, 0(x4)	# 1192
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fiszero.2443
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1192
	lui		x5, 0	# 1192
	ori		x5, x0, 0	# 1192
	beq		x4, x5, beq.9743	# 1192
	lui		x4, 5	# 1193
	ori		x4, x0, 5	# 1193
	lui		x5, %hi(l.6055)	# 1193
	ori		x5, %lo(l.6055)	# 1193
	flw		f0, 0(x5)	# 1193
	mul		x4, x4, 8	# 1193
	lw		x5, 8(x2)	# 1193
	add		x4, x5, x4	# 1193
	fsw		f0, 0(x4)	# 1193
	jal		x0, beq_cont.9744	# 1192
beq.9743:
	lui		x4, 4	# 1195
	ori		x4, x0, 4	# 1195
	lw		x5, 0(x2)	# 1195
	sw		x4, 36(x2)	# 1195
	addi	x4, x5, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_isinvert.2561
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 1195
	lui		x5, 2	# 1195
	ori		x5, x0, 2	# 1195
	mul		x5, x5, 8	# 1195
	lw		x6, 4(x2)	# 1195
	add		x5, x6, x5	# 1195
	flw		f0, 0(x5)	# 1195
	sw		x4, 40(x2)	# 1195
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, fisneg.2447
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x5, x10, 0	# 1195
	lw		x4, 40(x2)	# 1195
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, xor.2506
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 1195
	lw		x5, 0(x2)	# 1195
	sw		x4, 44(x2)	# 1195
	addi	x4, x5, 0
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, o_param_c.2569
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 1195
	fadd	f0, f0, f10	# 1195
	lw		x4, 44(x2)	# 1195
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fneg_cond.2511
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 1195
	fadd	f0, f0, f10	# 1195
	lw		x4, 36(x2)	# 1195
	mul		x4, x4, 8	# 1195
	lw		x5, 8(x2)	# 1195
	add		x4, x5, x4	# 1195
	fsw		f0, 0(x4)	# 1195
	lui		x4, 5	# 1196
	ori		x4, x0, 5	# 1196
	lui		x6, %hi(l.6062)	# 1196
	ori		x6, %lo(l.6062)	# 1196
	flw		f0, 0(x6)	# 1196
	lui		x6, 2	# 1196
	ori		x6, x0, 2	# 1196
	mul		x6, x6, 8	# 1196
	lw		x7, 4(x2)	# 1196
	add		x6, x7, x6	# 1196
	flw		f1, 0(x6)	# 1196
	fdiv	f0, f0, f1	# 1196
	mul		x4, x4, 8	# 1196
	add		x4, x5, x4	# 1196
	fsw		f0, 0(x4)	# 1196
beq_cont.9744:
	addi	x10, x5, 0	# 1198
	jalr	x0, x1, 0
setup_surface_table.2736:
	lui		x6, 4	# 1203
	ori		x6, x0, 4	# 1203
	lui		x7, %hi(l.6055)	# 1203
	ori		x7, %lo(l.6055)	# 1203
	flw		f0, 0(x7)	# 1203
	sw		x5, 0(x2)	# 1203
	sw		x4, 4(x2)	# 1203
	addi	x4, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 1203
	lui		x5, 0	# 1205
	ori		x5, x0, 0	# 1205
	mul		x5, x5, 8	# 1205
	lw		x6, 4(x2)	# 1205
	add		x5, x6, x5	# 1205
	flw		f0, 0(x5)	# 1205
	lw		x5, 0(x2)	# 1205
	sw		x4, 8(x2)	# 1205
	fsw		f0, 16(x2)	# 1205
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, o_param_a.2565
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 1205
	fadd	f0, f0, f10	# 1205
	flw		f1, 16(x2)	# 1205
	fmul	f0, f1, f0	# 1205
	lui		x4, 1	# 1205
	ori		x4, x0, 1	# 1205
	mul		x4, x4, 8	# 1205
	lw		x5, 4(x2)	# 1205
	add		x4, x5, x4	# 1205
	flw		f1, 0(x4)	# 1205
	lw		x4, 0(x2)	# 1205
	fsw		f0, 24(x2)	# 1205
	fsw		f1, 32(x2)	# 1205
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_param_b.2567
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 1205
	fadd	f0, f0, f10	# 1205
	flw		f1, 32(x2)	# 1205
	fmul	f0, f1, f0	# 1205
	flw		f1, 24(x2)	# 1205
	fadd	f0, f1, f0	# 1205
	lui		x4, 2	# 1205
	ori		x4, x0, 2	# 1205
	mul		x4, x4, 8	# 1205
	lw		x5, 4(x2)	# 1205
	add		x4, x5, x4	# 1205
	flw		f1, 0(x4)	# 1205
	lw		x4, 0(x2)	# 1205
	fsw		f0, 40(x2)	# 1205
	fsw		f1, 48(x2)	# 1205
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_param_c.2569
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1205
	fadd	f0, f0, f10	# 1205
	flw		f1, 48(x2)	# 1205
	fmul	f0, f1, f0	# 1205
	flw		f1, 40(x2)	# 1205
	fadd	f0, f1, f0	# 1205
	fsw		f0, 56(x2)	# 1207
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fispos.2445
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 1207
	lui		x5, 0	# 1207
	ori		x5, x0, 0	# 1207
	beq		x4, x5, beq.9746	# 1207
	lui		x4, 0	# 1209
	ori		x4, x0, 0	# 1209
	lui		x5, %hi(l.6068)	# 1209
	ori		x5, %lo(l.6068)	# 1209
	flw		f0, 0(x5)	# 1209
	flw		f1, 56(x2)	# 1209
	fdiv	f0, f0, f1	# 1209
	mul		x4, x4, 8	# 1209
	lw		x5, 8(x2)	# 1209
	add		x4, x5, x4	# 1209
	fsw		f0, 0(x4)	# 1209
	lui		x4, 1	# 1211
	ori		x4, x0, 1	# 1211
	lw		x6, 0(x2)	# 1211
	sw		x4, 64(x2)	# 1211
	addi	x4, x6, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, o_param_a.2565
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1211
	fadd	f0, f0, f10	# 1211
	flw		f1, 56(x2)	# 1211
	fdiv	f0, f0, f1	# 1211
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fneg.2449
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1211
	fadd	f0, f0, f10	# 1211
	lw		x4, 64(x2)	# 1211
	mul		x4, x4, 8	# 1211
	lw		x5, 8(x2)	# 1211
	add		x4, x5, x4	# 1211
	fsw		f0, 0(x4)	# 1211
	lui		x4, 2	# 1212
	ori		x4, x0, 2	# 1212
	lw		x6, 0(x2)	# 1212
	sw		x4, 68(x2)	# 1212
	addi	x4, x6, 0
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_b.2567
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1212
	fadd	f0, f0, f10	# 1212
	flw		f1, 56(x2)	# 1212
	fdiv	f0, f0, f1	# 1212
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fneg.2449
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1212
	fadd	f0, f0, f10	# 1212
	lw		x4, 68(x2)	# 1212
	mul		x4, x4, 8	# 1212
	lw		x5, 8(x2)	# 1212
	add		x4, x5, x4	# 1212
	fsw		f0, 0(x4)	# 1212
	lui		x4, 3	# 1213
	ori		x4, x0, 3	# 1213
	lw		x6, 0(x2)	# 1213
	sw		x4, 72(x2)	# 1213
	addi	x4, x6, 0
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_c.2569
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1213
	fadd	f0, f0, f10	# 1213
	flw		f1, 56(x2)	# 1213
	fdiv	f0, f0, f1	# 1213
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fneg.2449
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1213
	fadd	f0, f0, f10	# 1213
	lw		x4, 72(x2)	# 1213
	mul		x4, x4, 8	# 1213
	lw		x5, 8(x2)	# 1213
	add		x4, x5, x4	# 1213
	fsw		f0, 0(x4)	# 1213
	jal		x0, beq_cont.9747	# 1207
beq.9746:
	lui		x4, 0	# 1215
	ori		x4, x0, 0	# 1215
	lui		x5, %hi(l.6055)	# 1215
	ori		x5, %lo(l.6055)	# 1215
	flw		f0, 0(x5)	# 1215
	mul		x4, x4, 8	# 1215
	lw		x5, 8(x2)	# 1215
	add		x4, x5, x4	# 1215
	fsw		f0, 0(x4)	# 1215
beq_cont.9747:
	addi	x10, x5, 0	# 1216
	jalr	x0, x1, 0
setup_second_table.2739:
	lui		x6, 5	# 1222
	ori		x6, x0, 5	# 1222
	lui		x7, %hi(l.6055)	# 1222
	ori		x7, %lo(l.6055)	# 1222
	flw		f0, 0(x7)	# 1222
	sw		x5, 0(x2)	# 1222
	sw		x4, 4(x2)	# 1222
	addi	x4, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 1222
	lui		x5, 0	# 1224
	ori		x5, x0, 0	# 1224
	mul		x5, x5, 8	# 1224
	lw		x6, 4(x2)	# 1224
	add		x5, x6, x5	# 1224
	flw		f0, 0(x5)	# 1224
	lui		x5, 1	# 1224
	ori		x5, x0, 1	# 1224
	mul		x5, x5, 8	# 1224
	add		x5, x6, x5	# 1224
	flw		f1, 0(x5)	# 1224
	lui		x5, 2	# 1224
	ori		x5, x0, 2	# 1224
	mul		x5, x5, 8	# 1224
	add		x5, x6, x5	# 1224
	flw		f2, 0(x5)	# 1224
	lw		x5, 0(x2)	# 1224
	sw		x4, 8(x2)	# 1224
	addi	x4, x5, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, quadratic.2670
	addi	x2, x2, -16
	lw		x1, 12(x2)
	fsub	f0, f0, f0	# 1224
	fadd	f0, f0, f10	# 1224
	lui		x4, 0	# 1225
	ori		x4, x0, 0	# 1225
	mul		x4, x4, 8	# 1225
	lw		x5, 4(x2)	# 1225
	add		x4, x5, x4	# 1225
	flw		f1, 0(x4)	# 1225
	lw		x4, 0(x2)	# 1225
	fsw		f0, 16(x2)	# 1225
	fsw		f1, 24(x2)	# 1225
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_param_a.2565
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1225
	fadd	f0, f0, f10	# 1225
	flw		f1, 24(x2)	# 1225
	fmul	f0, f1, f0	# 1225
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fneg.2449
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1225
	fadd	f0, f0, f10	# 1225
	lui		x4, 1	# 1226
	ori		x4, x0, 1	# 1226
	mul		x4, x4, 8	# 1226
	lw		x5, 4(x2)	# 1226
	add		x4, x5, x4	# 1226
	flw		f1, 0(x4)	# 1226
	lw		x4, 0(x2)	# 1226
	fsw		f0, 32(x2)	# 1226
	fsw		f1, 40(x2)	# 1226
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, o_param_b.2567
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 1226
	fadd	f0, f0, f10	# 1226
	flw		f1, 40(x2)	# 1226
	fmul	f0, f1, f0	# 1226
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fneg.2449
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 1226
	fadd	f0, f0, f10	# 1226
	lui		x4, 2	# 1227
	ori		x4, x0, 2	# 1227
	mul		x4, x4, 8	# 1227
	lw		x5, 4(x2)	# 1227
	add		x4, x5, x4	# 1227
	flw		f1, 0(x4)	# 1227
	lw		x4, 0(x2)	# 1227
	fsw		f0, 48(x2)	# 1227
	fsw		f1, 56(x2)	# 1227
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, o_param_c.2569
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1227
	fadd	f0, f0, f10	# 1227
	flw		f1, 56(x2)	# 1227
	fmul	f0, f1, f0	# 1227
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fneg.2449
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1227
	fadd	f0, f0, f10	# 1227
	lui		x4, 0	# 1229
	ori		x4, x0, 0	# 1229
	mul		x4, x4, 8	# 1229
	lw		x5, 8(x2)	# 1229
	add		x4, x5, x4	# 1229
	flw		f1, 16(x2)	# 1229
	fsw		f1, 0(x4)	# 1229
	lw		x4, 0(x2)	# 1233
	fsw		f0, 64(x2)	# 1233
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_isrot.2563
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1233
	lui		x5, 0	# 1233
	ori		x5, x0, 0	# 1233
	beq		x4, x5, beq.9749	# 1233
	lui		x4, 1	# 1234
	ori		x4, x0, 1	# 1234
	lui		x5, 2	# 1234
	ori		x5, x0, 2	# 1234
	mul		x5, x5, 8	# 1234
	lw		x6, 4(x2)	# 1234
	add		x5, x6, x5	# 1234
	flw		f0, 0(x5)	# 1234
	lw		x5, 0(x2)	# 1234
	sw		x4, 72(x2)	# 1234
	fsw		f0, 80(x2)	# 1234
	addi	x4, x5, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, o_param_r2.2591
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 1234
	fadd	f0, f0, f10	# 1234
	flw		f1, 80(x2)	# 1234
	fmul	f0, f1, f0	# 1234
	lui		x4, 1	# 1234
	ori		x4, x0, 1	# 1234
	mul		x4, x4, 8	# 1234
	lw		x5, 4(x2)	# 1234
	add		x4, x5, x4	# 1234
	flw		f1, 0(x4)	# 1234
	lw		x4, 0(x2)	# 1234
	fsw		f0, 88(x2)	# 1234
	fsw		f1, 96(x2)	# 1234
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, o_param_r3.2593
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1234
	fadd	f0, f0, f10	# 1234
	flw		f1, 96(x2)	# 1234
	fmul	f0, f1, f0	# 1234
	flw		f1, 88(x2)	# 1234
	fadd	f0, f1, f0	# 1234
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, fhalf.2456
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1234
	fadd	f0, f0, f10	# 1234
	flw		f1, 32(x2)	# 1234
	fsub	f0, f1, f0	# 1234
	lw		x4, 72(x2)	# 1234
	mul		x4, x4, 8	# 1234
	lw		x5, 8(x2)	# 1234
	add		x4, x5, x4	# 1234
	fsw		f0, 0(x4)	# 1234
	lui		x4, 2	# 1235
	ori		x4, x0, 2	# 1235
	lui		x6, 2	# 1235
	ori		x6, x0, 2	# 1235
	mul		x6, x6, 8	# 1235
	lw		x7, 4(x2)	# 1235
	add		x6, x7, x6	# 1235
	flw		f0, 0(x6)	# 1235
	lw		x6, 0(x2)	# 1235
	sw		x4, 104(x2)	# 1235
	fsw		f0, 112(x2)	# 1235
	addi	x4, x6, 0
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, o_param_r1.2589
	addi	x2, x2, -128
	lw		x1, 124(x2)
	fsub	f0, f0, f0	# 1235
	fadd	f0, f0, f10	# 1235
	flw		f1, 112(x2)	# 1235
	fmul	f0, f1, f0	# 1235
	lui		x4, 0	# 1235
	ori		x4, x0, 0	# 1235
	mul		x4, x4, 8	# 1235
	lw		x5, 4(x2)	# 1235
	add		x4, x5, x4	# 1235
	flw		f1, 0(x4)	# 1235
	lw		x4, 0(x2)	# 1235
	fsw		f0, 120(x2)	# 1235
	fsw		f1, 128(x2)	# 1235
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, o_param_r3.2593
	addi	x2, x2, -144
	lw		x1, 140(x2)
	fsub	f0, f0, f0	# 1235
	fadd	f0, f0, f10	# 1235
	flw		f1, 128(x2)	# 1235
	fmul	f0, f1, f0	# 1235
	flw		f1, 120(x2)	# 1235
	fadd	f0, f1, f0	# 1235
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, fhalf.2456
	addi	x2, x2, -144
	lw		x1, 140(x2)
	fsub	f0, f0, f0	# 1235
	fadd	f0, f0, f10	# 1235
	flw		f1, 48(x2)	# 1235
	fsub	f0, f1, f0	# 1235
	lw		x4, 104(x2)	# 1235
	mul		x4, x4, 8	# 1235
	lw		x5, 8(x2)	# 1235
	add		x4, x5, x4	# 1235
	fsw		f0, 0(x4)	# 1235
	lui		x4, 3	# 1236
	ori		x4, x0, 3	# 1236
	lui		x6, 1	# 1236
	ori		x6, x0, 1	# 1236
	mul		x6, x6, 8	# 1236
	lw		x7, 4(x2)	# 1236
	add		x6, x7, x6	# 1236
	flw		f0, 0(x6)	# 1236
	lw		x6, 0(x2)	# 1236
	sw		x4, 136(x2)	# 1236
	fsw		f0, 144(x2)	# 1236
	addi	x4, x6, 0
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, o_param_r1.2589
	addi	x2, x2, -160
	lw		x1, 156(x2)
	fsub	f0, f0, f0	# 1236
	fadd	f0, f0, f10	# 1236
	flw		f1, 144(x2)	# 1236
	fmul	f0, f1, f0	# 1236
	lui		x4, 0	# 1236
	ori		x4, x0, 0	# 1236
	mul		x4, x4, 8	# 1236
	lw		x5, 4(x2)	# 1236
	add		x4, x5, x4	# 1236
	flw		f1, 0(x4)	# 1236
	lw		x4, 0(x2)	# 1236
	fsw		f0, 152(x2)	# 1236
	fsw		f1, 160(x2)	# 1236
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, o_param_r2.2591
	addi	x2, x2, -176
	lw		x1, 172(x2)
	fsub	f0, f0, f0	# 1236
	fadd	f0, f0, f10	# 1236
	flw		f1, 160(x2)	# 1236
	fmul	f0, f1, f0	# 1236
	flw		f1, 152(x2)	# 1236
	fadd	f0, f1, f0	# 1236
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, fhalf.2456
	addi	x2, x2, -176
	lw		x1, 172(x2)
	fsub	f0, f0, f0	# 1236
	fadd	f0, f0, f10	# 1236
	flw		f1, 64(x2)	# 1236
	fsub	f0, f1, f0	# 1236
	lw		x4, 136(x2)	# 1236
	mul		x4, x4, 8	# 1236
	lw		x5, 8(x2)	# 1236
	add		x4, x5, x4	# 1236
	fsw		f0, 0(x4)	# 1236
	jal		x0, beq_cont.9750	# 1233
beq.9749:
	lui		x4, 1	# 1238
	ori		x4, x0, 1	# 1238
	mul		x4, x4, 8	# 1238
	lw		x5, 8(x2)	# 1238
	add		x4, x5, x4	# 1238
	flw		f0, 32(x2)	# 1238
	fsw		f0, 0(x4)	# 1238
	lui		x4, 2	# 1239
	ori		x4, x0, 2	# 1239
	mul		x4, x4, 8	# 1239
	add		x4, x5, x4	# 1239
	flw		f0, 48(x2)	# 1239
	fsw		f0, 0(x4)	# 1239
	lui		x4, 3	# 1240
	ori		x4, x0, 3	# 1240
	mul		x4, x4, 8	# 1240
	add		x4, x5, x4	# 1240
	flw		f0, 64(x2)	# 1240
	fsw		f0, 0(x4)	# 1240
beq_cont.9750:
	flw		f0, 16(x2)	# 1242
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, fiszero.2443
	addi	x2, x2, -176
	lw		x1, 172(x2)
	addi	x4, x10, 0	# 1242
	lui		x5, 0	# 1242
	ori		x5, x0, 0	# 1242
	beq		x4, x5, beq.9754	# 1242
	jal		x0, beq_cont.9755	# 1242
beq.9754:
	lui		x4, 4	# 1243
	ori		x4, x0, 4	# 1243
	lui		x5, %hi(l.6062)	# 1243
	ori		x5, %lo(l.6062)	# 1243
	flw		f0, 0(x5)	# 1243
	flw		f1, 16(x2)	# 1243
	fdiv	f0, f0, f1	# 1243
	mul		x4, x4, 8	# 1243
	lw		x5, 8(x2)	# 1243
	add		x4, x5, x4	# 1243
	fsw		f0, 0(x4)	# 1243
beq_cont.9755:
	lw		x4, 8(x2)	# 1245
	addi	x10, x4, 0	# 1245
	jalr	x0, x1, 0
iter_setup_dirvec_constants.2742:
	lw		x6, 4(x27)	# 1251
	lui		x7, 0	# 1251
	ori		x7, x0, 0	# 1251
	ble		x7, x5, ble.9756	# 1251
	jalr	x0, x1, 0
ble.9756:
	mul		x7, x5, 4	# 1252
	add		x6, x6, x7	# 1252
	lw		x6, 0(x6)	# 1252
	sw		x27, 0(x2)	# 1253
	sw		x5, 4(x2)	# 1253
	sw		x6, 8(x2)	# 1253
	sw		x4, 12(x2)	# 1253
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, d_const.2618
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1253
	lw		x5, 12(x2)	# 1254
	sw		x4, 16(x2)	# 1254
	addi	x4, x5, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, d_vec.2616
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1254
	lw		x5, 8(x2)	# 1255
	sw		x4, 20(x2)	# 1255
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, o_form.2557
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1255
	lui		x5, 1	# 1256
	ori		x5, x0, 1	# 1256
	beq		x4, x5, beq.9758	# 1256
	lui		x5, 2	# 1258
	ori		x5, x0, 2	# 1258
	beq		x4, x5, beq.9760	# 1258
	lw		x4, 20(x2)	# 1261
	lw		x5, 8(x2)	# 1261
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, setup_second_table.2739
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1261
	lw		x5, 4(x2)	# 1261
	mul		x6, x5, 4	# 1261
	lw		x7, 16(x2)	# 1261
	add		x6, x7, x6	# 1261
	sw		x4, 0(x6)	# 1261
	jal		x0, beq_cont.9761	# 1258
beq.9760:
	lw		x4, 20(x2)	# 1259
	lw		x5, 8(x2)	# 1259
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, setup_surface_table.2736
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1259
	lw		x5, 4(x2)	# 1259
	mul		x6, x5, 4	# 1259
	lw		x7, 16(x2)	# 1259
	add		x6, x7, x6	# 1259
	sw		x4, 0(x6)	# 1259
beq_cont.9761:
	jal		x0, beq_cont.9759	# 1256
beq.9758:
	lw		x4, 20(x2)	# 1257
	lw		x5, 8(x2)	# 1257
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, setup_rect_table.2733
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1257
	lw		x5, 4(x2)	# 1257
	mul		x6, x5, 4	# 1257
	lw		x7, 16(x2)	# 1257
	add		x6, x7, x6	# 1257
	sw		x4, 0(x6)	# 1257
beq_cont.9759:
	lui		x4, 1	# 1263
	ori		x4, x0, 1	# 1263
	sub		x5, x5, x4	# 1263
	lw		x4, 12(x2)	# 1263
	lw		x27, 0(x2)	# 1263
	lw		x31, 0(x27)	# 1263
	jalr	x0, x31, 0	# 1263
setup_dirvec_constants.2745:
	lw		x5, 8(x27)	# 1268
	lw		x27, 4(x27)	# 1268
	lui		x6, 0	# 1268
	ori		x6, x0, 0	# 1268
	mul		x6, x6, 4	# 1268
	add		x5, x5, x6	# 1268
	lw		x5, 0(x5)	# 1268
	lui		x6, 1	# 1268
	ori		x6, x0, 1	# 1268
	sub		x5, x5, x6	# 1268
	lw		x31, 0(x27)	# 1268
	jalr	x0, x31, 0	# 1268
setup_startp_constants.2747:
	lw		x6, 4(x27)	# 1276
	lui		x7, 0	# 1276
	ori		x7, x0, 0	# 1276
	ble		x7, x5, ble.9762	# 1276
	jalr	x0, x1, 0
ble.9762:
	mul		x7, x5, 4	# 1277
	add		x6, x6, x7	# 1277
	lw		x6, 0(x6)	# 1277
	sw		x27, 0(x2)	# 1278
	sw		x5, 4(x2)	# 1278
	sw		x4, 8(x2)	# 1278
	sw		x6, 12(x2)	# 1278
	addi	x4, x6, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_param_ctbl.2595
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1278
	lw		x5, 12(x2)	# 1279
	sw		x4, 16(x2)	# 1279
	addi	x4, x5, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_form.2557
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1279
	lui		x5, 0	# 1280
	ori		x5, x0, 0	# 1280
	lui		x6, 0	# 1280
	ori		x6, x0, 0	# 1280
	mul		x6, x6, 8	# 1280
	lw		x7, 8(x2)	# 1280
	add		x6, x7, x6	# 1280
	flw		f0, 0(x6)	# 1280
	lw		x6, 12(x2)	# 1280
	sw		x4, 20(x2)	# 1280
	sw		x5, 24(x2)	# 1280
	fsw		f0, 32(x2)	# 1280
	addi	x4, x6, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_param_x.2573
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 1280
	fadd	f0, f0, f10	# 1280
	flw		f1, 32(x2)	# 1280
	fsub	f0, f1, f0	# 1280
	lw		x4, 24(x2)	# 1280
	mul		x4, x4, 8	# 1280
	lw		x5, 16(x2)	# 1280
	add		x4, x5, x4	# 1280
	fsw		f0, 0(x4)	# 1280
	lui		x4, 1	# 1281
	ori		x4, x0, 1	# 1281
	lui		x6, 1	# 1281
	ori		x6, x0, 1	# 1281
	mul		x6, x6, 8	# 1281
	lw		x7, 8(x2)	# 1281
	add		x6, x7, x6	# 1281
	flw		f0, 0(x6)	# 1281
	lw		x6, 12(x2)	# 1281
	sw		x4, 40(x2)	# 1281
	fsw		f0, 48(x2)	# 1281
	addi	x4, x6, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_param_y.2575
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1281
	fadd	f0, f0, f10	# 1281
	flw		f1, 48(x2)	# 1281
	fsub	f0, f1, f0	# 1281
	lw		x4, 40(x2)	# 1281
	mul		x4, x4, 8	# 1281
	lw		x5, 16(x2)	# 1281
	add		x4, x5, x4	# 1281
	fsw		f0, 0(x4)	# 1281
	lui		x4, 2	# 1282
	ori		x4, x0, 2	# 1282
	lui		x6, 2	# 1282
	ori		x6, x0, 2	# 1282
	mul		x6, x6, 8	# 1282
	lw		x7, 8(x2)	# 1282
	add		x6, x7, x6	# 1282
	flw		f0, 0(x6)	# 1282
	lw		x6, 12(x2)	# 1282
	sw		x4, 56(x2)	# 1282
	fsw		f0, 64(x2)	# 1282
	addi	x4, x6, 0
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_z.2577
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1282
	fadd	f0, f0, f10	# 1282
	flw		f1, 64(x2)	# 1282
	fsub	f0, f1, f0	# 1282
	lw		x4, 56(x2)	# 1282
	mul		x4, x4, 8	# 1282
	lw		x5, 16(x2)	# 1282
	add		x4, x5, x4	# 1282
	fsw		f0, 0(x4)	# 1282
	lui		x4, 2	# 1283
	ori		x4, x0, 2	# 1283
	lw		x6, 20(x2)	# 1283
	beq		x6, x4, beq.9767	# 1283
	lui		x4, 2	# 1286
	ori		x4, x0, 2	# 1286
	ble		x6, x4, ble.9769	# 1286
	lui		x4, 0	# 1287
	ori		x4, x0, 0	# 1287
	mul		x4, x4, 8	# 1287
	add		x4, x5, x4	# 1287
	flw		f0, 0(x4)	# 1287
	lui		x4, 1	# 1287
	ori		x4, x0, 1	# 1287
	mul		x4, x4, 8	# 1287
	add		x4, x5, x4	# 1287
	flw		f1, 0(x4)	# 1287
	lui		x4, 2	# 1287
	ori		x4, x0, 2	# 1287
	mul		x4, x4, 8	# 1287
	add		x4, x5, x4	# 1287
	flw		f2, 0(x4)	# 1287
	lw		x4, 12(x2)	# 1287
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, quadratic.2670
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1287
	fadd	f0, f0, f10	# 1287
	lui		x4, 3	# 1288
	ori		x4, x0, 3	# 1288
	lui		x5, 3	# 1288
	ori		x5, x0, 3	# 1288
	lw		x6, 20(x2)	# 1288
	beq		x6, x5, beq.9771	# 1288
	jal		x0, beq_cont.9772	# 1288
beq.9771:
	lui		x5, %hi(l.6062)	# 1288
	ori		x5, %lo(l.6062)	# 1288
	flw		f1, 0(x5)	# 1288
	fsub	f0, f0, f1	# 1288
beq_cont.9772:
	mul		x4, x4, 8	# 1288
	lw		x5, 16(x2)	# 1288
	add		x4, x5, x4	# 1288
	fsw		f0, 0(x4)	# 1288
	jal		x0, ble_cont.9770	# 1286
ble.9769:
ble_cont.9770:
	jal		x0, beq_cont.9768	# 1283
beq.9767:
	lui		x4, 3	# 1284
	ori		x4, x0, 3	# 1284
	lw		x6, 12(x2)	# 1285
	sw		x4, 72(x2)	# 1285
	addi	x4, x6, 0
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_abc.2571
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1285
	lui		x5, 0	# 1285
	ori		x5, x0, 0	# 1285
	mul		x5, x5, 8	# 1285
	lw		x6, 16(x2)	# 1285
	add		x5, x6, x5	# 1285
	flw		f0, 0(x5)	# 1285
	lui		x5, 1	# 1285
	ori		x5, x0, 1	# 1285
	mul		x5, x5, 8	# 1285
	add		x5, x6, x5	# 1285
	flw		f1, 0(x5)	# 1285
	lui		x5, 2	# 1285
	ori		x5, x0, 2	# 1285
	mul		x5, x5, 8	# 1285
	add		x5, x6, x5	# 1285
	flw		f2, 0(x5)	# 1285
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, veciprod2.2536
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1285
	fadd	f0, f0, f10	# 1285
	lw		x4, 72(x2)	# 1284
	mul		x4, x4, 8	# 1284
	lw		x5, 16(x2)	# 1284
	add		x4, x5, x4	# 1284
	fsw		f0, 0(x4)	# 1284
beq_cont.9768:
	lui		x4, 1	# 1290
	ori		x4, x0, 1	# 1290
	lw		x5, 4(x2)	# 1290
	sub		x5, x5, x4	# 1290
	lw		x4, 8(x2)	# 1290
	lw		x27, 0(x2)	# 1290
	lw		x31, 0(x27)	# 1290
	jalr	x0, x31, 0	# 1290
setup_startp.2750:
	lw		x5, 12(x27)	# 1295
	lw		x6, 8(x27)	# 1295
	lw		x7, 4(x27)	# 1295
	sw		x4, 0(x2)	# 1295
	sw		x6, 4(x2)	# 1295
	sw		x7, 8(x2)	# 1295
	addi	x31, x5, 0
	addi	x5, x4, 0
	addi	x4, x31, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, veccpy.2527
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 0	# 1296
	ori		x4, x0, 0	# 1296
	mul		x4, x4, 4	# 1296
	lw		x5, 8(x2)	# 1296
	add		x4, x5, x4	# 1296
	lw		x4, 0(x4)	# 1296
	lui		x5, 1	# 1296
	ori		x5, x0, 1	# 1296
	sub		x5, x4, x5	# 1296
	lw		x4, 0(x2)	# 1296
	lw		x27, 4(x2)	# 1296
	lw		x31, 0(x27)	# 1296
	jalr	x0, x31, 0	# 1296
is_rect_outside.2752:
	fsw		f2, 0(x2)	# 1308
	fsw		f1, 8(x2)	# 1308
	sw		x4, 16(x2)	# 1308
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fabs.2451
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 1308
	fadd	f0, f0, f10	# 1308
	lw		x4, 16(x2)	# 1308
	fsw		f0, 24(x2)	# 1308
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_param_a.2565
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f1, f1, f1	# 1308
	fadd	f1, f1, f10	# 1308
	flw		f0, 24(x2)	# 1308
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fless.2453
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1308
	lui		x5, 0	# 1308
	ori		x5, x0, 0	# 1308
	beq		x4, x5, beq.9774	# 1308
	flw		f0, 8(x2)	# 1309
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fabs.2451
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1309
	fadd	f0, f0, f10	# 1309
	lw		x4, 16(x2)	# 1309
	fsw		f0, 32(x2)	# 1309
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_param_b.2567
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f1, f1, f1	# 1309
	fadd	f1, f1, f10	# 1309
	flw		f0, 32(x2)	# 1309
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, fless.2453
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 1309
	lui		x5, 0	# 1309
	ori		x5, x0, 0	# 1309
	beq		x4, x5, beq.9776	# 1309
	flw		f0, 0(x2)	# 1310
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, fabs.2451
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 1310
	fadd	f0, f0, f10	# 1310
	lw		x4, 16(x2)	# 1310
	fsw		f0, 40(x2)	# 1310
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, o_param_c.2569
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f1, f1, f1	# 1310
	fadd	f1, f1, f10	# 1310
	flw		f0, 40(x2)	# 1310
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fless.2453
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1310
	jal		x0, beq_cont.9777	# 1309
beq.9776:
	lui		x4, 0	# 1311
	ori		x4, x0, 0	# 1311
beq_cont.9777:
	jal		x0, beq_cont.9775	# 1308
beq.9774:
	lui		x4, 0	# 1312
	ori		x4, x0, 0	# 1312
beq_cont.9775:
	lui		x5, 0	# 1307
	ori		x5, x0, 0	# 1307
	beq		x4, x5, beq.9778	# 1307
	lw		x4, 16(x2)	# 1313
	jal		x0, o_isinvert.2561	# 1313
beq.9778:
	lw		x4, 16(x2)	# 1313
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, o_isinvert.2561
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1313
	lui		x5, 0	# 1313
	ori		x5, x0, 0	# 1313
	beq		x4, x5, beq.9779	# 1313
	lui		x10, 0	# 1313
	ori		x10, x0, 0	# 1313
	jalr	x0, x1, 0
beq.9779:
	lui		x10, 1	# 1313
	ori		x10, x0, 1	# 1313
	jalr	x0, x1, 0
is_plane_outside.2757:
	sw		x4, 0(x2)	# 1318
	fsw		f2, 8(x2)	# 1318
	fsw		f1, 16(x2)	# 1318
	fsw		f0, 24(x2)	# 1318
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_param_abc.2571
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1318
	flw		f0, 24(x2)	# 1318
	flw		f1, 16(x2)	# 1318
	flw		f2, 8(x2)	# 1318
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, veciprod2.2536
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1318
	fadd	f0, f0, f10	# 1318
	lw		x4, 0(x2)	# 1319
	fsw		f0, 32(x2)	# 1319
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_isinvert.2561
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 1319
	flw		f0, 32(x2)	# 1319
	sw		x4, 40(x2)	# 1319
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, fisneg.2447
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x5, x10, 0	# 1319
	lw		x4, 40(x2)	# 1319
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, xor.2506
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 1319
	lui		x5, 0	# 1319
	ori		x5, x0, 0	# 1319
	beq		x4, x5, beq.9781	# 1319
	lui		x10, 0	# 1319
	ori		x10, x0, 0	# 1319
	jalr	x0, x1, 0
beq.9781:
	lui		x10, 1	# 1319
	ori		x10, x0, 1	# 1319
	jalr	x0, x1, 0
is_second_outside.2762:
	sw		x4, 0(x2)	# 1324
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, quadratic.2670
	addi	x2, x2, -8
	lw		x1, 4(x2)
	fsub	f0, f0, f0	# 1324
	fadd	f0, f0, f10	# 1324
	lw		x4, 0(x2)	# 1325
	fsw		f0, 8(x2)	# 1325
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_form.2557
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1325
	lui		x5, 3	# 1325
	ori		x5, x0, 3	# 1325
	beq		x4, x5, beq.9783	# 1325
	flw		f0, 8(x2)	# 1325
	jal		x0, beq_cont.9784	# 1325
beq.9783:
	lui		x4, %hi(l.6062)	# 1325
	ori		x4, %lo(l.6062)	# 1325
	flw		f0, 0(x4)	# 1325
	flw		f1, 8(x2)	# 1325
	fsub	f0, f1, f0	# 1325
beq_cont.9784:
	lw		x4, 0(x2)	# 1326
	fsw		f0, 16(x2)	# 1326
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, o_isinvert.2561
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1326
	flw		f0, 16(x2)	# 1326
	sw		x4, 24(x2)	# 1326
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, fisneg.2447
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x5, x10, 0	# 1326
	lw		x4, 24(x2)	# 1326
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, xor.2506
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1326
	lui		x5, 0	# 1326
	ori		x5, x0, 0	# 1326
	beq		x4, x5, beq.9785	# 1326
	lui		x10, 0	# 1326
	ori		x10, x0, 0	# 1326
	jalr	x0, x1, 0
beq.9785:
	lui		x10, 1	# 1326
	ori		x10, x0, 1	# 1326
	jalr	x0, x1, 0
is_outside.2767:
	fsw		f2, 0(x2)	# 1331
	fsw		f1, 8(x2)	# 1331
	sw		x4, 16(x2)	# 1331
	fsw		f0, 24(x2)	# 1331
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_param_x.2573
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1331
	fadd	f0, f0, f10	# 1331
	flw		f1, 24(x2)	# 1331
	fsub	f0, f1, f0	# 1331
	lw		x4, 16(x2)	# 1332
	fsw		f0, 32(x2)	# 1332
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_param_y.2575
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 1332
	fadd	f0, f0, f10	# 1332
	flw		f1, 8(x2)	# 1332
	fsub	f0, f1, f0	# 1332
	lw		x4, 16(x2)	# 1333
	fsw		f0, 40(x2)	# 1333
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, o_param_z.2577
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 1333
	fadd	f0, f0, f10	# 1333
	flw		f1, 0(x2)	# 1333
	fsub	f0, f1, f0	# 1333
	lw		x4, 16(x2)	# 1334
	fsw		f0, 48(x2)	# 1334
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_form.2557
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 1334
	lui		x5, 1	# 1335
	ori		x5, x0, 1	# 1335
	beq		x4, x5, beq.9787	# 1335
	lui		x5, 2	# 1337
	ori		x5, x0, 2	# 1337
	beq		x4, x5, beq.9788	# 1337
	flw		f0, 32(x2)	# 1340
	flw		f1, 40(x2)	# 1340
	flw		f2, 48(x2)	# 1340
	lw		x4, 16(x2)	# 1340
	jal		x0, is_second_outside.2762	# 1340
beq.9788:
	flw		f0, 32(x2)	# 1338
	flw		f1, 40(x2)	# 1338
	flw		f2, 48(x2)	# 1338
	lw		x4, 16(x2)	# 1338
	jal		x0, is_plane_outside.2757	# 1338
beq.9787:
	flw		f0, 32(x2)	# 1336
	flw		f1, 40(x2)	# 1336
	flw		f2, 48(x2)	# 1336
	lw		x4, 16(x2)	# 1336
	jal		x0, is_rect_outside.2752	# 1336
check_all_inside.2772:
	lw		x6, 4(x27)	# 1345
	mul		x7, x4, 4	# 1345
	add		x7, x5, x7	# 1345
	lw		x7, 0(x7)	# 1345
	lui		x8, -1	# 1346
	ori		x8, x0, -1	# 1346
	beq		x7, x8, beq.9789	# 1346
	mul		x7, x7, 4	# 1349
	add		x6, x6, x7	# 1349
	lw		x6, 0(x6)	# 1349
	fsw		f2, 0(x2)	# 1349
	fsw		f1, 8(x2)	# 1349
	fsw		f0, 16(x2)	# 1349
	sw		x5, 24(x2)	# 1349
	sw		x27, 28(x2)	# 1349
	sw		x4, 32(x2)	# 1349
	addi	x4, x6, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, is_outside.2767
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1349
	lui		x5, 0	# 1349
	ori		x5, x0, 0	# 1349
	beq		x4, x5, beq.9790	# 1349
	lui		x10, 0	# 1350
	ori		x10, x0, 0	# 1350
	jalr	x0, x1, 0
beq.9790:
	lw		x4, 32(x2)	# 1352
	addi	x4, x4, 1	# 1352
	flw		f0, 16(x2)	# 1352
	flw		f1, 8(x2)	# 1352
	flw		f2, 0(x2)	# 1352
	lw		x5, 24(x2)	# 1352
	lw		x27, 28(x2)	# 1352
	lw		x31, 0(x27)	# 1352
	jalr	x0, x31, 0	# 1352
beq.9789:
	lui		x10, 1	# 1347
	ori		x10, x0, 1	# 1347
	jalr	x0, x1, 0
shadow_check_and_group.2778:
	lw		x6, 28(x27)	# 1365
	lw		x7, 24(x27)	# 1365
	lw		x8, 20(x27)	# 1365
	lw		x9, 16(x27)	# 1365
	lw		x11, 12(x27)	# 1365
	lw		x12, 8(x27)	# 1365
	lw		x13, 4(x27)	# 1365
	mul		x14, x4, 4	# 1365
	add		x14, x5, x14	# 1365
	lw		x14, 0(x14)	# 1365
	lui		x15, -1	# 1365
	ori		x15, x0, -1	# 1365
	beq		x14, x15, beq.9791	# 1365
	mul		x14, x4, 4	# 1368
	add		x14, x5, x14	# 1368
	lw		x14, 0(x14)	# 1368
	sw		x13, 0(x2)	# 1369
	sw		x12, 4(x2)	# 1369
	sw		x11, 8(x2)	# 1369
	sw		x5, 12(x2)	# 1369
	sw		x27, 16(x2)	# 1369
	sw		x4, 20(x2)	# 1369
	sw		x8, 24(x2)	# 1369
	sw		x14, 28(x2)	# 1369
	sw		x7, 32(x2)	# 1369
	addi	x5, x9, 0
	addi	x4, x14, 0
	addi	x27, x6, 0
	addi	x6, x12, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1369
	lui		x5, 0	# 1370
	ori		x5, x0, 0	# 1370
	mul		x5, x5, 8	# 1370
	lw		x6, 32(x2)	# 1370
	add		x5, x6, x5	# 1370
	flw		f0, 0(x5)	# 1370
	lui		x5, 0	# 1371
	ori		x5, x0, 0	# 1371
	fsw		f0, 40(x2)	# 1371
	beq		x4, x5, beq.9793	# 1371
	lui		x4, %hi(l.6742)	# 1371
	ori		x4, %lo(l.6742)	# 1371
	flw		f1, 0(x4)	# 1371
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fless.2453
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1371
	jal		x0, beq_cont.9794	# 1371
beq.9793:
	lui		x4, 0	# 1371
	ori		x4, x0, 0	# 1371
beq_cont.9794:
	lui		x5, 0	# 1371
	ori		x5, x0, 0	# 1371
	beq		x4, x5, beq.9795	# 1371
	lui		x4, %hi(l.6744)	# 1374
	ori		x4, %lo(l.6744)	# 1374
	flw		f0, 0(x4)	# 1374
	flw		f1, 40(x2)	# 1374
	fadd	f0, f1, f0	# 1374
	lui		x4, 0	# 1375
	ori		x4, x0, 0	# 1375
	mul		x4, x4, 8	# 1375
	lw		x5, 8(x2)	# 1375
	add		x4, x5, x4	# 1375
	flw		f1, 0(x4)	# 1375
	fmul	f1, f1, f0	# 1375
	lui		x4, 0	# 1375
	ori		x4, x0, 0	# 1375
	mul		x4, x4, 8	# 1375
	lw		x6, 4(x2)	# 1375
	add		x4, x6, x4	# 1375
	flw		f2, 0(x4)	# 1375
	fadd	f1, f1, f2	# 1375
	lui		x4, 1	# 1376
	ori		x4, x0, 1	# 1376
	mul		x4, x4, 8	# 1376
	add		x4, x5, x4	# 1376
	flw		f2, 0(x4)	# 1376
	fmul	f2, f2, f0	# 1376
	lui		x4, 1	# 1376
	ori		x4, x0, 1	# 1376
	mul		x4, x4, 8	# 1376
	add		x4, x6, x4	# 1376
	flw		f3, 0(x4)	# 1376
	fadd	f2, f2, f3	# 1376
	lui		x4, 2	# 1377
	ori		x4, x0, 2	# 1377
	mul		x4, x4, 8	# 1377
	add		x4, x5, x4	# 1377
	flw		f3, 0(x4)	# 1377
	fmul	f0, f3, f0	# 1377
	lui		x4, 2	# 1377
	ori		x4, x0, 2	# 1377
	mul		x4, x4, 8	# 1377
	add		x4, x6, x4	# 1377
	flw		f3, 0(x4)	# 1377
	fadd	f0, f0, f3	# 1377
	lui		x4, 0	# 1378
	ori		x4, x0, 0	# 1378
	lw		x5, 12(x2)	# 1378
	lw		x27, 0(x2)	# 1378
	fsub	f31, f31, f31
	fadd	f31, f31, f2
	fsub	f2, f2, f2
	fadd	f2, f2, f0
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	fsub	f1, f1, f1
	fadd	f1, f1, f31
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1378
	lui		x5, 0	# 1378
	ori		x5, x0, 0	# 1378
	beq		x4, x5, beq.9796	# 1378
	lui		x10, 1	# 1379
	ori		x10, x0, 1	# 1379
	jalr	x0, x1, 0
beq.9796:
	lw		x4, 20(x2)	# 1381
	addi	x4, x4, 1	# 1381
	lw		x5, 12(x2)	# 1381
	lw		x27, 16(x2)	# 1381
	lw		x31, 0(x27)	# 1381
	jalr	x0, x31, 0	# 1381
beq.9795:
	lw		x4, 28(x2)	# 1387
	mul		x4, x4, 4	# 1387
	lw		x5, 24(x2)	# 1387
	add		x4, x5, x4	# 1387
	lw		x4, 0(x4)	# 1387
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, o_isinvert.2561
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1387
	lui		x5, 0	# 1387
	ori		x5, x0, 0	# 1387
	beq		x4, x5, beq.9797	# 1387
	lw		x4, 20(x2)	# 1388
	addi	x4, x4, 1	# 1388
	lw		x5, 12(x2)	# 1388
	lw		x27, 16(x2)	# 1388
	lw		x31, 0(x27)	# 1388
	jalr	x0, x31, 0	# 1388
beq.9797:
	lui		x10, 0	# 1390
	ori		x10, x0, 0	# 1390
	jalr	x0, x1, 0
beq.9791:
	lui		x10, 0	# 1366
	ori		x10, x0, 0	# 1366
	jalr	x0, x1, 0
shadow_check_one_or_group.2781:
	lw		x6, 8(x27)	# 1395
	lw		x7, 4(x27)	# 1395
	mul		x8, x4, 4	# 1395
	add		x8, x5, x8	# 1395
	lw		x8, 0(x8)	# 1395
	lui		x9, -1	# 1396
	ori		x9, x0, -1	# 1396
	beq		x8, x9, beq.9798	# 1396
	mul		x8, x8, 4	# 1399
	add		x7, x7, x8	# 1399
	lw		x7, 0(x7)	# 1399
	lui		x8, 0	# 1400
	ori		x8, x0, 0	# 1400
	sw		x5, 0(x2)	# 1400
	sw		x27, 4(x2)	# 1400
	sw		x4, 8(x2)	# 1400
	addi	x5, x7, 0
	addi	x4, x8, 0
	addi	x27, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 1400
	lui		x5, 0	# 1401
	ori		x5, x0, 0	# 1401
	beq		x4, x5, beq.9799	# 1401
	lui		x10, 1	# 1402
	ori		x10, x0, 1	# 1402
	jalr	x0, x1, 0
beq.9799:
	lw		x4, 8(x2)	# 1404
	addi	x4, x4, 1	# 1404
	lw		x5, 0(x2)	# 1404
	lw		x27, 4(x2)	# 1404
	lw		x31, 0(x27)	# 1404
	jalr	x0, x31, 0	# 1404
beq.9798:
	lui		x10, 0	# 1397
	ori		x10, x0, 0	# 1397
	jalr	x0, x1, 0
shadow_check_one_or_matrix.2784:
	lw		x6, 20(x27)	# 1410
	lw		x7, 16(x27)	# 1410
	lw		x8, 12(x27)	# 1410
	lw		x9, 8(x27)	# 1410
	lw		x11, 4(x27)	# 1410
	mul		x12, x4, 4	# 1410
	add		x12, x5, x12	# 1410
	lw		x12, 0(x12)	# 1410
	lui		x13, 0	# 1411
	ori		x13, x0, 0	# 1411
	mul		x13, x13, 4	# 1411
	add		x13, x12, x13	# 1411
	lw		x13, 0(x13)	# 1411
	lui		x14, -1	# 1412
	ori		x14, x0, -1	# 1412
	beq		x13, x14, beq.9800	# 1412
	lui		x14, 99	# 1416
	ori		x14, x0, 99	# 1416
	sw		x12, 0(x2)	# 1416
	sw		x8, 4(x2)	# 1416
	sw		x5, 8(x2)	# 1416
	sw		x27, 12(x2)	# 1416
	sw		x4, 16(x2)	# 1416
	beq		x13, x14, beq.9801	# 1416
	sw		x7, 20(x2)	# 1419
	addi	x5, x9, 0
	addi	x4, x13, 0
	addi	x27, x6, 0
	addi	x6, x11, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1419
	lui		x5, 0	# 1422
	ori		x5, x0, 0	# 1422
	beq		x4, x5, beq.9803	# 1422
	lui		x4, 0	# 1423
	ori		x4, x0, 0	# 1423
	mul		x4, x4, 8	# 1423
	lw		x5, 20(x2)	# 1423
	add		x4, x5, x4	# 1423
	flw		f0, 0(x4)	# 1423
	lui		x4, %hi(l.6770)	# 1423
	ori		x4, %lo(l.6770)	# 1423
	flw		f1, 0(x4)	# 1423
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, fless.2453
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1423
	lui		x5, 0	# 1423
	ori		x5, x0, 0	# 1423
	beq		x4, x5, beq.9805	# 1423
	lui		x4, 1	# 1424
	ori		x4, x0, 1	# 1424
	lw		x5, 0(x2)	# 1424
	lw		x27, 4(x2)	# 1424
	sw		x1, 28(x2)
	addi	x2, x2, 32
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1424
	lui		x5, 0	# 1424
	ori		x5, x0, 0	# 1424
	beq		x4, x5, beq.9807	# 1424
	lui		x4, 1	# 1425
	ori		x4, x0, 1	# 1425
	jal		x0, beq_cont.9808	# 1424
beq.9807:
	lui		x4, 0	# 1426
	ori		x4, x0, 0	# 1426
beq_cont.9808:
	jal		x0, beq_cont.9806	# 1423
beq.9805:
	lui		x4, 0	# 1427
	ori		x4, x0, 0	# 1427
beq_cont.9806:
	jal		x0, beq_cont.9804	# 1422
beq.9803:
	lui		x4, 0	# 1428
	ori		x4, x0, 0	# 1428
beq_cont.9804:
	jal		x0, beq_cont.9802	# 1416
beq.9801:
	lui		x4, 1	# 1417
	ori		x4, x0, 1	# 1417
beq_cont.9802:
	lui		x5, 0	# 1415
	ori		x5, x0, 0	# 1415
	beq		x4, x5, beq.9809	# 1415
	lui		x4, 1	# 1430
	ori		x4, x0, 1	# 1430
	lw		x5, 0(x2)	# 1430
	lw		x27, 4(x2)	# 1430
	sw		x1, 28(x2)
	addi	x2, x2, 32
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1430
	lui		x5, 0	# 1430
	ori		x5, x0, 0	# 1430
	beq		x4, x5, beq.9810	# 1430
	lui		x10, 1	# 1431
	ori		x10, x0, 1	# 1431
	jalr	x0, x1, 0
beq.9810:
	lw		x4, 16(x2)	# 1433
	addi	x4, x4, 1	# 1433
	lw		x5, 8(x2)	# 1433
	lw		x27, 12(x2)	# 1433
	lw		x31, 0(x27)	# 1433
	jalr	x0, x31, 0	# 1433
beq.9809:
	lw		x4, 16(x2)	# 1435
	addi	x4, x4, 1	# 1435
	lw		x5, 8(x2)	# 1435
	lw		x27, 12(x2)	# 1435
	lw		x31, 0(x27)	# 1435
	jalr	x0, x31, 0	# 1435
beq.9800:
	lui		x10, 0	# 1413
	ori		x10, x0, 0	# 1413
	jalr	x0, x1, 0
solve_each_element.2787:
	lw		x7, 36(x27)	# 1446
	lw		x8, 32(x27)	# 1446
	lw		x9, 28(x27)	# 1446
	lw		x11, 24(x27)	# 1446
	lw		x12, 20(x27)	# 1446
	lw		x13, 16(x27)	# 1446
	lw		x14, 12(x27)	# 1446
	lw		x15, 8(x27)	# 1446
	lw		x16, 4(x27)	# 1446
	mul		x17, x4, 4	# 1446
	add		x17, x5, x17	# 1446
	lw		x17, 0(x17)	# 1446
	lui		x18, -1	# 1447
	ori		x18, x0, -1	# 1447
	beq		x17, x18, beq.9811	# 1447
	sw		x13, 0(x2)	# 1449
	sw		x15, 4(x2)	# 1449
	sw		x14, 8(x2)	# 1449
	sw		x16, 12(x2)	# 1449
	sw		x8, 16(x2)	# 1449
	sw		x7, 20(x2)	# 1449
	sw		x9, 24(x2)	# 1449
	sw		x6, 28(x2)	# 1449
	sw		x5, 32(x2)	# 1449
	sw		x27, 36(x2)	# 1449
	sw		x4, 40(x2)	# 1449
	sw		x12, 44(x2)	# 1449
	sw		x17, 48(x2)	# 1449
	addi	x5, x6, 0
	addi	x4, x17, 0
	addi	x27, x11, 0
	addi	x6, x8, 0
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1449
	lui		x5, 0	# 1450
	ori		x5, x0, 0	# 1450
	beq		x4, x5, beq.9812	# 1450
	lui		x5, 0	# 1454
	ori		x5, x0, 0	# 1454
	mul		x5, x5, 8	# 1454
	lw		x6, 24(x2)	# 1454
	add		x5, x6, x5	# 1454
	flw		f1, 0(x5)	# 1454
	lui		x5, %hi(l.6055)	# 1456
	ori		x5, %lo(l.6055)	# 1456
	flw		f0, 0(x5)	# 1456
	sw		x4, 52(x2)	# 1456
	fsw		f1, 56(x2)	# 1456
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fless.2453
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 1456
	lui		x5, 0	# 1456
	ori		x5, x0, 0	# 1456
	beq		x4, x5, beq.9813	# 1456
	lui		x4, 0	# 1457
	ori		x4, x0, 0	# 1457
	mul		x4, x4, 8	# 1457
	lw		x5, 20(x2)	# 1457
	add		x4, x5, x4	# 1457
	flw		f1, 0(x4)	# 1457
	flw		f0, 56(x2)	# 1457
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, fless.2453
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 1457
	lui		x5, 0	# 1457
	ori		x5, x0, 0	# 1457
	beq		x4, x5, beq.9815	# 1457
	lui		x4, %hi(l.6744)	# 1459
	ori		x4, %lo(l.6744)	# 1459
	flw		f0, 0(x4)	# 1459
	flw		f1, 56(x2)	# 1459
	fadd	f0, f1, f0	# 1459
	lui		x4, 0	# 1460
	ori		x4, x0, 0	# 1460
	mul		x4, x4, 8	# 1460
	lw		x5, 28(x2)	# 1460
	add		x4, x5, x4	# 1460
	flw		f1, 0(x4)	# 1460
	fmul	f1, f1, f0	# 1460
	lui		x4, 0	# 1460
	ori		x4, x0, 0	# 1460
	mul		x4, x4, 8	# 1460
	lw		x6, 16(x2)	# 1460
	add		x4, x6, x4	# 1460
	flw		f2, 0(x4)	# 1460
	fadd	f1, f1, f2	# 1460
	lui		x4, 1	# 1461
	ori		x4, x0, 1	# 1461
	mul		x4, x4, 8	# 1461
	add		x4, x5, x4	# 1461
	flw		f2, 0(x4)	# 1461
	fmul	f2, f2, f0	# 1461
	lui		x4, 1	# 1461
	ori		x4, x0, 1	# 1461
	mul		x4, x4, 8	# 1461
	add		x4, x6, x4	# 1461
	flw		f3, 0(x4)	# 1461
	fadd	f2, f2, f3	# 1461
	lui		x4, 2	# 1462
	ori		x4, x0, 2	# 1462
	mul		x4, x4, 8	# 1462
	add		x4, x5, x4	# 1462
	flw		f3, 0(x4)	# 1462
	fmul	f3, f3, f0	# 1462
	lui		x4, 2	# 1462
	ori		x4, x0, 2	# 1462
	mul		x4, x4, 8	# 1462
	add		x4, x6, x4	# 1462
	flw		f4, 0(x4)	# 1462
	fadd	f3, f3, f4	# 1462
	lui		x4, 0	# 1463
	ori		x4, x0, 0	# 1463
	lw		x6, 32(x2)	# 1463
	lw		x27, 12(x2)	# 1463
	fsw		f3, 64(x2)	# 1463
	fsw		f2, 72(x2)	# 1463
	fsw		f1, 80(x2)	# 1463
	fsw		f0, 88(x2)	# 1463
	addi	x5, x6, 0
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	fsub	f1, f1, f1
	fadd	f1, f1, f2
	fsub	f2, f2, f2
	fadd	f2, f2, f3
	sw		x1, 100(x2)
	addi	x2, x2, 104
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -104
	lw		x1, 100(x2)
	addi	x4, x10, 0	# 1463
	lui		x5, 0	# 1463
	ori		x5, x0, 0	# 1463
	beq		x4, x5, beq.9817	# 1463
	lui		x4, 0	# 1465
	ori		x4, x0, 0	# 1465
	mul		x4, x4, 8	# 1465
	lw		x5, 20(x2)	# 1465
	add		x4, x5, x4	# 1465
	flw		f0, 88(x2)	# 1465
	fsw		f0, 0(x4)	# 1465
	flw		f0, 80(x2)	# 1466
	flw		f1, 72(x2)	# 1466
	flw		f2, 64(x2)	# 1466
	lw		x4, 8(x2)	# 1466
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, vecset.2517
	addi	x2, x2, -104
	lw		x1, 100(x2)
	lui		x4, 0	# 1467
	ori		x4, x0, 0	# 1467
	mul		x4, x4, 4	# 1467
	lw		x5, 4(x2)	# 1467
	add		x4, x5, x4	# 1467
	lw		x5, 48(x2)	# 1467
	sw		x5, 0(x4)	# 1467
	lui		x4, 0	# 1468
	ori		x4, x0, 0	# 1468
	mul		x4, x4, 4	# 1468
	lw		x5, 0(x2)	# 1468
	add		x4, x5, x4	# 1468
	lw		x5, 52(x2)	# 1468
	sw		x5, 0(x4)	# 1468
	jal		x0, beq_cont.9818	# 1463
beq.9817:
beq_cont.9818:
	jal		x0, beq_cont.9816	# 1457
beq.9815:
beq_cont.9816:
	jal		x0, beq_cont.9814	# 1456
beq.9813:
beq_cont.9814:
	lw		x4, 40(x2)	# 1474
	addi	x4, x4, 1	# 1474
	lw		x5, 32(x2)	# 1474
	lw		x6, 28(x2)	# 1474
	lw		x27, 36(x2)	# 1474
	lw		x31, 0(x27)	# 1474
	jalr	x0, x31, 0	# 1474
beq.9812:
	lw		x4, 48(x2)	# 1478
	mul		x4, x4, 4	# 1478
	lw		x5, 44(x2)	# 1478
	add		x4, x5, x4	# 1478
	lw		x4, 0(x4)	# 1478
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, o_isinvert.2561
	addi	x2, x2, -104
	lw		x1, 100(x2)
	addi	x4, x10, 0	# 1478
	lui		x5, 0	# 1478
	ori		x5, x0, 0	# 1478
	beq		x4, x5, beq.9819	# 1478
	lw		x4, 40(x2)	# 1479
	addi	x4, x4, 1	# 1479
	lw		x5, 32(x2)	# 1479
	lw		x6, 28(x2)	# 1479
	lw		x27, 36(x2)	# 1479
	lw		x31, 0(x27)	# 1479
	jalr	x0, x31, 0	# 1479
beq.9819:
	jalr	x0, x1, 0
beq.9811:
	jalr	x0, x1, 0
solve_one_or_network.2791:
	lw		x7, 8(x27)	# 1487
	lw		x8, 4(x27)	# 1487
	mul		x9, x4, 4	# 1487
	add		x9, x5, x9	# 1487
	lw		x9, 0(x9)	# 1487
	lui		x11, -1	# 1488
	ori		x11, x0, -1	# 1488
	beq		x9, x11, beq.9822	# 1488
	mul		x9, x9, 4	# 1489
	add		x8, x8, x9	# 1489
	lw		x8, 0(x8)	# 1489
	lui		x9, 0	# 1490
	ori		x9, x0, 0	# 1490
	sw		x6, 0(x2)	# 1490
	sw		x5, 4(x2)	# 1490
	sw		x27, 8(x2)	# 1490
	sw		x4, 12(x2)	# 1490
	addi	x5, x8, 0
	addi	x4, x9, 0
	addi	x27, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lw		x4, 12(x2)	# 1491
	addi	x4, x4, 1	# 1491
	lw		x5, 4(x2)	# 1491
	lw		x6, 0(x2)	# 1491
	lw		x27, 8(x2)	# 1491
	lw		x31, 0(x27)	# 1491
	jalr	x0, x31, 0	# 1491
beq.9822:
	jalr	x0, x1, 0
trace_or_matrix.2795:
	lw		x7, 20(x27)	# 1497
	lw		x8, 16(x27)	# 1497
	lw		x9, 12(x27)	# 1497
	lw		x11, 8(x27)	# 1497
	lw		x12, 4(x27)	# 1497
	mul		x13, x4, 4	# 1497
	add		x13, x5, x13	# 1497
	lw		x13, 0(x13)	# 1497
	lui		x14, 0	# 1498
	ori		x14, x0, 0	# 1498
	mul		x14, x14, 4	# 1498
	add		x14, x13, x14	# 1498
	lw		x14, 0(x14)	# 1498
	lui		x15, -1	# 1499
	ori		x15, x0, -1	# 1499
	beq		x14, x15, beq.9824	# 1499
	lui		x15, 99	# 1502
	ori		x15, x0, 99	# 1502
	sw		x6, 0(x2)	# 1502
	sw		x5, 4(x2)	# 1502
	sw		x27, 8(x2)	# 1502
	sw		x4, 12(x2)	# 1502
	beq		x14, x15, beq.9825	# 1502
	sw		x13, 16(x2)	# 1507
	sw		x12, 20(x2)	# 1507
	sw		x7, 24(x2)	# 1507
	sw		x9, 28(x2)	# 1507
	addi	x5, x6, 0
	addi	x4, x14, 0
	addi	x27, x11, 0
	addi	x6, x8, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1507
	lui		x5, 0	# 1508
	ori		x5, x0, 0	# 1508
	beq		x4, x5, beq.9827	# 1508
	lui		x4, 0	# 1509
	ori		x4, x0, 0	# 1509
	mul		x4, x4, 8	# 1509
	lw		x5, 28(x2)	# 1509
	add		x4, x5, x4	# 1509
	flw		f0, 0(x4)	# 1509
	lui		x4, 0	# 1510
	ori		x4, x0, 0	# 1510
	mul		x4, x4, 8	# 1510
	lw		x5, 24(x2)	# 1510
	add		x4, x5, x4	# 1510
	flw		f1, 0(x4)	# 1510
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fless.2453
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1510
	lui		x5, 0	# 1510
	ori		x5, x0, 0	# 1510
	beq		x4, x5, beq.9829	# 1510
	lui		x4, 1	# 1511
	ori		x4, x0, 1	# 1511
	lw		x5, 16(x2)	# 1511
	lw		x6, 0(x2)	# 1511
	lw		x27, 20(x2)	# 1511
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	jal		x0, beq_cont.9830	# 1510
beq.9829:
beq_cont.9830:
	jal		x0, beq_cont.9828	# 1508
beq.9827:
beq_cont.9828:
	jal		x0, beq_cont.9826	# 1502
beq.9825:
	lui		x7, 1	# 1503
	ori		x7, x0, 1	# 1503
	addi	x5, x13, 0
	addi	x4, x7, 0
	addi	x27, x12, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
beq_cont.9826:
	lw		x4, 12(x2)	# 1515
	addi	x4, x4, 1	# 1515
	lw		x5, 4(x2)	# 1515
	lw		x6, 0(x2)	# 1515
	lw		x27, 8(x2)	# 1515
	lw		x31, 0(x27)	# 1515
	jalr	x0, x31, 0	# 1515
beq.9824:
	jalr	x0, x1, 0
judge_intersection.2799:
	lw		x5, 12(x27)	# 1524
	lw		x6, 8(x27)	# 1524
	lw		x7, 4(x27)	# 1524
	lui		x8, 0	# 1524
	ori		x8, x0, 0	# 1524
	lui		x9, %hi(l.6812)	# 1524
	ori		x9, %lo(l.6812)	# 1524
	flw		f0, 0(x9)	# 1524
	mul		x8, x8, 8	# 1524
	add		x8, x6, x8	# 1524
	fsw		f0, 0(x8)	# 1524
	lui		x8, 0	# 1525
	ori		x8, x0, 0	# 1525
	lui		x9, 0	# 1525
	ori		x9, x0, 0	# 1525
	mul		x9, x9, 4	# 1525
	add		x7, x7, x9	# 1525
	lw		x7, 0(x7)	# 1525
	sw		x6, 0(x2)	# 1525
	addi	x6, x4, 0
	addi	x27, x5, 0
	addi	x5, x7, 0
	addi	x4, x8, 0
	sw		x1, 4(x2)
	addi	x2, x2, 8
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 0	# 1526
	ori		x4, x0, 0	# 1526
	mul		x4, x4, 8	# 1526
	lw		x5, 0(x2)	# 1526
	add		x4, x5, x4	# 1526
	flw		f1, 0(x4)	# 1526
	lui		x4, %hi(l.6770)	# 1528
	ori		x4, %lo(l.6770)	# 1528
	flw		f0, 0(x4)	# 1528
	fsw		f1, 8(x2)	# 1528
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fless.2453
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1528
	lui		x5, 0	# 1528
	ori		x5, x0, 0	# 1528
	beq		x4, x5, beq.9833	# 1528
	lui		x4, %hi(l.6821)	# 1529
	ori		x4, %lo(l.6821)	# 1529
	flw		f1, 0(x4)	# 1529
	flw		f0, 8(x2)	# 1529
	jal		x0, fless.2453	# 1529
beq.9833:
	lui		x10, 0	# 1530
	ori		x10, x0, 0	# 1530
	jalr	x0, x1, 0
solve_each_element_fast.2801:
	lw		x7, 36(x27)	# 1539
	lw		x8, 32(x27)	# 1539
	lw		x9, 28(x27)	# 1539
	lw		x11, 24(x27)	# 1539
	lw		x12, 20(x27)	# 1539
	lw		x13, 16(x27)	# 1539
	lw		x14, 12(x27)	# 1539
	lw		x15, 8(x27)	# 1539
	lw		x16, 4(x27)	# 1539
	sw		x13, 0(x2)	# 1539
	sw		x15, 4(x2)	# 1539
	sw		x14, 8(x2)	# 1539
	sw		x16, 12(x2)	# 1539
	sw		x8, 16(x2)	# 1539
	sw		x7, 20(x2)	# 1539
	sw		x11, 24(x2)	# 1539
	sw		x27, 28(x2)	# 1539
	sw		x12, 32(x2)	# 1539
	sw		x6, 36(x2)	# 1539
	sw		x9, 40(x2)	# 1539
	sw		x5, 44(x2)	# 1539
	sw		x4, 48(x2)	# 1539
	addi	x4, x6, 0
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, d_vec.2616
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 1539
	lw		x5, 48(x2)	# 1540
	mul		x6, x5, 4	# 1540
	lw		x7, 44(x2)	# 1540
	add		x6, x7, x6	# 1540
	lw		x6, 0(x6)	# 1540
	lui		x8, -1	# 1541
	ori		x8, x0, -1	# 1541
	beq		x6, x8, beq.9834	# 1541
	lw		x8, 36(x2)	# 1543
	lw		x27, 40(x2)	# 1543
	sw		x4, 52(x2)	# 1543
	sw		x6, 56(x2)	# 1543
	addi	x5, x8, 0
	addi	x4, x6, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 1543
	lui		x5, 0	# 1544
	ori		x5, x0, 0	# 1544
	beq		x4, x5, beq.9835	# 1544
	lui		x5, 0	# 1548
	ori		x5, x0, 0	# 1548
	mul		x5, x5, 8	# 1548
	lw		x6, 24(x2)	# 1548
	add		x5, x6, x5	# 1548
	flw		f1, 0(x5)	# 1548
	lui		x5, %hi(l.6055)	# 1550
	ori		x5, %lo(l.6055)	# 1550
	flw		f0, 0(x5)	# 1550
	sw		x4, 60(x2)	# 1550
	fsw		f1, 64(x2)	# 1550
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fless.2453
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1550
	lui		x5, 0	# 1550
	ori		x5, x0, 0	# 1550
	beq		x4, x5, beq.9836	# 1550
	lui		x4, 0	# 1551
	ori		x4, x0, 0	# 1551
	mul		x4, x4, 8	# 1551
	lw		x5, 20(x2)	# 1551
	add		x4, x5, x4	# 1551
	flw		f1, 0(x4)	# 1551
	flw		f0, 64(x2)	# 1551
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fless.2453
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1551
	lui		x5, 0	# 1551
	ori		x5, x0, 0	# 1551
	beq		x4, x5, beq.9838	# 1551
	lui		x4, %hi(l.6744)	# 1553
	ori		x4, %lo(l.6744)	# 1553
	flw		f0, 0(x4)	# 1553
	flw		f1, 64(x2)	# 1553
	fadd	f0, f1, f0	# 1553
	lui		x4, 0	# 1554
	ori		x4, x0, 0	# 1554
	mul		x4, x4, 8	# 1554
	lw		x5, 52(x2)	# 1554
	add		x4, x5, x4	# 1554
	flw		f1, 0(x4)	# 1554
	fmul	f1, f1, f0	# 1554
	lui		x4, 0	# 1554
	ori		x4, x0, 0	# 1554
	mul		x4, x4, 8	# 1554
	lw		x6, 16(x2)	# 1554
	add		x4, x6, x4	# 1554
	flw		f2, 0(x4)	# 1554
	fadd	f1, f1, f2	# 1554
	lui		x4, 1	# 1555
	ori		x4, x0, 1	# 1555
	mul		x4, x4, 8	# 1555
	add		x4, x5, x4	# 1555
	flw		f2, 0(x4)	# 1555
	fmul	f2, f2, f0	# 1555
	lui		x4, 1	# 1555
	ori		x4, x0, 1	# 1555
	mul		x4, x4, 8	# 1555
	add		x4, x6, x4	# 1555
	flw		f3, 0(x4)	# 1555
	fadd	f2, f2, f3	# 1555
	lui		x4, 2	# 1556
	ori		x4, x0, 2	# 1556
	mul		x4, x4, 8	# 1556
	add		x4, x5, x4	# 1556
	flw		f3, 0(x4)	# 1556
	fmul	f3, f3, f0	# 1556
	lui		x4, 2	# 1556
	ori		x4, x0, 2	# 1556
	mul		x4, x4, 8	# 1556
	add		x4, x6, x4	# 1556
	flw		f4, 0(x4)	# 1556
	fadd	f3, f3, f4	# 1556
	lui		x4, 0	# 1557
	ori		x4, x0, 0	# 1557
	lw		x5, 44(x2)	# 1557
	lw		x27, 12(x2)	# 1557
	fsw		f3, 72(x2)	# 1557
	fsw		f2, 80(x2)	# 1557
	fsw		f1, 88(x2)	# 1557
	fsw		f0, 96(x2)	# 1557
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	fsub	f1, f1, f1
	fadd	f1, f1, f2
	fsub	f2, f2, f2
	fadd	f2, f2, f3
	sw		x1, 108(x2)
	addi	x2, x2, 112
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -112
	lw		x1, 108(x2)
	addi	x4, x10, 0	# 1557
	lui		x5, 0	# 1557
	ori		x5, x0, 0	# 1557
	beq		x4, x5, beq.9840	# 1557
	lui		x4, 0	# 1559
	ori		x4, x0, 0	# 1559
	mul		x4, x4, 8	# 1559
	lw		x5, 20(x2)	# 1559
	add		x4, x5, x4	# 1559
	flw		f0, 96(x2)	# 1559
	fsw		f0, 0(x4)	# 1559
	flw		f0, 88(x2)	# 1560
	flw		f1, 80(x2)	# 1560
	flw		f2, 72(x2)	# 1560
	lw		x4, 8(x2)	# 1560
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, vecset.2517
	addi	x2, x2, -112
	lw		x1, 108(x2)
	lui		x4, 0	# 1561
	ori		x4, x0, 0	# 1561
	mul		x4, x4, 4	# 1561
	lw		x5, 4(x2)	# 1561
	add		x4, x5, x4	# 1561
	lw		x5, 56(x2)	# 1561
	sw		x5, 0(x4)	# 1561
	lui		x4, 0	# 1562
	ori		x4, x0, 0	# 1562
	mul		x4, x4, 4	# 1562
	lw		x5, 0(x2)	# 1562
	add		x4, x5, x4	# 1562
	lw		x5, 60(x2)	# 1562
	sw		x5, 0(x4)	# 1562
	jal		x0, beq_cont.9841	# 1557
beq.9840:
beq_cont.9841:
	jal		x0, beq_cont.9839	# 1551
beq.9838:
beq_cont.9839:
	jal		x0, beq_cont.9837	# 1550
beq.9836:
beq_cont.9837:
	lw		x4, 48(x2)	# 1568
	addi	x4, x4, 1	# 1568
	lw		x5, 44(x2)	# 1568
	lw		x6, 36(x2)	# 1568
	lw		x27, 28(x2)	# 1568
	lw		x31, 0(x27)	# 1568
	jalr	x0, x31, 0	# 1568
beq.9835:
	lw		x4, 56(x2)	# 1572
	mul		x4, x4, 4	# 1572
	lw		x5, 32(x2)	# 1572
	add		x4, x5, x4	# 1572
	lw		x4, 0(x4)	# 1572
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, o_isinvert.2561
	addi	x2, x2, -112
	lw		x1, 108(x2)
	addi	x4, x10, 0	# 1572
	lui		x5, 0	# 1572
	ori		x5, x0, 0	# 1572
	beq		x4, x5, beq.9842	# 1572
	lw		x4, 48(x2)	# 1573
	addi	x4, x4, 1	# 1573
	lw		x5, 44(x2)	# 1573
	lw		x6, 36(x2)	# 1573
	lw		x27, 28(x2)	# 1573
	lw		x31, 0(x27)	# 1573
	jalr	x0, x31, 0	# 1573
beq.9842:
	jalr	x0, x1, 0
beq.9834:
	jalr	x0, x1, 0
solve_one_or_network_fast.2805:
	lw		x7, 8(x27)	# 1580
	lw		x8, 4(x27)	# 1580
	mul		x9, x4, 4	# 1580
	add		x9, x5, x9	# 1580
	lw		x9, 0(x9)	# 1580
	lui		x11, -1	# 1581
	ori		x11, x0, -1	# 1581
	beq		x9, x11, beq.9845	# 1581
	mul		x9, x9, 4	# 1582
	add		x8, x8, x9	# 1582
	lw		x8, 0(x8)	# 1582
	lui		x9, 0	# 1583
	ori		x9, x0, 0	# 1583
	sw		x6, 0(x2)	# 1583
	sw		x5, 4(x2)	# 1583
	sw		x27, 8(x2)	# 1583
	sw		x4, 12(x2)	# 1583
	addi	x5, x8, 0
	addi	x4, x9, 0
	addi	x27, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lw		x4, 12(x2)	# 1584
	addi	x4, x4, 1	# 1584
	lw		x5, 4(x2)	# 1584
	lw		x6, 0(x2)	# 1584
	lw		x27, 8(x2)	# 1584
	lw		x31, 0(x27)	# 1584
	jalr	x0, x31, 0	# 1584
beq.9845:
	jalr	x0, x1, 0
trace_or_matrix_fast.2809:
	lw		x7, 16(x27)	# 1590
	lw		x8, 12(x27)	# 1590
	lw		x9, 8(x27)	# 1590
	lw		x11, 4(x27)	# 1590
	mul		x12, x4, 4	# 1590
	add		x12, x5, x12	# 1590
	lw		x12, 0(x12)	# 1590
	lui		x13, 0	# 1591
	ori		x13, x0, 0	# 1591
	mul		x13, x13, 4	# 1591
	add		x13, x12, x13	# 1591
	lw		x13, 0(x13)	# 1591
	lui		x14, -1	# 1592
	ori		x14, x0, -1	# 1592
	beq		x13, x14, beq.9847	# 1592
	lui		x14, 99	# 1595
	ori		x14, x0, 99	# 1595
	sw		x6, 0(x2)	# 1595
	sw		x5, 4(x2)	# 1595
	sw		x27, 8(x2)	# 1595
	sw		x4, 12(x2)	# 1595
	beq		x13, x14, beq.9848	# 1595
	sw		x12, 16(x2)	# 1600
	sw		x11, 20(x2)	# 1600
	sw		x7, 24(x2)	# 1600
	sw		x9, 28(x2)	# 1600
	addi	x5, x6, 0
	addi	x4, x13, 0
	addi	x27, x8, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1600
	lui		x5, 0	# 1601
	ori		x5, x0, 0	# 1601
	beq		x4, x5, beq.9850	# 1601
	lui		x4, 0	# 1602
	ori		x4, x0, 0	# 1602
	mul		x4, x4, 8	# 1602
	lw		x5, 28(x2)	# 1602
	add		x4, x5, x4	# 1602
	flw		f0, 0(x4)	# 1602
	lui		x4, 0	# 1603
	ori		x4, x0, 0	# 1603
	mul		x4, x4, 8	# 1603
	lw		x5, 24(x2)	# 1603
	add		x4, x5, x4	# 1603
	flw		f1, 0(x4)	# 1603
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fless.2453
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1603
	lui		x5, 0	# 1603
	ori		x5, x0, 0	# 1603
	beq		x4, x5, beq.9852	# 1603
	lui		x4, 1	# 1604
	ori		x4, x0, 1	# 1604
	lw		x5, 16(x2)	# 1604
	lw		x6, 0(x2)	# 1604
	lw		x27, 20(x2)	# 1604
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	jal		x0, beq_cont.9853	# 1603
beq.9852:
beq_cont.9853:
	jal		x0, beq_cont.9851	# 1601
beq.9850:
beq_cont.9851:
	jal		x0, beq_cont.9849	# 1595
beq.9848:
	lui		x7, 1	# 1596
	ori		x7, x0, 1	# 1596
	addi	x5, x12, 0
	addi	x4, x7, 0
	addi	x27, x11, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
beq_cont.9849:
	lw		x4, 12(x2)	# 1608
	addi	x4, x4, 1	# 1608
	lw		x5, 4(x2)	# 1608
	lw		x6, 0(x2)	# 1608
	lw		x27, 8(x2)	# 1608
	lw		x31, 0(x27)	# 1608
	jalr	x0, x31, 0	# 1608
beq.9847:
	jalr	x0, x1, 0
judge_intersection_fast.2813:
	lw		x5, 12(x27)	# 1615
	lw		x6, 8(x27)	# 1615
	lw		x7, 4(x27)	# 1615
	lui		x8, 0	# 1615
	ori		x8, x0, 0	# 1615
	lui		x9, %hi(l.6812)	# 1615
	ori		x9, %lo(l.6812)	# 1615
	flw		f0, 0(x9)	# 1615
	mul		x8, x8, 8	# 1615
	add		x8, x6, x8	# 1615
	fsw		f0, 0(x8)	# 1615
	lui		x8, 0	# 1616
	ori		x8, x0, 0	# 1616
	lui		x9, 0	# 1616
	ori		x9, x0, 0	# 1616
	mul		x9, x9, 4	# 1616
	add		x7, x7, x9	# 1616
	lw		x7, 0(x7)	# 1616
	sw		x6, 0(x2)	# 1616
	addi	x6, x4, 0
	addi	x27, x5, 0
	addi	x5, x7, 0
	addi	x4, x8, 0
	sw		x1, 4(x2)
	addi	x2, x2, 8
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 0	# 1617
	ori		x4, x0, 0	# 1617
	mul		x4, x4, 8	# 1617
	lw		x5, 0(x2)	# 1617
	add		x4, x5, x4	# 1617
	flw		f1, 0(x4)	# 1617
	lui		x4, %hi(l.6770)	# 1619
	ori		x4, %lo(l.6770)	# 1619
	flw		f0, 0(x4)	# 1619
	fsw		f1, 8(x2)	# 1619
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fless.2453
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1619
	lui		x5, 0	# 1619
	ori		x5, x0, 0	# 1619
	beq		x4, x5, beq.9856	# 1619
	lui		x4, %hi(l.6821)	# 1620
	ori		x4, %lo(l.6821)	# 1620
	flw		f1, 0(x4)	# 1620
	flw		f0, 8(x2)	# 1620
	jal		x0, fless.2453	# 1620
beq.9856:
	lui		x10, 0	# 1621
	ori		x10, x0, 0	# 1621
	jalr	x0, x1, 0
get_nvector_rect.2815:
	lw		x5, 8(x27)	# 1635
	lw		x6, 4(x27)	# 1635
	lui		x7, 0	# 1635
	ori		x7, x0, 0	# 1635
	mul		x7, x7, 4	# 1635
	add		x6, x6, x7	# 1635
	lw		x6, 0(x6)	# 1635
	sw		x5, 0(x2)	# 1637
	sw		x4, 4(x2)	# 1637
	sw		x6, 8(x2)	# 1637
	addi	x4, x5, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, vecbzero.2525
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 1	# 1638
	ori		x4, x0, 1	# 1638
	lw		x5, 8(x2)	# 1638
	sub		x4, x5, x4	# 1638
	lui		x6, 1	# 1638
	ori		x6, x0, 1	# 1638
	sub		x5, x5, x6	# 1638
	mul		x5, x5, 8	# 1638
	lw		x6, 4(x2)	# 1638
	add		x5, x6, x5	# 1638
	flw		f0, 0(x5)	# 1638
	sw		x4, 12(x2)	# 1638
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, sgn.2509
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 1638
	fadd	f0, f0, f10	# 1638
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fneg.2449
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 1638
	fadd	f0, f0, f10	# 1638
	lw		x4, 12(x2)	# 1638
	mul		x4, x4, 8	# 1638
	lw		x5, 0(x2)	# 1638
	add		x4, x5, x4	# 1638
	fsw		f0, 0(x4)	# 1638
	jalr	x0, x1, 0
get_nvector_plane.2817:
	lw		x5, 4(x27)	# 1644
	lui		x6, 0	# 1644
	ori		x6, x0, 0	# 1644
	sw		x4, 0(x2)	# 1644
	sw		x5, 4(x2)	# 1644
	sw		x6, 8(x2)	# 1644
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, o_param_a.2565
	addi	x2, x2, -16
	lw		x1, 12(x2)
	fsub	f0, f0, f0	# 1644
	fadd	f0, f0, f10	# 1644
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, fneg.2449
	addi	x2, x2, -16
	lw		x1, 12(x2)
	fsub	f0, f0, f0	# 1644
	fadd	f0, f0, f10	# 1644
	lw		x4, 8(x2)	# 1644
	mul		x4, x4, 8	# 1644
	lw		x5, 4(x2)	# 1644
	add		x4, x5, x4	# 1644
	fsw		f0, 0(x4)	# 1644
	lui		x4, 1	# 1645
	ori		x4, x0, 1	# 1645
	lw		x6, 0(x2)	# 1645
	sw		x4, 12(x2)	# 1645
	addi	x4, x6, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_param_b.2567
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 1645
	fadd	f0, f0, f10	# 1645
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fneg.2449
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 1645
	fadd	f0, f0, f10	# 1645
	lw		x4, 12(x2)	# 1645
	mul		x4, x4, 8	# 1645
	lw		x5, 4(x2)	# 1645
	add		x4, x5, x4	# 1645
	fsw		f0, 0(x4)	# 1645
	lui		x4, 2	# 1646
	ori		x4, x0, 2	# 1646
	lw		x6, 0(x2)	# 1646
	sw		x4, 16(x2)	# 1646
	addi	x4, x6, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_param_c.2569
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 1646
	fadd	f0, f0, f10	# 1646
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fneg.2449
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 1646
	fadd	f0, f0, f10	# 1646
	lw		x4, 16(x2)	# 1646
	mul		x4, x4, 8	# 1646
	lw		x5, 4(x2)	# 1646
	add		x4, x5, x4	# 1646
	fsw		f0, 0(x4)	# 1646
	jalr	x0, x1, 0
get_nvector_second.2819:
	lw		x5, 8(x27)	# 1651
	lw		x6, 4(x27)	# 1651
	lui		x7, 0	# 1651
	ori		x7, x0, 0	# 1651
	mul		x7, x7, 8	# 1651
	add		x7, x6, x7	# 1651
	flw		f0, 0(x7)	# 1651
	sw		x5, 0(x2)	# 1651
	sw		x4, 4(x2)	# 1651
	sw		x6, 8(x2)	# 1651
	fsw		f0, 16(x2)	# 1651
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, o_param_x.2573
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 1651
	fadd	f0, f0, f10	# 1651
	flw		f1, 16(x2)	# 1651
	fsub	f0, f1, f0	# 1651
	lui		x4, 1	# 1652
	ori		x4, x0, 1	# 1652
	mul		x4, x4, 8	# 1652
	lw		x5, 8(x2)	# 1652
	add		x4, x5, x4	# 1652
	flw		f1, 0(x4)	# 1652
	lw		x4, 4(x2)	# 1652
	fsw		f0, 24(x2)	# 1652
	fsw		f1, 32(x2)	# 1652
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_param_y.2575
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 1652
	fadd	f0, f0, f10	# 1652
	flw		f1, 32(x2)	# 1652
	fsub	f0, f1, f0	# 1652
	lui		x4, 2	# 1653
	ori		x4, x0, 2	# 1653
	mul		x4, x4, 8	# 1653
	lw		x5, 8(x2)	# 1653
	add		x4, x5, x4	# 1653
	flw		f1, 0(x4)	# 1653
	lw		x4, 4(x2)	# 1653
	fsw		f0, 40(x2)	# 1653
	fsw		f1, 48(x2)	# 1653
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_param_z.2577
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1653
	fadd	f0, f0, f10	# 1653
	flw		f1, 48(x2)	# 1653
	fsub	f0, f1, f0	# 1653
	lw		x4, 4(x2)	# 1655
	fsw		f0, 56(x2)	# 1655
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, o_param_a.2565
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1655
	fadd	f0, f0, f10	# 1655
	flw		f1, 24(x2)	# 1655
	fmul	f0, f1, f0	# 1655
	lw		x4, 4(x2)	# 1656
	fsw		f0, 64(x2)	# 1656
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_b.2567
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1656
	fadd	f0, f0, f10	# 1656
	flw		f1, 40(x2)	# 1656
	fmul	f0, f1, f0	# 1656
	lw		x4, 4(x2)	# 1657
	fsw		f0, 72(x2)	# 1657
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, o_param_c.2569
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1657
	fadd	f0, f0, f10	# 1657
	flw		f1, 56(x2)	# 1657
	fmul	f0, f1, f0	# 1657
	lw		x4, 4(x2)	# 1659
	fsw		f0, 80(x2)	# 1659
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, o_isrot.2563
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 1659
	lui		x5, 0	# 1659
	ori		x5, x0, 0	# 1659
	beq		x4, x5, beq.9860	# 1659
	lui		x4, 0	# 1664
	ori		x4, x0, 0	# 1664
	lw		x5, 4(x2)	# 1664
	sw		x4, 88(x2)	# 1664
	addi	x4, x5, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, o_param_r3.2593
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 1664
	fadd	f0, f0, f10	# 1664
	flw		f1, 40(x2)	# 1664
	fmul	f0, f1, f0	# 1664
	lw		x4, 4(x2)	# 1664
	fsw		f0, 96(x2)	# 1664
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, o_param_r2.2591
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1664
	fadd	f0, f0, f10	# 1664
	flw		f1, 56(x2)	# 1664
	fmul	f0, f1, f0	# 1664
	flw		f2, 96(x2)	# 1664
	fadd	f0, f2, f0	# 1664
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, fhalf.2456
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1664
	fadd	f0, f0, f10	# 1664
	flw		f1, 64(x2)	# 1664
	fadd	f0, f1, f0	# 1664
	lw		x4, 88(x2)	# 1664
	mul		x4, x4, 8	# 1664
	lw		x5, 0(x2)	# 1664
	add		x4, x5, x4	# 1664
	fsw		f0, 0(x4)	# 1664
	lui		x4, 1	# 1665
	ori		x4, x0, 1	# 1665
	lw		x6, 4(x2)	# 1665
	sw		x4, 104(x2)	# 1665
	addi	x4, x6, 0
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, o_param_r3.2593
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1665
	fadd	f0, f0, f10	# 1665
	flw		f1, 24(x2)	# 1665
	fmul	f0, f1, f0	# 1665
	lw		x4, 4(x2)	# 1665
	fsw		f0, 112(x2)	# 1665
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, o_param_r1.2589
	addi	x2, x2, -128
	lw		x1, 124(x2)
	fsub	f0, f0, f0	# 1665
	fadd	f0, f0, f10	# 1665
	flw		f1, 56(x2)	# 1665
	fmul	f0, f1, f0	# 1665
	flw		f1, 112(x2)	# 1665
	fadd	f0, f1, f0	# 1665
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, fhalf.2456
	addi	x2, x2, -128
	lw		x1, 124(x2)
	fsub	f0, f0, f0	# 1665
	fadd	f0, f0, f10	# 1665
	flw		f1, 72(x2)	# 1665
	fadd	f0, f1, f0	# 1665
	lw		x4, 104(x2)	# 1665
	mul		x4, x4, 8	# 1665
	lw		x5, 0(x2)	# 1665
	add		x4, x5, x4	# 1665
	fsw		f0, 0(x4)	# 1665
	lui		x4, 2	# 1666
	ori		x4, x0, 2	# 1666
	lw		x6, 4(x2)	# 1666
	sw		x4, 120(x2)	# 1666
	addi	x4, x6, 0
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, o_param_r2.2591
	addi	x2, x2, -128
	lw		x1, 124(x2)
	fsub	f0, f0, f0	# 1666
	fadd	f0, f0, f10	# 1666
	flw		f1, 24(x2)	# 1666
	fmul	f0, f1, f0	# 1666
	lw		x4, 4(x2)	# 1666
	fsw		f0, 128(x2)	# 1666
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, o_param_r1.2589
	addi	x2, x2, -144
	lw		x1, 140(x2)
	fsub	f0, f0, f0	# 1666
	fadd	f0, f0, f10	# 1666
	flw		f1, 40(x2)	# 1666
	fmul	f0, f1, f0	# 1666
	flw		f1, 128(x2)	# 1666
	fadd	f0, f1, f0	# 1666
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, fhalf.2456
	addi	x2, x2, -144
	lw		x1, 140(x2)
	fsub	f0, f0, f0	# 1666
	fadd	f0, f0, f10	# 1666
	flw		f1, 80(x2)	# 1666
	fadd	f0, f1, f0	# 1666
	lw		x4, 120(x2)	# 1666
	mul		x4, x4, 8	# 1666
	lw		x5, 0(x2)	# 1666
	add		x4, x5, x4	# 1666
	fsw		f0, 0(x4)	# 1666
	jal		x0, beq_cont.9861	# 1659
beq.9860:
	lui		x4, 0	# 1660
	ori		x4, x0, 0	# 1660
	mul		x4, x4, 8	# 1660
	lw		x5, 0(x2)	# 1660
	add		x4, x5, x4	# 1660
	flw		f0, 64(x2)	# 1660
	fsw		f0, 0(x4)	# 1660
	lui		x4, 1	# 1661
	ori		x4, x0, 1	# 1661
	mul		x4, x4, 8	# 1661
	add		x4, x5, x4	# 1661
	flw		f0, 72(x2)	# 1661
	fsw		f0, 0(x4)	# 1661
	lui		x4, 2	# 1662
	ori		x4, x0, 2	# 1662
	mul		x4, x4, 8	# 1662
	add		x4, x5, x4	# 1662
	flw		f0, 80(x2)	# 1662
	fsw		f0, 0(x4)	# 1662
beq_cont.9861:
	lw		x4, 4(x2)	# 1668
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, o_isinvert.2561
	addi	x2, x2, -144
	lw		x1, 140(x2)
	addi	x5, x10, 0	# 1668
	lw		x4, 0(x2)	# 1668
	jal		x0, vecunit_sgn.2530	# 1668
get_nvector.2821:
	lw		x6, 12(x27)	# 1673
	lw		x7, 8(x27)	# 1673
	lw		x8, 4(x27)	# 1673
	sw		x6, 0(x2)	# 1673
	sw		x4, 4(x2)	# 1673
	sw		x8, 8(x2)	# 1673
	sw		x5, 12(x2)	# 1673
	sw		x7, 16(x2)	# 1673
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_form.2557
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1673
	lui		x5, 1	# 1674
	ori		x5, x0, 1	# 1674
	beq		x4, x5, beq.9865	# 1674
	lui		x5, 2	# 1676
	ori		x5, x0, 2	# 1676
	beq		x4, x5, beq.9866	# 1676
	lw		x4, 4(x2)	# 1679
	lw		x27, 0(x2)	# 1679
	lw		x31, 0(x27)	# 1679
	jalr	x0, x31, 0	# 1679
beq.9866:
	lw		x4, 4(x2)	# 1677
	lw		x27, 8(x2)	# 1677
	lw		x31, 0(x27)	# 1677
	jalr	x0, x31, 0	# 1677
beq.9865:
	lw		x4, 12(x2)	# 1675
	lw		x27, 16(x2)	# 1675
	lw		x31, 0(x27)	# 1675
	jalr	x0, x31, 0	# 1675
utexture.2824:
	lw		x6, 16(x27)	# 1689
	lw		x7, 12(x27)	# 1689
	lw		x8, 8(x27)	# 1689
	lw		x9, 4(x27)	# 1689
	sw		x9, 0(x2)	# 1689
	sw		x8, 4(x2)	# 1689
	sw		x7, 8(x2)	# 1689
	sw		x5, 12(x2)	# 1689
	sw		x6, 16(x2)	# 1689
	sw		x4, 20(x2)	# 1689
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, o_texturetype.2555
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1689
	lui		x5, 0	# 1691
	ori		x5, x0, 0	# 1691
	lw		x6, 20(x2)	# 1691
	sw		x4, 24(x2)	# 1691
	sw		x5, 28(x2)	# 1691
	addi	x4, x6, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_color_red.2583
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1691
	fadd	f0, f0, f10	# 1691
	lw		x4, 28(x2)	# 1691
	mul		x4, x4, 8	# 1691
	lw		x5, 16(x2)	# 1691
	add		x4, x5, x4	# 1691
	fsw		f0, 0(x4)	# 1691
	lui		x4, 1	# 1692
	ori		x4, x0, 1	# 1692
	lw		x6, 20(x2)	# 1692
	sw		x4, 32(x2)	# 1692
	addi	x4, x6, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_color_green.2585
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1692
	fadd	f0, f0, f10	# 1692
	lw		x4, 32(x2)	# 1692
	mul		x4, x4, 8	# 1692
	lw		x5, 16(x2)	# 1692
	add		x4, x5, x4	# 1692
	fsw		f0, 0(x4)	# 1692
	lui		x4, 2	# 1693
	ori		x4, x0, 2	# 1693
	lw		x6, 20(x2)	# 1693
	sw		x4, 36(x2)	# 1693
	addi	x4, x6, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_color_blue.2587
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 1693
	fadd	f0, f0, f10	# 1693
	lw		x4, 36(x2)	# 1693
	mul		x4, x4, 8	# 1693
	lw		x5, 16(x2)	# 1693
	add		x4, x5, x4	# 1693
	fsw		f0, 0(x4)	# 1693
	lui		x4, 1	# 1694
	ori		x4, x0, 1	# 1694
	lw		x6, 24(x2)	# 1694
	beq		x6, x4, beq.9867	# 1694
	lui		x4, 2	# 1712
	ori		x4, x0, 2	# 1712
	beq		x6, x4, beq.9868	# 1712
	lui		x4, 3	# 1719
	ori		x4, x0, 3	# 1719
	beq		x6, x4, beq.9869	# 1719
	lui		x4, 4	# 1730
	ori		x4, x0, 4	# 1730
	beq		x6, x4, beq.9870	# 1730
	jalr	x0, x1, 0
beq.9870:
	lui		x4, 0	# 1732
	ori		x4, x0, 0	# 1732
	mul		x4, x4, 8	# 1732
	lw		x6, 12(x2)	# 1732
	add		x4, x6, x4	# 1732
	flw		f0, 0(x4)	# 1732
	lw		x4, 20(x2)	# 1732
	fsw		f0, 40(x2)	# 1732
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, o_param_x.2573
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 1732
	fadd	f0, f0, f10	# 1732
	flw		f1, 40(x2)	# 1732
	fsub	f0, f1, f0	# 1732
	lw		x4, 20(x2)	# 1732
	fsw		f0, 48(x2)	# 1732
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_param_a.2565
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1732
	fadd	f0, f0, f10	# 1732
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, min_caml_sqrt
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1732
	fadd	f0, f0, f10	# 1732
	flw		f1, 48(x2)	# 1732
	fmul	f0, f1, f0	# 1732
	lui		x4, 2	# 1733
	ori		x4, x0, 2	# 1733
	mul		x4, x4, 8	# 1733
	lw		x5, 12(x2)	# 1733
	add		x4, x5, x4	# 1733
	flw		f1, 0(x4)	# 1733
	lw		x4, 20(x2)	# 1733
	fsw		f0, 56(x2)	# 1733
	fsw		f1, 64(x2)	# 1733
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_z.2577
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 1733
	fadd	f0, f0, f10	# 1733
	flw		f1, 64(x2)	# 1733
	fsub	f0, f1, f0	# 1733
	lw		x4, 20(x2)	# 1733
	fsw		f0, 72(x2)	# 1733
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, o_param_c.2569
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1733
	fadd	f0, f0, f10	# 1733
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, min_caml_sqrt
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1733
	fadd	f0, f0, f10	# 1733
	flw		f1, 72(x2)	# 1733
	fmul	f0, f1, f0	# 1733
	flw		f1, 56(x2)	# 1734
	fsw		f0, 80(x2)	# 1734
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, fsqr.2458
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 1734
	fadd	f0, f0, f10	# 1734
	flw		f1, 80(x2)	# 1734
	fsw		f0, 88(x2)	# 1734
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, fsqr.2458
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f0, f0, f0	# 1734
	fadd	f0, f0, f10	# 1734
	flw		f1, 88(x2)	# 1734
	fadd	f0, f1, f0	# 1734
	flw		f1, 56(x2)	# 1736
	fsw		f0, 96(x2)	# 1736
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, fabs.2451
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1736
	fadd	f0, f0, f10	# 1736
	lui		x4, %hi(l.6912)	# 1736
	ori		x4, %lo(l.6912)	# 1736
	flw		f1, 0(x4)	# 1736
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, fless.2453
	addi	x2, x2, -112
	lw		x1, 108(x2)
	addi	x4, x10, 0	# 1736
	lui		x5, 0	# 1736
	ori		x5, x0, 0	# 1736
	beq		x4, x5, beq.9872	# 1736
	lui		x4, %hi(l.6914)	# 1737
	ori		x4, %lo(l.6914)	# 1737
	flw		f0, 0(x4)	# 1737
	jal		x0, beq_cont.9873	# 1736
beq.9872:
	flw		f0, 56(x2)	# 1739
	flw		f1, 80(x2)	# 1739
	fdiv	f0, f1, f0	# 1739
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, fabs.2451
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1739
	fadd	f0, f0, f10	# 1739
	lw		x27, 0(x2)	# 1741
	sw		x1, 108(x2)
	addi	x2, x2, 112
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -112
	lw		x1, 108(x2)
	fsub	f0, f0, f0	# 1741
	fadd	f0, f0, f10	# 1741
	lui		x4, %hi(l.6916)	# 1741
	ori		x4, %lo(l.6916)	# 1741
	flw		f1, 0(x4)	# 1741
	fmul	f0, f0, f1	# 1741
	lui		x4, %hi(l.6918)	# 1741
	ori		x4, %lo(l.6918)	# 1741
	flw		f1, 0(x4)	# 1741
	fdiv	f0, f0, f1	# 1741
beq_cont.9873:
	fsw		f0, 104(x2)	# 1743
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, floor.2460
	addi	x2, x2, -120
	lw		x1, 116(x2)
	fsub	f0, f0, f0	# 1743
	fadd	f0, f0, f10	# 1743
	flw		f1, 104(x2)	# 1743
	fsub	f0, f1, f0	# 1743
	lui		x4, 1	# 1745
	ori		x4, x0, 1	# 1745
	mul		x4, x4, 8	# 1745
	lw		x5, 12(x2)	# 1745
	add		x4, x5, x4	# 1745
	flw		f1, 0(x4)	# 1745
	lw		x4, 20(x2)	# 1745
	fsw		f0, 112(x2)	# 1745
	fsw		f1, 120(x2)	# 1745
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, o_param_y.2575
	addi	x2, x2, -136
	lw		x1, 132(x2)
	fsub	f0, f0, f0	# 1745
	fadd	f0, f0, f10	# 1745
	flw		f1, 120(x2)	# 1745
	fsub	f0, f1, f0	# 1745
	lw		x4, 20(x2)	# 1745
	fsw		f0, 128(x2)	# 1745
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, o_param_b.2567
	addi	x2, x2, -144
	lw		x1, 140(x2)
	fsub	f0, f0, f0	# 1745
	fadd	f0, f0, f10	# 1745
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, min_caml_sqrt
	addi	x2, x2, -144
	lw		x1, 140(x2)
	fsub	f0, f0, f0	# 1745
	fadd	f0, f0, f10	# 1745
	flw		f1, 128(x2)	# 1745
	fmul	f0, f1, f0	# 1745
	flw		f1, 96(x2)	# 1747
	fsw		f0, 136(x2)	# 1747
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, fabs.2451
	addi	x2, x2, -152
	lw		x1, 148(x2)
	fsub	f0, f0, f0	# 1747
	fadd	f0, f0, f10	# 1747
	lui		x4, %hi(l.6912)	# 1747
	ori		x4, %lo(l.6912)	# 1747
	flw		f1, 0(x4)	# 1747
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, fless.2453
	addi	x2, x2, -152
	lw		x1, 148(x2)
	addi	x4, x10, 0	# 1747
	lui		x5, 0	# 1747
	ori		x5, x0, 0	# 1747
	beq		x4, x5, beq.9874	# 1747
	lui		x4, %hi(l.6914)	# 1748
	ori		x4, %lo(l.6914)	# 1748
	flw		f0, 0(x4)	# 1748
	jal		x0, beq_cont.9875	# 1747
beq.9874:
	flw		f0, 96(x2)	# 1750
	flw		f1, 136(x2)	# 1750
	fdiv	f0, f1, f0	# 1750
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, fabs.2451
	addi	x2, x2, -152
	lw		x1, 148(x2)
	fsub	f0, f0, f0	# 1750
	fadd	f0, f0, f10	# 1750
	lw		x27, 0(x2)	# 1751
	sw		x1, 148(x2)
	addi	x2, x2, 152
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -152
	lw		x1, 148(x2)
	fsub	f0, f0, f0	# 1751
	fadd	f0, f0, f10	# 1751
	lui		x4, %hi(l.6916)	# 1751
	ori		x4, %lo(l.6916)	# 1751
	flw		f1, 0(x4)	# 1751
	fmul	f0, f0, f1	# 1751
	lui		x4, %hi(l.6918)	# 1751
	ori		x4, %lo(l.6918)	# 1751
	flw		f1, 0(x4)	# 1751
	fdiv	f0, f0, f1	# 1751
beq_cont.9875:
	fsw		f0, 144(x2)	# 1753
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, floor.2460
	addi	x2, x2, -160
	lw		x1, 156(x2)
	fsub	f0, f0, f0	# 1753
	fadd	f0, f0, f10	# 1753
	flw		f1, 144(x2)	# 1753
	fsub	f0, f1, f0	# 1753
	lui		x4, %hi(l.6926)	# 1754
	ori		x4, %lo(l.6926)	# 1754
	flw		f1, 0(x4)	# 1754
	lui		x4, %hi(l.6060)	# 1754
	ori		x4, %lo(l.6060)	# 1754
	flw		f2, 0(x4)	# 1754
	flw		f3, 112(x2)	# 1754
	fsub	f2, f2, f3	# 1754
	fsw		f0, 152(x2)	# 1754
	fsw		f1, 160(x2)	# 1754
	fsub	f0, f0, f0
	fadd	f0, f0, f2
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, fsqr.2458
	addi	x2, x2, -176
	lw		x1, 172(x2)
	fsub	f0, f0, f0	# 1754
	fadd	f0, f0, f10	# 1754
	flw		f1, 160(x2)	# 1754
	fsub	f0, f1, f0	# 1754
	lui		x4, %hi(l.6060)	# 1754
	ori		x4, %lo(l.6060)	# 1754
	flw		f1, 0(x4)	# 1754
	flw		f2, 152(x2)	# 1754
	fsub	f1, f1, f2	# 1754
	fsw		f0, 168(x2)	# 1754
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 180(x2)
	addi	x2, x2, 184
	jal		x1, fsqr.2458
	addi	x2, x2, -184
	lw		x1, 180(x2)
	fsub	f0, f0, f0	# 1754
	fadd	f0, f0, f10	# 1754
	flw		f1, 168(x2)	# 1754
	fsub	f0, f1, f0	# 1754
	fsw		f0, 176(x2)	# 1755
	sw		x1, 188(x2)
	addi	x2, x2, 192
	jal		x1, fisneg.2447
	addi	x2, x2, -192
	lw		x1, 188(x2)
	addi	x4, x10, 0	# 1755
	lui		x5, 0	# 1755
	ori		x5, x0, 0	# 1755
	beq		x4, x5, beq.9876	# 1755
	lui		x4, %hi(l.6055)	# 1755
	ori		x4, %lo(l.6055)	# 1755
	flw		f0, 0(x4)	# 1755
	jal		x0, beq_cont.9877	# 1755
beq.9876:
	flw		f0, 176(x2)	# 1755
beq_cont.9877:
	lui		x4, 2	# 1756
	ori		x4, x0, 2	# 1756
	lui		x5, %hi(l.6931)	# 1756
	ori		x5, %lo(l.6931)	# 1756
	flw		f1, 0(x5)	# 1756
	fmul	f0, f1, f0	# 1756
	lui		x5, %hi(l.6933)	# 1756
	ori		x5, %lo(l.6933)	# 1756
	flw		f1, 0(x5)	# 1756
	fdiv	f0, f0, f1	# 1756
	mul		x4, x4, 8	# 1756
	lw		x5, 16(x2)	# 1756
	add		x4, x5, x4	# 1756
	fsw		f0, 0(x4)	# 1756
	jalr	x0, x1, 0
beq.9869:
	lui		x4, 0	# 1722
	ori		x4, x0, 0	# 1722
	mul		x4, x4, 8	# 1722
	lw		x6, 12(x2)	# 1722
	add		x4, x6, x4	# 1722
	flw		f0, 0(x4)	# 1722
	lw		x4, 20(x2)	# 1722
	fsw		f0, 184(x2)	# 1722
	sw		x1, 196(x2)
	addi	x2, x2, 200
	jal		x1, o_param_x.2573
	addi	x2, x2, -200
	lw		x1, 196(x2)
	fsub	f0, f0, f0	# 1722
	fadd	f0, f0, f10	# 1722
	flw		f1, 184(x2)	# 1722
	fsub	f0, f1, f0	# 1722
	lui		x4, 2	# 1723
	ori		x4, x0, 2	# 1723
	mul		x4, x4, 8	# 1723
	lw		x5, 12(x2)	# 1723
	add		x4, x5, x4	# 1723
	flw		f1, 0(x4)	# 1723
	lw		x4, 20(x2)	# 1723
	fsw		f0, 192(x2)	# 1723
	fsw		f1, 200(x2)	# 1723
	sw		x1, 212(x2)
	addi	x2, x2, 216
	jal		x1, o_param_z.2577
	addi	x2, x2, -216
	lw		x1, 212(x2)
	fsub	f0, f0, f0	# 1723
	fadd	f0, f0, f10	# 1723
	flw		f1, 200(x2)	# 1723
	fsub	f0, f1, f0	# 1723
	flw		f1, 192(x2)	# 1724
	fsw		f0, 208(x2)	# 1724
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 220(x2)
	addi	x2, x2, 224
	jal		x1, fsqr.2458
	addi	x2, x2, -224
	lw		x1, 220(x2)
	fsub	f0, f0, f0	# 1724
	fadd	f0, f0, f10	# 1724
	flw		f1, 208(x2)	# 1724
	fsw		f0, 216(x2)	# 1724
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 228(x2)
	addi	x2, x2, 232
	jal		x1, fsqr.2458
	addi	x2, x2, -232
	lw		x1, 228(x2)
	fsub	f0, f0, f0	# 1724
	fadd	f0, f0, f10	# 1724
	flw		f1, 216(x2)	# 1724
	fadd	f0, f1, f0	# 1724
	sw		x1, 228(x2)
	addi	x2, x2, 232
	jal		x1, min_caml_sqrt
	addi	x2, x2, -232
	lw		x1, 228(x2)
	fsub	f0, f0, f0	# 1724
	fadd	f0, f0, f10	# 1724
	lui		x4, %hi(l.6941)	# 1724
	ori		x4, %lo(l.6941)	# 1724
	flw		f1, 0(x4)	# 1724
	fdiv	f0, f0, f1	# 1724
	fsw		f0, 224(x2)	# 1725
	sw		x1, 236(x2)
	addi	x2, x2, 240
	jal		x1, floor.2460
	addi	x2, x2, -240
	lw		x1, 236(x2)
	fsub	f0, f0, f0	# 1725
	fadd	f0, f0, f10	# 1725
	flw		f1, 224(x2)	# 1725
	fsub	f0, f1, f0	# 1725
	lui		x4, %hi(l.6918)	# 1725
	ori		x4, %lo(l.6918)	# 1725
	flw		f1, 0(x4)	# 1725
	fmul	f0, f0, f1	# 1725
	lw		x27, 4(x2)	# 1726
	sw		x1, 236(x2)
	addi	x2, x2, 240
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -240
	lw		x1, 236(x2)
	fsub	f0, f0, f0	# 1726
	fadd	f0, f0, f10	# 1726
	sw		x1, 236(x2)
	addi	x2, x2, 240
	jal		x1, fsqr.2458
	addi	x2, x2, -240
	lw		x1, 236(x2)
	fsub	f0, f0, f0	# 1726
	fadd	f0, f0, f10	# 1726
	lui		x4, 1	# 1727
	ori		x4, x0, 1	# 1727
	lui		x5, %hi(l.6931)	# 1727
	ori		x5, %lo(l.6931)	# 1727
	flw		f1, 0(x5)	# 1727
	fmul	f1, f0, f1	# 1727
	mul		x4, x4, 8	# 1727
	lw		x5, 16(x2)	# 1727
	add		x4, x5, x4	# 1727
	fsw		f1, 0(x4)	# 1727
	lui		x4, 2	# 1728
	ori		x4, x0, 2	# 1728
	lui		x6, %hi(l.6062)	# 1728
	ori		x6, %lo(l.6062)	# 1728
	flw		f1, 0(x6)	# 1728
	fsub	f0, f1, f0	# 1728
	lui		x6, %hi(l.6931)	# 1728
	ori		x6, %lo(l.6931)	# 1728
	flw		f1, 0(x6)	# 1728
	fmul	f0, f0, f1	# 1728
	mul		x4, x4, 8	# 1728
	add		x4, x5, x4	# 1728
	fsw		f0, 0(x4)	# 1728
	jalr	x0, x1, 0
beq.9868:
	lui		x4, 1	# 1715
	ori		x4, x0, 1	# 1715
	mul		x4, x4, 8	# 1715
	lw		x6, 12(x2)	# 1715
	add		x4, x6, x4	# 1715
	flw		f0, 0(x4)	# 1715
	lui		x4, %hi(l.6953)	# 1715
	ori		x4, %lo(l.6953)	# 1715
	flw		f1, 0(x4)	# 1715
	fmul	f0, f0, f1	# 1715
	lw		x27, 8(x2)	# 1715
	sw		x1, 236(x2)
	addi	x2, x2, 240
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -240
	lw		x1, 236(x2)
	fsub	f0, f0, f0	# 1715
	fadd	f0, f0, f10	# 1715
	sw		x1, 236(x2)
	addi	x2, x2, 240
	jal		x1, fsqr.2458
	addi	x2, x2, -240
	lw		x1, 236(x2)
	fsub	f0, f0, f0	# 1715
	fadd	f0, f0, f10	# 1715
	lui		x4, 0	# 1716
	ori		x4, x0, 0	# 1716
	lui		x5, %hi(l.6931)	# 1716
	ori		x5, %lo(l.6931)	# 1716
	flw		f1, 0(x5)	# 1716
	fmul	f1, f1, f0	# 1716
	mul		x4, x4, 8	# 1716
	lw		x5, 16(x2)	# 1716
	add		x4, x5, x4	# 1716
	fsw		f1, 0(x4)	# 1716
	lui		x4, 1	# 1717
	ori		x4, x0, 1	# 1717
	lui		x6, %hi(l.6931)	# 1717
	ori		x6, %lo(l.6931)	# 1717
	flw		f1, 0(x6)	# 1717
	lui		x6, %hi(l.6062)	# 1717
	ori		x6, %lo(l.6062)	# 1717
	flw		f2, 0(x6)	# 1717
	fsub	f0, f2, f0	# 1717
	fmul	f0, f1, f0	# 1717
	mul		x4, x4, 8	# 1717
	add		x4, x5, x4	# 1717
	fsw		f0, 0(x4)	# 1717
	jalr	x0, x1, 0
beq.9867:
	lui		x4, 0	# 1697
	ori		x4, x0, 0	# 1697
	mul		x4, x4, 8	# 1697
	lw		x6, 12(x2)	# 1697
	add		x4, x6, x4	# 1697
	flw		f0, 0(x4)	# 1697
	lw		x4, 20(x2)	# 1697
	fsw		f0, 232(x2)	# 1697
	sw		x1, 244(x2)
	addi	x2, x2, 248
	jal		x1, o_param_x.2573
	addi	x2, x2, -248
	lw		x1, 244(x2)
	fsub	f0, f0, f0	# 1697
	fadd	f0, f0, f10	# 1697
	flw		f1, 232(x2)	# 1697
	fsub	f0, f1, f0	# 1697
	lui		x4, %hi(l.6964)	# 1699
	ori		x4, %lo(l.6964)	# 1699
	flw		f1, 0(x4)	# 1699
	fmul	f1, f0, f1	# 1699
	fsw		f0, 240(x2)	# 1699
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 252(x2)
	addi	x2, x2, 256
	jal		x1, floor.2460
	addi	x2, x2, -256
	lw		x1, 252(x2)
	fsub	f0, f0, f0	# 1699
	fadd	f0, f0, f10	# 1699
	lui		x4, %hi(l.6966)	# 1699
	ori		x4, %lo(l.6966)	# 1699
	flw		f1, 0(x4)	# 1699
	fmul	f0, f0, f1	# 1699
	flw		f1, 240(x2)	# 1700
	fsub	f0, f1, f0	# 1700
	lui		x4, %hi(l.6941)	# 1700
	ori		x4, %lo(l.6941)	# 1700
	flw		f1, 0(x4)	# 1700
	sw		x1, 252(x2)
	addi	x2, x2, 256
	jal		x1, fless.2453
	addi	x2, x2, -256
	lw		x1, 252(x2)
	addi	x4, x10, 0	# 1700
	lui		x5, 2	# 1702
	ori		x5, x0, 2	# 1702
	mul		x5, x5, 8	# 1702
	lw		x6, 12(x2)	# 1702
	add		x5, x6, x5	# 1702
	flw		f0, 0(x5)	# 1702
	lw		x5, 20(x2)	# 1702
	sw		x4, 248(x2)	# 1702
	fsw		f0, 256(x2)	# 1702
	addi	x4, x5, 0
	sw		x1, 268(x2)
	addi	x2, x2, 272
	jal		x1, o_param_z.2577
	addi	x2, x2, -272
	lw		x1, 268(x2)
	fsub	f0, f0, f0	# 1702
	fadd	f0, f0, f10	# 1702
	flw		f1, 256(x2)	# 1702
	fsub	f0, f1, f0	# 1702
	lui		x4, %hi(l.6964)	# 1704
	ori		x4, %lo(l.6964)	# 1704
	flw		f1, 0(x4)	# 1704
	fmul	f1, f0, f1	# 1704
	fsw		f0, 264(x2)	# 1704
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 276(x2)
	addi	x2, x2, 280
	jal		x1, floor.2460
	addi	x2, x2, -280
	lw		x1, 276(x2)
	fsub	f0, f0, f0	# 1704
	fadd	f0, f0, f10	# 1704
	lui		x4, %hi(l.6966)	# 1704
	ori		x4, %lo(l.6966)	# 1704
	flw		f1, 0(x4)	# 1704
	fmul	f0, f0, f1	# 1704
	flw		f1, 264(x2)	# 1705
	fsub	f0, f1, f0	# 1705
	lui		x4, %hi(l.6941)	# 1705
	ori		x4, %lo(l.6941)	# 1705
	flw		f1, 0(x4)	# 1705
	sw		x1, 276(x2)
	addi	x2, x2, 280
	jal		x1, fless.2453
	addi	x2, x2, -280
	lw		x1, 276(x2)
	addi	x4, x10, 0	# 1705
	lui		x5, 1	# 1707
	ori		x5, x0, 1	# 1707
	lui		x6, 0	# 1708
	ori		x6, x0, 0	# 1708
	lw		x7, 248(x2)	# 1708
	beq		x7, x6, beq.9882	# 1708
	lui		x6, 0	# 1709
	ori		x6, x0, 0	# 1709
	beq		x4, x6, beq.9884	# 1709
	lui		x4, %hi(l.6931)	# 1709
	ori		x4, %lo(l.6931)	# 1709
	flw		f0, 0(x4)	# 1709
	jal		x0, beq_cont.9885	# 1709
beq.9884:
	lui		x4, %hi(l.6055)	# 1709
	ori		x4, %lo(l.6055)	# 1709
	flw		f0, 0(x4)	# 1709
beq_cont.9885:
	jal		x0, beq_cont.9883	# 1708
beq.9882:
	lui		x6, 0	# 1710
	ori		x6, x0, 0	# 1710
	beq		x4, x6, beq.9886	# 1710
	lui		x4, %hi(l.6055)	# 1710
	ori		x4, %lo(l.6055)	# 1710
	flw		f0, 0(x4)	# 1710
	jal		x0, beq_cont.9887	# 1710
beq.9886:
	lui		x4, %hi(l.6931)	# 1710
	ori		x4, %lo(l.6931)	# 1710
	flw		f0, 0(x4)	# 1710
beq_cont.9887:
beq_cont.9883:
	mul		x4, x5, 8	# 1707
	lw		x5, 16(x2)	# 1707
	add		x4, x5, x4	# 1707
	fsw		f0, 0(x4)	# 1707
	jalr	x0, x1, 0
add_light.2827:
	lw		x4, 8(x27)	# 1769
	lw		x5, 4(x27)	# 1769
	fsw		f2, 0(x2)	# 1769
	fsw		f1, 8(x2)	# 1769
	fsw		f0, 16(x2)	# 1769
	sw		x4, 24(x2)	# 1769
	sw		x5, 28(x2)	# 1769
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fispos.2445
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1769
	lui		x5, 0	# 1769
	ori		x5, x0, 0	# 1769
	beq		x4, x5, beq.9889	# 1769
	flw		f0, 16(x2)	# 1770
	lw		x4, 28(x2)	# 1770
	lw		x5, 24(x2)	# 1770
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, vecaccum.2541
	addi	x2, x2, -40
	lw		x1, 36(x2)
	jal		x0, beq_cont.9890	# 1769
beq.9889:
beq_cont.9890:
	flw		f0, 8(x2)	# 1774
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fispos.2445
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1774
	lui		x5, 0	# 1774
	ori		x5, x0, 0	# 1774
	beq		x4, x5, beq.9891	# 1774
	flw		f0, 8(x2)	# 1775
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fsqr.2458
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1775
	fadd	f0, f0, f10	# 1775
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fsqr.2458
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 1775
	fadd	f0, f0, f10	# 1775
	flw		f1, 0(x2)	# 1775
	fmul	f0, f0, f1	# 1775
	lui		x4, 0	# 1776
	ori		x4, x0, 0	# 1776
	lui		x5, 0	# 1776
	ori		x5, x0, 0	# 1776
	mul		x5, x5, 8	# 1776
	lw		x6, 28(x2)	# 1776
	add		x5, x6, x5	# 1776
	flw		f1, 0(x5)	# 1776
	fadd	f1, f1, f0	# 1776
	mul		x4, x4, 8	# 1776
	add		x4, x6, x4	# 1776
	fsw		f1, 0(x4)	# 1776
	lui		x4, 1	# 1777
	ori		x4, x0, 1	# 1777
	lui		x5, 1	# 1777
	ori		x5, x0, 1	# 1777
	mul		x5, x5, 8	# 1777
	add		x5, x6, x5	# 1777
	flw		f1, 0(x5)	# 1777
	fadd	f1, f1, f0	# 1777
	mul		x4, x4, 8	# 1777
	add		x4, x6, x4	# 1777
	fsw		f1, 0(x4)	# 1777
	lui		x4, 2	# 1778
	ori		x4, x0, 2	# 1778
	lui		x5, 2	# 1778
	ori		x5, x0, 2	# 1778
	mul		x5, x5, 8	# 1778
	add		x5, x6, x5	# 1778
	flw		f1, 0(x5)	# 1778
	fadd	f0, f1, f0	# 1778
	mul		x4, x4, 8	# 1778
	add		x4, x6, x4	# 1778
	fsw		f0, 0(x4)	# 1778
	jalr	x0, x1, 0
beq.9891:
	jalr	x0, x1, 0
trace_reflections.2831:
	lw		x6, 32(x27)	# 1785
	lw		x7, 28(x27)	# 1785
	lw		x8, 24(x27)	# 1785
	lw		x9, 20(x27)	# 1785
	lw		x11, 16(x27)	# 1785
	lw		x12, 12(x27)	# 1785
	lw		x13, 8(x27)	# 1785
	lw		x14, 4(x27)	# 1785
	lui		x15, 0	# 1785
	ori		x15, x0, 0	# 1785
	ble		x15, x4, ble.9894	# 1785
	jalr	x0, x1, 0
ble.9894:
	mul		x15, x4, 4	# 1786
	add		x7, x7, x15	# 1786
	lw		x7, 0(x7)	# 1786
	sw		x27, 0(x2)	# 1787
	sw		x4, 4(x2)	# 1787
	fsw		f1, 8(x2)	# 1787
	sw		x14, 16(x2)	# 1787
	sw		x5, 20(x2)	# 1787
	fsw		f0, 24(x2)	# 1787
	sw		x9, 32(x2)	# 1787
	sw		x6, 36(x2)	# 1787
	sw		x8, 40(x2)	# 1787
	sw		x7, 44(x2)	# 1787
	sw		x12, 48(x2)	# 1787
	sw		x13, 52(x2)	# 1787
	sw		x11, 56(x2)	# 1787
	addi	x4, x7, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, r_dvec.2622
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 1787
	lw		x27, 56(x2)	# 1790
	sw		x4, 60(x2)	# 1790
	sw		x1, 68(x2)
	addi	x2, x2, 72
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 1790
	lui		x5, 0	# 1790
	ori		x5, x0, 0	# 1790
	beq		x4, x5, beq.9896	# 1790
	lui		x4, 0	# 1791
	ori		x4, x0, 0	# 1791
	mul		x4, x4, 4	# 1791
	lw		x5, 52(x2)	# 1791
	add		x4, x5, x4	# 1791
	lw		x4, 0(x4)	# 1791
	lui		x5, 4	# 1791
	ori		x5, x0, 4	# 1791
	mul		x4, x4, x5	# 1791
	lui		x5, 0	# 1791
	ori		x5, x0, 0	# 1791
	mul		x5, x5, 4	# 1791
	lw		x6, 48(x2)	# 1791
	add		x5, x6, x5	# 1791
	lw		x5, 0(x5)	# 1791
	add		x4, x4, x5	# 1791
	lw		x5, 44(x2)	# 1792
	sw		x4, 64(x2)	# 1792
	addi	x4, x5, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, r_surface_id.2620
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 1792
	lw		x5, 64(x2)	# 1792
	beq		x5, x4, beq.9898	# 1792
	jal		x0, beq_cont.9899	# 1792
beq.9898:
	lui		x4, 0	# 1794
	ori		x4, x0, 0	# 1794
	lui		x5, 0	# 1794
	ori		x5, x0, 0	# 1794
	mul		x5, x5, 4	# 1794
	lw		x6, 40(x2)	# 1794
	add		x5, x6, x5	# 1794
	lw		x5, 0(x5)	# 1794
	lw		x27, 36(x2)	# 1794
	sw		x1, 68(x2)
	addi	x2, x2, 72
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 1794
	lui		x5, 0	# 1794
	ori		x5, x0, 0	# 1794
	beq		x4, x5, beq.9900	# 1794
	jal		x0, beq_cont.9901	# 1794
beq.9900:
	lw		x4, 60(x2)	# 1796
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, d_vec.2616
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x5, x10, 0	# 1796
	lw		x4, 32(x2)	# 1796
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, veciprod.2533
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 1796
	fadd	f0, f0, f10	# 1796
	lw		x4, 44(x2)	# 1797
	fsw		f0, 72(x2)	# 1797
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, r_bright.2624
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1797
	fadd	f0, f0, f10	# 1797
	flw		f1, 24(x2)	# 1798
	fmul	f2, f0, f1	# 1798
	flw		f3, 72(x2)	# 1798
	fmul	f2, f2, f3	# 1798
	lw		x4, 60(x2)	# 1799
	fsw		f2, 80(x2)	# 1799
	fsw		f0, 88(x2)	# 1799
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, d_vec.2616
	addi	x2, x2, -104
	lw		x1, 100(x2)
	addi	x5, x10, 0	# 1799
	lw		x4, 20(x2)	# 1799
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, veciprod.2533
	addi	x2, x2, -104
	lw		x1, 100(x2)
	fsub	f0, f0, f0	# 1799
	fadd	f0, f0, f10	# 1799
	flw		f1, 88(x2)	# 1799
	fmul	f1, f1, f0	# 1799
	flw		f0, 80(x2)	# 1800
	flw		f2, 8(x2)	# 1800
	lw		x27, 16(x2)	# 1800
	sw		x1, 100(x2)
	addi	x2, x2, 104
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -104
	lw		x1, 100(x2)
beq_cont.9901:
beq_cont.9899:
	jal		x0, beq_cont.9897	# 1790
beq.9896:
beq_cont.9897:
	lui		x4, 1	# 1804
	ori		x4, x0, 1	# 1804
	lw		x5, 4(x2)	# 1804
	sub		x4, x5, x4	# 1804
	flw		f0, 24(x2)	# 1804
	flw		f1, 8(x2)	# 1804
	lw		x5, 20(x2)	# 1804
	lw		x27, 0(x2)	# 1804
	lw		x31, 0(x27)	# 1804
	jalr	x0, x31, 0	# 1804
trace_ray.2836:
	lw		x7, 80(x27)	# 1813
	lw		x8, 76(x27)	# 1813
	lw		x9, 72(x27)	# 1813
	lw		x11, 68(x27)	# 1813
	lw		x12, 64(x27)	# 1813
	lw		x13, 60(x27)	# 1813
	lw		x14, 56(x27)	# 1813
	lw		x15, 52(x27)	# 1813
	lw		x16, 48(x27)	# 1813
	lw		x17, 44(x27)	# 1813
	lw		x18, 40(x27)	# 1813
	lw		x19, 36(x27)	# 1813
	lw		x20, 32(x27)	# 1813
	lw		x21, 28(x27)	# 1813
	lw		x22, 24(x27)	# 1813
	lw		x23, 20(x27)	# 1813
	lw		x24, 16(x27)	# 1813
	lw		x25, 12(x27)	# 1813
	lw		x26, 8(x27)	# 1813
	lw		x31, 4(x27)	# 1813
	sw		x27, 0(x2)	# 1813
	lui		x27, 4	# 1813
	ori		x27, x0, 4	# 1813
	ble		x4, x27, ble.9903	# 1813
	jalr	x0, x1, 0
ble.9903:
	fsw		f1, 8(x2)	# 1814
	sw		x9, 16(x2)	# 1814
	sw		x8, 20(x2)	# 1814
	sw		x19, 24(x2)	# 1814
	sw		x14, 28(x2)	# 1814
	sw		x31, 32(x2)	# 1814
	sw		x13, 36(x2)	# 1814
	sw		x16, 40(x2)	# 1814
	sw		x18, 44(x2)	# 1814
	sw		x11, 48(x2)	# 1814
	sw		x6, 52(x2)	# 1814
	sw		x22, 56(x2)	# 1814
	sw		x7, 60(x2)	# 1814
	sw		x23, 64(x2)	# 1814
	sw		x12, 68(x2)	# 1814
	sw		x25, 72(x2)	# 1814
	sw		x17, 76(x2)	# 1814
	sw		x24, 80(x2)	# 1814
	sw		x15, 84(x2)	# 1814
	sw		x26, 88(x2)	# 1814
	fsw		f0, 96(x2)	# 1814
	sw		x20, 104(x2)	# 1814
	sw		x4, 108(x2)	# 1814
	sw		x5, 112(x2)	# 1814
	sw		x21, 116(x2)	# 1814
	addi	x4, x6, 0
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, p_surface_ids.2601
	addi	x2, x2, -128
	lw		x1, 124(x2)
	addi	x4, x10, 0	# 1814
	lw		x5, 112(x2)	# 1815
	lw		x27, 116(x2)	# 1815
	sw		x4, 120(x2)	# 1815
	addi	x4, x5, 0
	sw		x1, 124(x2)
	addi	x2, x2, 128
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -128
	lw		x1, 124(x2)
	addi	x4, x10, 0	# 1815
	lui		x5, 0	# 1815
	ori		x5, x0, 0	# 1815
	beq		x4, x5, beq.9907	# 1815
	lui		x4, 0	# 1817
	ori		x4, x0, 0	# 1817
	mul		x4, x4, 4	# 1817
	lw		x5, 80(x2)	# 1817
	add		x4, x5, x4	# 1817
	lw		x4, 0(x4)	# 1817
	mul		x5, x4, 4	# 1818
	lw		x6, 76(x2)	# 1818
	add		x5, x6, x5	# 1818
	lw		x5, 0(x5)	# 1818
	sw		x4, 124(x2)	# 1819
	sw		x5, 128(x2)	# 1819
	addi	x4, x5, 0
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, o_reflectiontype.2559
	addi	x2, x2, -136
	lw		x1, 132(x2)
	addi	x4, x10, 0	# 1819
	lw		x5, 128(x2)	# 1820
	sw		x4, 132(x2)	# 1820
	addi	x4, x5, 0
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, o_diffuse.2579
	addi	x2, x2, -144
	lw		x1, 140(x2)
	fsub	f0, f0, f0	# 1820
	fadd	f0, f0, f10	# 1820
	flw		f1, 96(x2)	# 1820
	fmul	f0, f0, f1	# 1820
	lw		x4, 128(x2)	# 1822
	lw		x5, 112(x2)	# 1822
	lw		x27, 72(x2)	# 1822
	fsw		f0, 136(x2)	# 1822
	sw		x1, 148(x2)
	addi	x2, x2, 152
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -152
	lw		x1, 148(x2)
	lw		x4, 68(x2)	# 1823
	lw		x5, 64(x2)	# 1823
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, veccpy.2527
	addi	x2, x2, -152
	lw		x1, 148(x2)
	lw		x4, 128(x2)	# 1824
	lw		x5, 64(x2)	# 1824
	lw		x27, 60(x2)	# 1824
	sw		x1, 148(x2)
	addi	x2, x2, 152
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -152
	lw		x1, 148(x2)
	lui		x4, 4	# 1827
	ori		x4, x0, 4	# 1827
	lw		x5, 124(x2)	# 1827
	mul		x4, x5, x4	# 1827
	lui		x5, 0	# 1827
	ori		x5, x0, 0	# 1827
	mul		x5, x5, 4	# 1827
	lw		x6, 56(x2)	# 1827
	add		x5, x6, x5	# 1827
	lw		x5, 0(x5)	# 1827
	add		x4, x4, x5	# 1827
	lw		x5, 108(x2)	# 1827
	mul		x6, x5, 4	# 1827
	lw		x7, 120(x2)	# 1827
	add		x6, x7, x6	# 1827
	sw		x4, 0(x6)	# 1827
	lw		x4, 52(x2)	# 1828
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, p_intersection_points.2599
	addi	x2, x2, -152
	lw		x1, 148(x2)
	addi	x4, x10, 0	# 1828
	lw		x5, 108(x2)	# 1829
	mul		x6, x5, 4	# 1829
	add		x4, x4, x6	# 1829
	lw		x4, 0(x4)	# 1829
	lw		x6, 64(x2)	# 1829
	addi	x5, x6, 0
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, veccpy.2527
	addi	x2, x2, -152
	lw		x1, 148(x2)
	lw		x4, 52(x2)	# 1832
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, p_calc_diffuse.2603
	addi	x2, x2, -152
	lw		x1, 148(x2)
	addi	x4, x10, 0	# 1832
	lw		x5, 128(x2)	# 1833
	sw		x4, 144(x2)	# 1833
	addi	x4, x5, 0
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, o_diffuse.2579
	addi	x2, x2, -152
	lw		x1, 148(x2)
	fsub	f0, f0, f0	# 1833
	fadd	f0, f0, f10	# 1833
	lui		x4, %hi(l.6060)	# 1833
	ori		x4, %lo(l.6060)	# 1833
	flw		f1, 0(x4)	# 1833
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, fless.2453
	addi	x2, x2, -152
	lw		x1, 148(x2)
	addi	x4, x10, 0	# 1833
	lui		x5, 0	# 1833
	ori		x5, x0, 0	# 1833
	beq		x4, x5, beq.9908	# 1833
	lui		x4, 0	# 1834
	ori		x4, x0, 0	# 1834
	lw		x5, 108(x2)	# 1834
	mul		x6, x5, 4	# 1834
	lw		x7, 144(x2)	# 1834
	add		x6, x7, x6	# 1834
	sw		x4, 0(x6)	# 1834
	jal		x0, beq_cont.9909	# 1833
beq.9908:
	lui		x4, 1	# 1836
	ori		x4, x0, 1	# 1836
	lw		x5, 108(x2)	# 1836
	mul		x6, x5, 4	# 1836
	lw		x7, 144(x2)	# 1836
	add		x6, x7, x6	# 1836
	sw		x4, 0(x6)	# 1836
	lw		x4, 52(x2)	# 1837
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, p_energy.2605
	addi	x2, x2, -152
	lw		x1, 148(x2)
	addi	x4, x10, 0	# 1837
	lw		x5, 108(x2)	# 1838
	mul		x6, x5, 4	# 1838
	add		x6, x4, x6	# 1838
	lw		x6, 0(x6)	# 1838
	lw		x7, 48(x2)	# 1838
	sw		x4, 148(x2)	# 1838
	addi	x5, x7, 0
	addi	x4, x6, 0
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, veccpy.2527
	addi	x2, x2, -160
	lw		x1, 156(x2)
	lw		x4, 108(x2)	# 1839
	mul		x5, x4, 4	# 1839
	lw		x6, 148(x2)	# 1839
	add		x5, x6, x5	# 1839
	lw		x5, 0(x5)	# 1839
	lui		x6, %hi(l.7019)	# 1839
	ori		x6, %lo(l.7019)	# 1839
	flw		f0, 0(x6)	# 1839
	flw		f1, 136(x2)	# 1839
	fmul	f0, f0, f1	# 1839
	addi	x4, x5, 0
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, vecscale.2548
	addi	x2, x2, -160
	lw		x1, 156(x2)
	lw		x4, 52(x2)	# 1840
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, p_nvectors.2614
	addi	x2, x2, -160
	lw		x1, 156(x2)
	addi	x4, x10, 0	# 1840
	lw		x5, 108(x2)	# 1841
	mul		x6, x5, 4	# 1841
	add		x4, x4, x6	# 1841
	lw		x4, 0(x4)	# 1841
	lw		x6, 44(x2)	# 1841
	addi	x5, x6, 0
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, veccpy.2527
	addi	x2, x2, -160
	lw		x1, 156(x2)
beq_cont.9909:
	lui		x4, %hi(l.7023)	# 1844
	ori		x4, %lo(l.7023)	# 1844
	flw		f0, 0(x4)	# 1844
	lw		x4, 112(x2)	# 1844
	lw		x5, 44(x2)	# 1844
	fsw		f0, 152(x2)	# 1844
	sw		x1, 164(x2)
	addi	x2, x2, 168
	jal		x1, veciprod.2533
	addi	x2, x2, -168
	lw		x1, 164(x2)
	fsub	f0, f0, f0	# 1844
	fadd	f0, f0, f10	# 1844
	flw		f1, 152(x2)	# 1844
	fmul	f0, f1, f0	# 1844
	lw		x4, 112(x2)	# 1846
	lw		x5, 44(x2)	# 1846
	sw		x1, 164(x2)
	addi	x2, x2, 168
	jal		x1, vecaccum.2541
	addi	x2, x2, -168
	lw		x1, 164(x2)
	lw		x4, 128(x2)	# 1848
	sw		x1, 164(x2)
	addi	x2, x2, 168
	jal		x1, o_hilight.2581
	addi	x2, x2, -168
	lw		x1, 164(x2)
	fsub	f0, f0, f0	# 1848
	fadd	f0, f0, f10	# 1848
	flw		f1, 96(x2)	# 1848
	fmul	f0, f1, f0	# 1848
	lui		x4, 0	# 1851
	ori		x4, x0, 0	# 1851
	lui		x5, 0	# 1851
	ori		x5, x0, 0	# 1851
	mul		x5, x5, 4	# 1851
	lw		x6, 40(x2)	# 1851
	add		x5, x6, x5	# 1851
	lw		x5, 0(x5)	# 1851
	lw		x27, 36(x2)	# 1851
	fsw		f0, 160(x2)	# 1851
	sw		x1, 172(x2)
	addi	x2, x2, 176
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -176
	lw		x1, 172(x2)
	addi	x4, x10, 0	# 1851
	lui		x5, 0	# 1851
	ori		x5, x0, 0	# 1851
	beq		x4, x5, beq.9910	# 1851
	jal		x0, beq_cont.9911	# 1851
beq.9910:
	lw		x4, 44(x2)	# 1852
	lw		x5, 104(x2)	# 1852
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, veciprod.2533
	addi	x2, x2, -176
	lw		x1, 172(x2)
	fsub	f0, f0, f0	# 1852
	fadd	f0, f0, f10	# 1852
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, fneg.2449
	addi	x2, x2, -176
	lw		x1, 172(x2)
	fsub	f0, f0, f0	# 1852
	fadd	f0, f0, f10	# 1852
	flw		f1, 136(x2)	# 1852
	fmul	f0, f0, f1	# 1852
	lw		x4, 112(x2)	# 1853
	lw		x5, 104(x2)	# 1853
	fsw		f0, 168(x2)	# 1853
	sw		x1, 180(x2)
	addi	x2, x2, 184
	jal		x1, veciprod.2533
	addi	x2, x2, -184
	lw		x1, 180(x2)
	fsub	f0, f0, f0	# 1853
	fadd	f0, f0, f10	# 1853
	sw		x1, 180(x2)
	addi	x2, x2, 184
	jal		x1, fneg.2449
	addi	x2, x2, -184
	lw		x1, 180(x2)
	fsub	f1, f1, f1	# 1853
	fadd	f1, f1, f10	# 1853
	flw		f0, 168(x2)	# 1854
	flw		f2, 160(x2)	# 1854
	lw		x27, 32(x2)	# 1854
	sw		x1, 180(x2)
	addi	x2, x2, 184
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -184
	lw		x1, 180(x2)
beq_cont.9911:
	lw		x4, 64(x2)	# 1858
	lw		x27, 28(x2)	# 1858
	sw		x1, 180(x2)
	addi	x2, x2, 184
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -184
	lw		x1, 180(x2)
	lui		x4, 0	# 1859
	ori		x4, x0, 0	# 1859
	mul		x4, x4, 4	# 1859
	lw		x5, 24(x2)	# 1859
	add		x4, x5, x4	# 1859
	lw		x4, 0(x4)	# 1859
	lui		x5, 1	# 1859
	ori		x5, x0, 1	# 1859
	sub		x4, x4, x5	# 1859
	flw		f0, 136(x2)	# 1859
	flw		f1, 160(x2)	# 1859
	lw		x5, 112(x2)	# 1859
	lw		x27, 20(x2)	# 1859
	sw		x1, 180(x2)
	addi	x2, x2, 184
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -184
	lw		x1, 180(x2)
	lui		x4, %hi(l.7029)	# 1862
	ori		x4, %lo(l.7029)	# 1862
	flw		f0, 0(x4)	# 1862
	flw		f1, 96(x2)	# 1862
	sw		x1, 180(x2)
	addi	x2, x2, 184
	jal		x1, fless.2453
	addi	x2, x2, -184
	lw		x1, 180(x2)
	addi	x4, x10, 0	# 1862
	lui		x5, 0	# 1862
	ori		x5, x0, 0	# 1862
	beq		x4, x5, beq.9912	# 1862
	lui		x4, 4	# 1864
	ori		x4, x0, 4	# 1864
	lw		x5, 108(x2)	# 1864
	ble		x4, x5, ble.9913	# 1864
	addi	x4, x5, 1	# 1865
	lui		x6, -1	# 1865
	ori		x6, x0, -1	# 1865
	mul		x4, x4, 4	# 1865
	lw		x7, 120(x2)	# 1865
	add		x4, x7, x4	# 1865
	sw		x6, 0(x4)	# 1865
	jal		x0, ble_cont.9914	# 1864
ble.9913:
ble_cont.9914:
	lui		x4, 2	# 1868
	ori		x4, x0, 2	# 1868
	lw		x6, 132(x2)	# 1868
	beq		x6, x4, beq.9915	# 1868
	jalr	x0, x1, 0
beq.9915:
	lui		x4, %hi(l.6062)	# 1869
	ori		x4, %lo(l.6062)	# 1869
	flw		f0, 0(x4)	# 1869
	lw		x4, 128(x2)	# 1869
	fsw		f0, 176(x2)	# 1869
	sw		x1, 188(x2)
	addi	x2, x2, 192
	jal		x1, o_diffuse.2579
	addi	x2, x2, -192
	lw		x1, 188(x2)
	fsub	f0, f0, f0	# 1869
	fadd	f0, f0, f10	# 1869
	flw		f1, 176(x2)	# 1869
	fsub	f0, f1, f0	# 1869
	flw		f1, 96(x2)	# 1869
	fmul	f0, f1, f0	# 1869
	lw		x4, 108(x2)	# 1870
	addi	x4, x4, 1	# 1870
	lui		x5, 0	# 1870
	ori		x5, x0, 0	# 1870
	mul		x5, x5, 8	# 1870
	lw		x6, 16(x2)	# 1870
	add		x5, x6, x5	# 1870
	flw		f1, 0(x5)	# 1870
	flw		f2, 8(x2)	# 1870
	fadd	f1, f2, f1	# 1870
	lw		x5, 112(x2)	# 1870
	lw		x6, 52(x2)	# 1870
	lw		x27, 0(x2)	# 1870
	lw		x31, 0(x27)	# 1870
	jalr	x0, x31, 0	# 1870
beq.9912:
	jalr	x0, x1, 0
beq.9907:
	lui		x4, -1	# 1878
	ori		x4, x0, -1	# 1878
	lw		x5, 108(x2)	# 1878
	mul		x6, x5, 4	# 1878
	lw		x7, 120(x2)	# 1878
	add		x6, x7, x6	# 1878
	sw		x4, 0(x6)	# 1878
	lui		x4, 0	# 1880
	ori		x4, x0, 0	# 1880
	beq		x5, x4, beq.9918	# 1880
	lw		x4, 112(x2)	# 1881
	lw		x5, 104(x2)	# 1881
	sw		x1, 188(x2)
	addi	x2, x2, 192
	jal		x1, veciprod.2533
	addi	x2, x2, -192
	lw		x1, 188(x2)
	fsub	f0, f0, f0	# 1881
	fadd	f0, f0, f10	# 1881
	sw		x1, 188(x2)
	addi	x2, x2, 192
	jal		x1, fneg.2449
	addi	x2, x2, -192
	lw		x1, 188(x2)
	fsub	f0, f0, f0	# 1881
	fadd	f0, f0, f10	# 1881
	fsw		f0, 184(x2)	# 1883
	sw		x1, 196(x2)
	addi	x2, x2, 200
	jal		x1, fispos.2445
	addi	x2, x2, -200
	lw		x1, 196(x2)
	addi	x4, x10, 0	# 1883
	lui		x5, 0	# 1883
	ori		x5, x0, 0	# 1883
	beq		x4, x5, beq.9919	# 1883
	flw		f0, 184(x2)	# 1886
	sw		x1, 196(x2)
	addi	x2, x2, 200
	jal		x1, fsqr.2458
	addi	x2, x2, -200
	lw		x1, 196(x2)
	fsub	f0, f0, f0	# 1886
	fadd	f0, f0, f10	# 1886
	flw		f1, 184(x2)	# 1886
	fmul	f0, f0, f1	# 1886
	flw		f1, 96(x2)	# 1886
	fmul	f0, f0, f1	# 1886
	lui		x4, 0	# 1886
	ori		x4, x0, 0	# 1886
	mul		x4, x4, 8	# 1886
	lw		x5, 88(x2)	# 1886
	add		x4, x5, x4	# 1886
	flw		f1, 0(x4)	# 1886
	fmul	f0, f0, f1	# 1886
	lui		x4, 0	# 1887
	ori		x4, x0, 0	# 1887
	lui		x5, 0	# 1887
	ori		x5, x0, 0	# 1887
	mul		x5, x5, 8	# 1887
	lw		x6, 84(x2)	# 1887
	add		x5, x6, x5	# 1887
	flw		f1, 0(x5)	# 1887
	fadd	f1, f1, f0	# 1887
	mul		x4, x4, 8	# 1887
	add		x4, x6, x4	# 1887
	fsw		f1, 0(x4)	# 1887
	lui		x4, 1	# 1888
	ori		x4, x0, 1	# 1888
	lui		x5, 1	# 1888
	ori		x5, x0, 1	# 1888
	mul		x5, x5, 8	# 1888
	add		x5, x6, x5	# 1888
	flw		f1, 0(x5)	# 1888
	fadd	f1, f1, f0	# 1888
	mul		x4, x4, 8	# 1888
	add		x4, x6, x4	# 1888
	fsw		f1, 0(x4)	# 1888
	lui		x4, 2	# 1889
	ori		x4, x0, 2	# 1889
	lui		x5, 2	# 1889
	ori		x5, x0, 2	# 1889
	mul		x5, x5, 8	# 1889
	add		x5, x6, x5	# 1889
	flw		f1, 0(x5)	# 1889
	fadd	f0, f1, f0	# 1889
	mul		x4, x4, 8	# 1889
	add		x4, x6, x4	# 1889
	fsw		f0, 0(x4)	# 1889
	jalr	x0, x1, 0
beq.9919:
	jalr	x0, x1, 0
beq.9918:
	jalr	x0, x1, 0
trace_diffuse_ray.2842:
	lw		x5, 48(x27)	# 1908
	lw		x6, 44(x27)	# 1908
	lw		x7, 40(x27)	# 1908
	lw		x8, 36(x27)	# 1908
	lw		x9, 32(x27)	# 1908
	lw		x11, 28(x27)	# 1908
	lw		x12, 24(x27)	# 1908
	lw		x13, 20(x27)	# 1908
	lw		x14, 16(x27)	# 1908
	lw		x15, 12(x27)	# 1908
	lw		x16, 8(x27)	# 1908
	lw		x17, 4(x27)	# 1908
	sw		x6, 0(x2)	# 1908
	sw		x17, 4(x2)	# 1908
	fsw		f0, 8(x2)	# 1908
	sw		x12, 16(x2)	# 1908
	sw		x11, 20(x2)	# 1908
	sw		x7, 24(x2)	# 1908
	sw		x8, 28(x2)	# 1908
	sw		x14, 32(x2)	# 1908
	sw		x5, 36(x2)	# 1908
	sw		x16, 40(x2)	# 1908
	sw		x4, 44(x2)	# 1908
	sw		x9, 48(x2)	# 1908
	sw		x15, 52(x2)	# 1908
	addi	x27, x13, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 1908
	lui		x5, 0	# 1908
	ori		x5, x0, 0	# 1908
	beq		x4, x5, beq.9923	# 1908
	lui		x4, 0	# 1909
	ori		x4, x0, 0	# 1909
	mul		x4, x4, 4	# 1909
	lw		x5, 52(x2)	# 1909
	add		x4, x5, x4	# 1909
	lw		x4, 0(x4)	# 1909
	mul		x4, x4, 4	# 1909
	lw		x5, 48(x2)	# 1909
	add		x4, x5, x4	# 1909
	lw		x4, 0(x4)	# 1909
	lw		x5, 44(x2)	# 1910
	sw		x4, 56(x2)	# 1910
	addi	x4, x5, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, d_vec.2616
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x5, x10, 0	# 1910
	lw		x4, 56(x2)	# 1910
	lw		x27, 40(x2)	# 1910
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	lw		x4, 56(x2)	# 1911
	lw		x5, 32(x2)	# 1911
	lw		x27, 36(x2)	# 1911
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	lui		x4, 0	# 1914
	ori		x4, x0, 0	# 1914
	lui		x5, 0	# 1914
	ori		x5, x0, 0	# 1914
	mul		x5, x5, 4	# 1914
	lw		x6, 28(x2)	# 1914
	add		x5, x6, x5	# 1914
	lw		x5, 0(x5)	# 1914
	lw		x27, 24(x2)	# 1914
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 1914
	lui		x5, 0	# 1914
	ori		x5, x0, 0	# 1914
	beq		x4, x5, beq.9924	# 1914
	jalr	x0, x1, 0
beq.9924:
	lw		x4, 20(x2)	# 1915
	lw		x5, 16(x2)	# 1915
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, veciprod.2533
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1915
	fadd	f0, f0, f10	# 1915
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, fneg.2449
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 1915
	fadd	f0, f0, f10	# 1915
	fsw		f0, 64(x2)	# 1916
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fispos.2445
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 1916
	lui		x5, 0	# 1916
	ori		x5, x0, 0	# 1916
	beq		x4, x5, beq.9927	# 1916
	flw		f0, 64(x2)	# 1916
	jal		x0, beq_cont.9928	# 1916
beq.9927:
	lui		x4, %hi(l.6055)	# 1916
	ori		x4, %lo(l.6055)	# 1916
	flw		f0, 0(x4)	# 1916
beq_cont.9928:
	flw		f1, 8(x2)	# 1917
	fmul	f0, f1, f0	# 1917
	lw		x4, 56(x2)	# 1917
	fsw		f0, 72(x2)	# 1917
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, o_diffuse.2579
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 1917
	fadd	f0, f0, f10	# 1917
	flw		f1, 72(x2)	# 1917
	fmul	f0, f1, f0	# 1917
	lw		x4, 4(x2)	# 1917
	lw		x5, 0(x2)	# 1917
	jal		x0, vecaccum.2541	# 1917
beq.9923:
	jalr	x0, x1, 0
iter_trace_diffuse_rays.2845:
	lw		x8, 4(x27)	# 1925
	lui		x9, 0	# 1925
	ori		x9, x0, 0	# 1925
	ble		x9, x7, ble.9930	# 1925
	jalr	x0, x1, 0
ble.9930:
	mul		x9, x7, 4	# 1926
	add		x9, x4, x9	# 1926
	lw		x9, 0(x9)	# 1926
	sw		x6, 0(x2)	# 1926
	sw		x27, 4(x2)	# 1926
	sw		x8, 8(x2)	# 1926
	sw		x4, 12(x2)	# 1926
	sw		x7, 16(x2)	# 1926
	sw		x5, 20(x2)	# 1926
	addi	x4, x9, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, d_vec.2616
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1926
	lw		x5, 20(x2)	# 1926
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, veciprod.2533
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 1926
	fadd	f0, f0, f10	# 1926
	fsw		f0, 24(x2)	# 1930
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, fisneg.2447
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1930
	lui		x5, 0	# 1930
	ori		x5, x0, 0	# 1930
	beq		x4, x5, beq.9932	# 1930
	lw		x4, 16(x2)	# 1931
	addi	x5, x4, 1	# 1931
	mul		x5, x5, 4	# 1931
	lw		x6, 12(x2)	# 1931
	add		x5, x6, x5	# 1931
	lw		x5, 0(x5)	# 1931
	lui		x7, %hi(l.7063)	# 1931
	ori		x7, %lo(l.7063)	# 1931
	flw		f0, 0(x7)	# 1931
	flw		f1, 24(x2)	# 1931
	fdiv	f0, f1, f0	# 1931
	lw		x27, 8(x2)	# 1931
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	jal		x0, beq_cont.9933	# 1930
beq.9932:
	lw		x4, 16(x2)	# 1933
	mul		x5, x4, 4	# 1933
	lw		x6, 12(x2)	# 1933
	add		x5, x6, x5	# 1933
	lw		x5, 0(x5)	# 1933
	lui		x7, %hi(l.7067)	# 1933
	ori		x7, %lo(l.7067)	# 1933
	flw		f0, 0(x7)	# 1933
	flw		f1, 24(x2)	# 1933
	fdiv	f0, f1, f0	# 1933
	lw		x27, 8(x2)	# 1933
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
beq_cont.9933:
	lui		x4, 2	# 1935
	ori		x4, x0, 2	# 1935
	lw		x5, 16(x2)	# 1935
	sub		x7, x5, x4	# 1935
	lw		x4, 12(x2)	# 1935
	lw		x5, 20(x2)	# 1935
	lw		x6, 0(x2)	# 1935
	lw		x27, 4(x2)	# 1935
	lw		x31, 0(x27)	# 1935
	jalr	x0, x31, 0	# 1935
trace_diffuse_rays.2850:
	lw		x7, 8(x27)	# 1941
	lw		x8, 4(x27)	# 1941
	sw		x6, 0(x2)	# 1941
	sw		x5, 4(x2)	# 1941
	sw		x4, 8(x2)	# 1941
	sw		x8, 12(x2)	# 1941
	addi	x4, x6, 0
	addi	x27, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lui		x7, 118	# 1945
	ori		x7, x0, 118	# 1945
	lw		x4, 8(x2)	# 1945
	lw		x5, 4(x2)	# 1945
	lw		x6, 0(x2)	# 1945
	lw		x27, 12(x2)	# 1945
	lw		x31, 0(x27)	# 1945
	jalr	x0, x31, 0	# 1945
trace_diffuse_ray_80percent.2854:
	lw		x7, 8(x27)	# 1952
	lw		x8, 4(x27)	# 1952
	lui		x9, 0	# 1952
	ori		x9, x0, 0	# 1952
	sw		x6, 0(x2)	# 1952
	sw		x5, 4(x2)	# 1952
	sw		x7, 8(x2)	# 1952
	sw		x8, 12(x2)	# 1952
	sw		x4, 16(x2)	# 1952
	beq		x4, x9, beq.9934	# 1952
	lui		x9, 0	# 1953
	ori		x9, x0, 0	# 1953
	mul		x9, x9, 4	# 1953
	add		x9, x8, x9	# 1953
	lw		x9, 0(x9)	# 1953
	addi	x4, x9, 0
	addi	x27, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	jal		x0, beq_cont.9935	# 1952
beq.9934:
beq_cont.9935:
	lui		x4, 1	# 1956
	ori		x4, x0, 1	# 1956
	lw		x5, 16(x2)	# 1956
	beq		x5, x4, beq.9936	# 1956
	lui		x4, 1	# 1957
	ori		x4, x0, 1	# 1957
	mul		x4, x4, 4	# 1957
	lw		x6, 12(x2)	# 1957
	add		x4, x6, x4	# 1957
	lw		x4, 0(x4)	# 1957
	lw		x7, 4(x2)	# 1957
	lw		x8, 0(x2)	# 1957
	lw		x27, 8(x2)	# 1957
	addi	x6, x8, 0
	addi	x5, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	jal		x0, beq_cont.9937	# 1956
beq.9936:
beq_cont.9937:
	lui		x4, 2	# 1960
	ori		x4, x0, 2	# 1960
	lw		x5, 16(x2)	# 1960
	beq		x5, x4, beq.9938	# 1960
	lui		x4, 2	# 1961
	ori		x4, x0, 2	# 1961
	mul		x4, x4, 4	# 1961
	lw		x6, 12(x2)	# 1961
	add		x4, x6, x4	# 1961
	lw		x4, 0(x4)	# 1961
	lw		x7, 4(x2)	# 1961
	lw		x8, 0(x2)	# 1961
	lw		x27, 8(x2)	# 1961
	addi	x6, x8, 0
	addi	x5, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	jal		x0, beq_cont.9939	# 1960
beq.9938:
beq_cont.9939:
	lui		x4, 3	# 1964
	ori		x4, x0, 3	# 1964
	lw		x5, 16(x2)	# 1964
	beq		x5, x4, beq.9940	# 1964
	lui		x4, 3	# 1965
	ori		x4, x0, 3	# 1965
	mul		x4, x4, 4	# 1965
	lw		x6, 12(x2)	# 1965
	add		x4, x6, x4	# 1965
	lw		x4, 0(x4)	# 1965
	lw		x7, 4(x2)	# 1965
	lw		x8, 0(x2)	# 1965
	lw		x27, 8(x2)	# 1965
	addi	x6, x8, 0
	addi	x5, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	jal		x0, beq_cont.9941	# 1964
beq.9940:
beq_cont.9941:
	lui		x4, 4	# 1968
	ori		x4, x0, 4	# 1968
	lw		x5, 16(x2)	# 1968
	beq		x5, x4, beq.9942	# 1968
	lui		x4, 4	# 1969
	ori		x4, x0, 4	# 1969
	mul		x4, x4, 4	# 1969
	lw		x5, 12(x2)	# 1969
	add		x4, x5, x4	# 1969
	lw		x4, 0(x4)	# 1969
	lw		x5, 4(x2)	# 1969
	lw		x6, 0(x2)	# 1969
	lw		x27, 8(x2)	# 1969
	lw		x31, 0(x27)	# 1969
	jalr	x0, x31, 0	# 1969
beq.9942:
	jalr	x0, x1, 0
calc_diffuse_using_1point.2858:
	lw		x6, 12(x27)	# 1978
	lw		x7, 8(x27)	# 1978
	lw		x8, 4(x27)	# 1978
	sw		x7, 0(x2)	# 1978
	sw		x6, 4(x2)	# 1978
	sw		x8, 8(x2)	# 1978
	sw		x5, 12(x2)	# 1978
	sw		x4, 16(x2)	# 1978
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, p_received_ray_20percent.2607
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 1978
	lw		x5, 16(x2)	# 1979
	sw		x4, 20(x2)	# 1979
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, p_nvectors.2614
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1979
	lw		x5, 16(x2)	# 1980
	sw		x4, 24(x2)	# 1980
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, p_intersection_points.2599
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1980
	lw		x5, 16(x2)	# 1981
	sw		x4, 28(x2)	# 1981
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, p_energy.2605
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1981
	lw		x5, 12(x2)	# 1983
	mul		x6, x5, 4	# 1983
	lw		x7, 20(x2)	# 1983
	add		x6, x7, x6	# 1983
	lw		x6, 0(x6)	# 1983
	lw		x7, 8(x2)	# 1983
	sw		x4, 32(x2)	# 1983
	addi	x5, x6, 0
	addi	x4, x7, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, veccpy.2527
	addi	x2, x2, -40
	lw		x1, 36(x2)
	lw		x4, 16(x2)	# 1985
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, p_group_id.2609
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1985
	lw		x5, 12(x2)	# 1986
	mul		x6, x5, 4	# 1986
	lw		x7, 24(x2)	# 1986
	add		x6, x7, x6	# 1986
	lw		x6, 0(x6)	# 1986
	mul		x7, x5, 4	# 1987
	lw		x8, 28(x2)	# 1987
	add		x7, x8, x7	# 1987
	lw		x7, 0(x7)	# 1987
	lw		x27, 4(x2)	# 1984
	addi	x5, x6, 0
	addi	x6, x7, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	lw		x4, 12(x2)	# 1988
	mul		x4, x4, 4	# 1988
	lw		x5, 32(x2)	# 1988
	add		x4, x5, x4	# 1988
	lw		x5, 0(x4)	# 1988
	lw		x4, 0(x2)	# 1988
	lw		x6, 8(x2)	# 1988
	jal		x0, vecaccumv.2551	# 1988
calc_diffuse_using_5points.2861:
	lw		x9, 8(x27)	# 1997
	lw		x11, 4(x27)	# 1997
	mul		x12, x4, 4	# 1997
	add		x5, x5, x12	# 1997
	lw		x5, 0(x5)	# 1997
	sw		x9, 0(x2)	# 1997
	sw		x11, 4(x2)	# 1997
	sw		x8, 8(x2)	# 1997
	sw		x7, 12(x2)	# 1997
	sw		x6, 16(x2)	# 1997
	sw		x4, 20(x2)	# 1997
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, p_received_ray_20percent.2607
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1997
	lui		x5, 1	# 1998
	ori		x5, x0, 1	# 1998
	lw		x6, 20(x2)	# 1998
	sub		x5, x6, x5	# 1998
	mul		x5, x5, 4	# 1998
	lw		x7, 16(x2)	# 1998
	add		x5, x7, x5	# 1998
	lw		x5, 0(x5)	# 1998
	sw		x4, 24(x2)	# 1998
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, p_received_ray_20percent.2607
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 1998
	lw		x5, 20(x2)	# 1999
	mul		x6, x5, 4	# 1999
	lw		x7, 16(x2)	# 1999
	add		x6, x7, x6	# 1999
	lw		x6, 0(x6)	# 1999
	sw		x4, 28(x2)	# 1999
	addi	x4, x6, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, p_received_ray_20percent.2607
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 1999
	lw		x5, 20(x2)	# 2000
	addi	x6, x5, 1	# 2000
	mul		x6, x6, 4	# 2000
	lw		x7, 16(x2)	# 2000
	add		x6, x7, x6	# 2000
	lw		x6, 0(x6)	# 2000
	sw		x4, 32(x2)	# 2000
	addi	x4, x6, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, p_received_ray_20percent.2607
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 2000
	lw		x5, 20(x2)	# 2001
	mul		x6, x5, 4	# 2001
	lw		x7, 12(x2)	# 2001
	add		x6, x7, x6	# 2001
	lw		x6, 0(x6)	# 2001
	sw		x4, 36(x2)	# 2001
	addi	x4, x6, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, p_received_ray_20percent.2607
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 2001
	lw		x5, 8(x2)	# 2003
	mul		x6, x5, 4	# 2003
	lw		x7, 24(x2)	# 2003
	add		x6, x7, x6	# 2003
	lw		x6, 0(x6)	# 2003
	lw		x7, 4(x2)	# 2003
	sw		x4, 40(x2)	# 2003
	addi	x5, x6, 0
	addi	x4, x7, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, veccpy.2527
	addi	x2, x2, -48
	lw		x1, 44(x2)
	lw		x4, 8(x2)	# 2004
	mul		x5, x4, 4	# 2004
	lw		x6, 28(x2)	# 2004
	add		x5, x6, x5	# 2004
	lw		x5, 0(x5)	# 2004
	lw		x6, 4(x2)	# 2004
	addi	x4, x6, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, vecadd.2545
	addi	x2, x2, -48
	lw		x1, 44(x2)
	lw		x4, 8(x2)	# 2005
	mul		x5, x4, 4	# 2005
	lw		x6, 32(x2)	# 2005
	add		x5, x6, x5	# 2005
	lw		x5, 0(x5)	# 2005
	lw		x6, 4(x2)	# 2005
	addi	x4, x6, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, vecadd.2545
	addi	x2, x2, -48
	lw		x1, 44(x2)
	lw		x4, 8(x2)	# 2006
	mul		x5, x4, 4	# 2006
	lw		x6, 36(x2)	# 2006
	add		x5, x6, x5	# 2006
	lw		x5, 0(x5)	# 2006
	lw		x6, 4(x2)	# 2006
	addi	x4, x6, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, vecadd.2545
	addi	x2, x2, -48
	lw		x1, 44(x2)
	lw		x4, 8(x2)	# 2007
	mul		x5, x4, 4	# 2007
	lw		x6, 40(x2)	# 2007
	add		x5, x6, x5	# 2007
	lw		x5, 0(x5)	# 2007
	lw		x6, 4(x2)	# 2007
	addi	x4, x6, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, vecadd.2545
	addi	x2, x2, -48
	lw		x1, 44(x2)
	lw		x4, 20(x2)	# 2009
	mul		x4, x4, 4	# 2009
	lw		x5, 16(x2)	# 2009
	add		x4, x5, x4	# 2009
	lw		x4, 0(x4)	# 2009
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, p_energy.2605
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 2009
	lw		x5, 8(x2)	# 2010
	mul		x5, x5, 4	# 2010
	add		x4, x4, x5	# 2010
	lw		x5, 0(x4)	# 2010
	lw		x4, 0(x2)	# 2010
	lw		x6, 4(x2)	# 2010
	jal		x0, vecaccumv.2551	# 2010
do_without_neighbors.2867:
	lw		x6, 4(x27)	# 2016
	lui		x7, 4	# 2016
	ori		x7, x0, 4	# 2016
	ble		x5, x7, ble.9944	# 2016
	jalr	x0, x1, 0
ble.9944:
	sw		x27, 0(x2)	# 2018
	sw		x6, 4(x2)	# 2018
	sw		x4, 8(x2)	# 2018
	sw		x5, 12(x2)	# 2018
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, p_surface_ids.2601
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2018
	lui		x5, 0	# 2019
	ori		x5, x0, 0	# 2019
	lw		x6, 12(x2)	# 2019
	mul		x7, x6, 4	# 2019
	add		x4, x4, x7	# 2019
	lw		x4, 0(x4)	# 2019
	ble		x5, x4, ble.9946	# 2019
	jalr	x0, x1, 0
ble.9946:
	lw		x4, 8(x2)	# 2020
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, p_calc_diffuse.2603
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2020
	lw		x5, 12(x2)	# 2021
	mul		x6, x5, 4	# 2021
	add		x4, x4, x6	# 2021
	lw		x4, 0(x4)	# 2021
	lui		x6, 0	# 2021
	ori		x6, x0, 0	# 2021
	beq		x4, x6, beq.9948	# 2021
	lw		x4, 8(x2)	# 2022
	lw		x27, 4(x2)	# 2022
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	jal		x0, beq_cont.9949	# 2021
beq.9948:
beq_cont.9949:
	lw		x4, 12(x2)	# 2024
	addi	x5, x4, 1	# 2024
	lw		x4, 8(x2)	# 2024
	lw		x27, 0(x2)	# 2024
	lw		x31, 0(x27)	# 2024
	jalr	x0, x31, 0	# 2024
neighbors_exist.2870:
	lw		x6, 4(x27)	# 2031
	lui		x7, 1	# 2031
	ori		x7, x0, 1	# 2031
	mul		x7, x7, 4	# 2031
	add		x7, x6, x7	# 2031
	lw		x7, 0(x7)	# 2031
	addi	x8, x5, 1	# 2031
	ble		x7, x8, ble.9950	# 2031
	lui		x7, 0	# 2032
	ori		x7, x0, 0	# 2032
	ble		x5, x7, ble.9951	# 2032
	lui		x5, 0	# 2033
	ori		x5, x0, 0	# 2033
	mul		x5, x5, 4	# 2033
	add		x5, x6, x5	# 2033
	lw		x5, 0(x5)	# 2033
	addi	x6, x4, 1	# 2033
	ble		x5, x6, ble.9952	# 2033
	lui		x5, 0	# 2034
	ori		x5, x0, 0	# 2034
	ble		x4, x5, ble.9953	# 2034
	lui		x10, 1	# 2035
	ori		x10, x0, 1	# 2035
	jalr	x0, x1, 0
ble.9953:
	lui		x10, 0	# 2036
	ori		x10, x0, 0	# 2036
	jalr	x0, x1, 0
ble.9952:
	lui		x10, 0	# 2037
	ori		x10, x0, 0	# 2037
	jalr	x0, x1, 0
ble.9951:
	lui		x10, 0	# 2038
	ori		x10, x0, 0	# 2038
	jalr	x0, x1, 0
ble.9950:
	lui		x10, 0	# 2039
	ori		x10, x0, 0	# 2039
	jalr	x0, x1, 0
get_surface_id.2874:
	sw		x5, 0(x2)	# 2043
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, p_surface_ids.2601
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 2043
	lw		x5, 0(x2)	# 2044
	mul		x5, x5, 4	# 2044
	add		x4, x4, x5	# 2044
	lw		x10, 0(x4)	# 2044
	jalr	x0, x1, 0
neighbors_are_available.2877:
	mul		x9, x4, 4	# 2050
	add		x9, x6, x9	# 2050
	lw		x9, 0(x9)	# 2050
	sw		x6, 0(x2)	# 2050
	sw		x7, 4(x2)	# 2050
	sw		x8, 8(x2)	# 2050
	sw		x5, 12(x2)	# 2050
	sw		x4, 16(x2)	# 2050
	addi	x5, x8, 0
	addi	x4, x9, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, get_surface_id.2874
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2050
	lw		x5, 16(x2)	# 2052
	mul		x6, x5, 4	# 2052
	lw		x7, 12(x2)	# 2052
	add		x6, x7, x6	# 2052
	lw		x6, 0(x6)	# 2052
	lw		x7, 8(x2)	# 2052
	sw		x4, 20(x2)	# 2052
	addi	x5, x7, 0
	addi	x4, x6, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, get_surface_id.2874
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2052
	lw		x5, 20(x2)	# 2052
	beq		x4, x5, beq.9954	# 2052
	lui		x10, 0	# 2060
	ori		x10, x0, 0	# 2060
	jalr	x0, x1, 0
beq.9954:
	lw		x4, 16(x2)	# 2053
	mul		x6, x4, 4	# 2053
	lw		x7, 4(x2)	# 2053
	add		x6, x7, x6	# 2053
	lw		x6, 0(x6)	# 2053
	lw		x7, 8(x2)	# 2053
	addi	x5, x7, 0
	addi	x4, x6, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, get_surface_id.2874
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2053
	lw		x5, 20(x2)	# 2053
	beq		x4, x5, beq.9955	# 2053
	lui		x10, 0	# 2059
	ori		x10, x0, 0	# 2059
	jalr	x0, x1, 0
beq.9955:
	lui		x4, 1	# 2054
	ori		x4, x0, 1	# 2054
	lw		x6, 16(x2)	# 2054
	sub		x4, x6, x4	# 2054
	mul		x4, x4, 4	# 2054
	lw		x7, 0(x2)	# 2054
	add		x4, x7, x4	# 2054
	lw		x4, 0(x4)	# 2054
	lw		x8, 8(x2)	# 2054
	addi	x5, x8, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, get_surface_id.2874
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2054
	lw		x5, 20(x2)	# 2054
	beq		x4, x5, beq.9956	# 2054
	lui		x10, 0	# 2058
	ori		x10, x0, 0	# 2058
	jalr	x0, x1, 0
beq.9956:
	lw		x4, 16(x2)	# 2055
	addi	x4, x4, 1	# 2055
	mul		x4, x4, 4	# 2055
	lw		x6, 0(x2)	# 2055
	add		x4, x6, x4	# 2055
	lw		x4, 0(x4)	# 2055
	lw		x6, 8(x2)	# 2055
	addi	x5, x6, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, get_surface_id.2874
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2055
	lw		x5, 20(x2)	# 2055
	beq		x4, x5, beq.9957	# 2055
	lui		x10, 0	# 2057
	ori		x10, x0, 0	# 2057
	jalr	x0, x1, 0
beq.9957:
	lui		x10, 1	# 2056
	ori		x10, x0, 1	# 2056
	jalr	x0, x1, 0
try_exploit_neighbors.2883:
	lw		x11, 8(x27)	# 2068
	lw		x12, 4(x27)	# 2068
	mul		x13, x4, 4	# 2068
	add		x13, x7, x13	# 2068
	lw		x13, 0(x13)	# 2068
	lui		x14, 4	# 2069
	ori		x14, x0, 4	# 2069
	ble		x9, x14, ble.9958	# 2069
	jalr	x0, x1, 0
ble.9958:
	lui		x14, 0	# 2072
	ori		x14, x0, 0	# 2072
	sw		x5, 0(x2)	# 2072
	sw		x27, 4(x2)	# 2072
	sw		x12, 8(x2)	# 2072
	sw		x13, 12(x2)	# 2072
	sw		x11, 16(x2)	# 2072
	sw		x9, 20(x2)	# 2072
	sw		x8, 24(x2)	# 2072
	sw		x7, 28(x2)	# 2072
	sw		x6, 32(x2)	# 2072
	sw		x4, 36(x2)	# 2072
	sw		x14, 40(x2)	# 2072
	addi	x5, x9, 0
	addi	x4, x13, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, get_surface_id.2874
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 2072
	lw		x5, 40(x2)	# 2072
	ble		x5, x4, ble.9960	# 2072
	jalr	x0, x1, 0
ble.9960:
	lw		x4, 36(x2)	# 2074
	lw		x5, 32(x2)	# 2074
	lw		x6, 28(x2)	# 2074
	lw		x7, 24(x2)	# 2074
	lw		x8, 20(x2)	# 2074
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, neighbors_are_available.2877
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 2074
	lui		x5, 0	# 2074
	ori		x5, x0, 0	# 2074
	beq		x4, x5, beq.9962	# 2074
	lw		x4, 12(x2)	# 2077
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, p_calc_diffuse.2603
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 2077
	lw		x8, 20(x2)	# 2078
	mul		x5, x8, 4	# 2078
	add		x4, x4, x5	# 2078
	lw		x4, 0(x4)	# 2078
	lui		x5, 0	# 2078
	ori		x5, x0, 0	# 2078
	beq		x4, x5, beq.9963	# 2078
	lw		x4, 36(x2)	# 2079
	lw		x5, 32(x2)	# 2079
	lw		x6, 28(x2)	# 2079
	lw		x7, 24(x2)	# 2079
	lw		x27, 8(x2)	# 2079
	sw		x1, 44(x2)
	addi	x2, x2, 48
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -48
	lw		x1, 44(x2)
	jal		x0, beq_cont.9964	# 2078
beq.9963:
beq_cont.9964:
	lw		x4, 20(x2)	# 2083
	addi	x9, x4, 1	# 2083
	lw		x4, 36(x2)	# 2083
	lw		x5, 0(x2)	# 2083
	lw		x6, 32(x2)	# 2083
	lw		x7, 28(x2)	# 2083
	lw		x8, 24(x2)	# 2083
	lw		x27, 4(x2)	# 2083
	lw		x31, 0(x27)	# 2083
	jalr	x0, x31, 0	# 2083
beq.9962:
	lw		x4, 36(x2)	# 2086
	mul		x4, x4, 4	# 2086
	lw		x5, 28(x2)	# 2086
	add		x4, x5, x4	# 2086
	lw		x4, 0(x4)	# 2086
	lw		x5, 20(x2)	# 2086
	lw		x27, 16(x2)	# 2086
	lw		x31, 0(x27)	# 2086
	jalr	x0, x31, 0	# 2086
write_ppm_header.2890:
	lw		x5, 4(x27)	# 2096
	lui		x6, 80	# 2096
	ori		x6, x0, 80	# 2096
	sw		x5, 0(x2)	# 2096
	sw		x4, 4(x2)	# 2096
	addi	x4, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_print_char
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lw		x4, 4(x2)	# 2097
	addi	x4, x4, 48	# 2097
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_print_char
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 10	# 2098
	ori		x4, x0, 10	# 2098
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_print_char
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 0	# 2099
	ori		x4, x0, 0	# 2099
	mul		x4, x4, 4	# 2099
	lw		x5, 0(x2)	# 2099
	add		x4, x5, x4	# 2099
	lw		x4, 0(x4)	# 2099
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_print_int
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 32	# 2100
	ori		x4, x0, 32	# 2100
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_print_char
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 1	# 2101
	ori		x4, x0, 1	# 2101
	mul		x4, x4, 4	# 2101
	lw		x5, 0(x2)	# 2101
	add		x4, x5, x4	# 2101
	lw		x4, 0(x4)	# 2101
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_print_int
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 32	# 2102
	ori		x4, x0, 32	# 2102
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_print_char
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 255	# 2103
	ori		x4, x0, 255	# 2103
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_print_int
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 10	# 2104
	ori		x4, x0, 10	# 2104
	jal		x0, min_caml_print_char	# 2104
write_rgb_element_int.2892:
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, int_of_float.2462
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 2109
	lui		x5, 255	# 2110
	ori		x5, x0, 255	# 2110
	ble		x4, x5, ble.9965	# 2110
	lui		x4, 255	# 2110
	ori		x4, x0, 255	# 2110
	jal		x0, ble_cont.9966	# 2110
ble.9965:
	lui		x5, 0	# 2110
	ori		x5, x0, 0	# 2110
	ble		x5, x4, ble.9967	# 2110
	lui		x4, 0	# 2110
	ori		x4, x0, 0	# 2110
	jal		x0, ble_cont.9968	# 2110
ble.9967:
ble_cont.9968:
ble_cont.9966:
	jal		x0, min_caml_print_int	# 2111
write_rgb_element_char.2894:
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, int_of_float.2462
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 2115
	lui		x5, 255	# 2116
	ori		x5, x0, 255	# 2116
	ble		x4, x5, ble.9969	# 2116
	lui		x4, 255	# 2116
	ori		x4, x0, 255	# 2116
	jal		x0, ble_cont.9970	# 2116
ble.9969:
	lui		x5, 0	# 2116
	ori		x5, x0, 0	# 2116
	ble		x5, x4, ble.9971	# 2116
	lui		x4, 0	# 2116
	ori		x4, x0, 0	# 2116
	jal		x0, ble_cont.9972	# 2116
ble.9971:
ble_cont.9972:
ble_cont.9970:
	jal		x0, min_caml_print_char	# 2117
write_rgb.2896:
	lw		x5, 4(x27)	# 2121
	lui		x6, 3	# 2121
	ori		x6, x0, 3	# 2121
	beq		x4, x6, beq.9973	# 2121
	lui		x4, 0	# 2129
	ori		x4, x0, 0	# 2129
	mul		x4, x4, 8	# 2129
	add		x4, x5, x4	# 2129
	flw		f0, 0(x4)	# 2129
	sw		x5, 0(x2)	# 2129
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, write_rgb_element_char.2894
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 1	# 2130
	ori		x4, x0, 1	# 2130
	mul		x4, x4, 8	# 2130
	lw		x5, 0(x2)	# 2130
	add		x4, x5, x4	# 2130
	flw		f0, 0(x4)	# 2130
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, write_rgb_element_char.2894
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 2	# 2131
	ori		x4, x0, 2	# 2131
	mul		x4, x4, 8	# 2131
	lw		x5, 0(x2)	# 2131
	add		x4, x5, x4	# 2131
	flw		f0, 0(x4)	# 2131
	jal		x0, write_rgb_element_char.2894	# 2131
beq.9973:
	lui		x4, 0	# 2122
	ori		x4, x0, 0	# 2122
	mul		x4, x4, 8	# 2122
	add		x4, x5, x4	# 2122
	flw		f0, 0(x4)	# 2122
	sw		x5, 0(x2)	# 2122
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, write_rgb_element_int.2892
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 32	# 2123
	ori		x4, x0, 32	# 2123
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, min_caml_print_char
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 1	# 2124
	ori		x4, x0, 1	# 2124
	mul		x4, x4, 8	# 2124
	lw		x5, 0(x2)	# 2124
	add		x4, x5, x4	# 2124
	flw		f0, 0(x4)	# 2124
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, write_rgb_element_int.2892
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 32	# 2125
	ori		x4, x0, 32	# 2125
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, min_caml_print_char
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 2	# 2126
	ori		x4, x0, 2	# 2126
	mul		x4, x4, 8	# 2126
	lw		x5, 0(x2)	# 2126
	add		x4, x5, x4	# 2126
	flw		f0, 0(x4)	# 2126
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, write_rgb_element_int.2892
	addi	x2, x2, -8
	lw		x1, 4(x2)
	lui		x4, 10	# 2127
	ori		x4, x0, 10	# 2127
	jal		x0, min_caml_print_char	# 2127
pretrace_diffuse_rays.2898:
	lw		x6, 12(x27)	# 2144
	lw		x7, 8(x27)	# 2144
	lw		x8, 4(x27)	# 2144
	lui		x9, 4	# 2144
	ori		x9, x0, 4	# 2144
	ble		x5, x9, ble.9974	# 2144
	jalr	x0, x1, 0
ble.9974:
	sw		x27, 0(x2)	# 2147
	sw		x6, 4(x2)	# 2147
	sw		x7, 8(x2)	# 2147
	sw		x8, 12(x2)	# 2147
	sw		x5, 16(x2)	# 2147
	sw		x4, 20(x2)	# 2147
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, get_surface_id.2874
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2147
	lui		x5, 0	# 2148
	ori		x5, x0, 0	# 2148
	ble		x5, x4, ble.9976	# 2148
	jalr	x0, x1, 0
ble.9976:
	lw		x4, 20(x2)	# 2150
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, p_calc_diffuse.2603
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2150
	lw		x5, 16(x2)	# 2151
	mul		x6, x5, 4	# 2151
	add		x4, x4, x6	# 2151
	lw		x4, 0(x4)	# 2151
	lui		x6, 0	# 2151
	ori		x6, x0, 0	# 2151
	beq		x4, x6, beq.9978	# 2151
	lw		x4, 20(x2)	# 2152
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, p_group_id.2609
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2152
	lw		x5, 12(x2)	# 2153
	sw		x4, 24(x2)	# 2153
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, vecbzero.2525
	addi	x2, x2, -32
	lw		x1, 28(x2)
	lw		x4, 20(x2)	# 2157
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, p_nvectors.2614
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2157
	lw		x5, 20(x2)	# 2158
	sw		x4, 28(x2)	# 2158
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, p_intersection_points.2599
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 2158
	lw		x5, 24(x2)	# 2160
	mul		x5, x5, 4	# 2160
	lw		x6, 8(x2)	# 2160
	add		x5, x6, x5	# 2160
	lw		x5, 0(x5)	# 2160
	lw		x6, 16(x2)	# 2161
	mul		x7, x6, 4	# 2161
	lw		x8, 28(x2)	# 2161
	add		x7, x8, x7	# 2161
	lw		x7, 0(x7)	# 2161
	mul		x8, x6, 4	# 2162
	add		x4, x4, x8	# 2162
	lw		x4, 0(x4)	# 2162
	lw		x27, 4(x2)	# 2159
	addi	x6, x4, 0
	addi	x4, x5, 0
	addi	x5, x7, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	lw		x4, 20(x2)	# 2163
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, p_received_ray_20percent.2607
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 2163
	lw		x5, 16(x2)	# 2164
	mul		x6, x5, 4	# 2164
	add		x4, x4, x6	# 2164
	lw		x4, 0(x4)	# 2164
	lw		x6, 12(x2)	# 2164
	addi	x5, x6, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, veccpy.2527
	addi	x2, x2, -40
	lw		x1, 36(x2)
	jal		x0, beq_cont.9979	# 2151
beq.9978:
beq_cont.9979:
	lw		x4, 16(x2)	# 2166
	addi	x5, x4, 1	# 2166
	lw		x4, 20(x2)	# 2166
	lw		x27, 0(x2)	# 2166
	lw		x31, 0(x27)	# 2166
	jalr	x0, x31, 0	# 2166
pretrace_pixels.2901:
	lw		x7, 36(x27)	# 2174
	lw		x8, 32(x27)	# 2174
	lw		x9, 28(x27)	# 2174
	lw		x11, 24(x27)	# 2174
	lw		x12, 20(x27)	# 2174
	lw		x13, 16(x27)	# 2174
	lw		x14, 12(x27)	# 2174
	lw		x15, 8(x27)	# 2174
	lw		x16, 4(x27)	# 2174
	lui		x17, 0	# 2174
	ori		x17, x0, 0	# 2174
	ble		x17, x5, ble.9980	# 2174
	jalr	x0, x1, 0
ble.9980:
	lui		x17, 0	# 2176
	ori		x17, x0, 0	# 2176
	mul		x17, x17, 8	# 2176
	add		x12, x12, x17	# 2176
	flw		f3, 0(x12)	# 2176
	lui		x12, 0	# 2176
	ori		x12, x0, 0	# 2176
	mul		x12, x12, 4	# 2176
	add		x12, x16, x12	# 2176
	lw		x12, 0(x12)	# 2176
	sub		x12, x5, x12	# 2176
	sw		x27, 0(x2)	# 2176
	sw		x15, 4(x2)	# 2176
	sw		x6, 8(x2)	# 2176
	sw		x8, 12(x2)	# 2176
	sw		x4, 16(x2)	# 2176
	sw		x5, 20(x2)	# 2176
	sw		x7, 24(x2)	# 2176
	sw		x9, 28(x2)	# 2176
	sw		x13, 32(x2)	# 2176
	fsw		f2, 40(x2)	# 2176
	fsw		f1, 48(x2)	# 2176
	sw		x14, 56(x2)	# 2176
	fsw		f0, 64(x2)	# 2176
	sw		x11, 72(x2)	# 2176
	fsw		f3, 80(x2)	# 2176
	addi	x4, x12, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, float_of_int.2464
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 2176
	fadd	f0, f0, f10	# 2176
	flw		f1, 80(x2)	# 2176
	fmul	f0, f1, f0	# 2176
	lui		x4, 0	# 2177
	ori		x4, x0, 0	# 2177
	lui		x5, 0	# 2177
	ori		x5, x0, 0	# 2177
	mul		x5, x5, 8	# 2177
	lw		x6, 72(x2)	# 2177
	add		x5, x6, x5	# 2177
	flw		f1, 0(x5)	# 2177
	fmul	f1, f0, f1	# 2177
	flw		f2, 64(x2)	# 2177
	fadd	f1, f1, f2	# 2177
	mul		x4, x4, 8	# 2177
	lw		x5, 56(x2)	# 2177
	add		x4, x5, x4	# 2177
	fsw		f1, 0(x4)	# 2177
	lui		x4, 1	# 2178
	ori		x4, x0, 1	# 2178
	lui		x7, 1	# 2178
	ori		x7, x0, 1	# 2178
	mul		x7, x7, 8	# 2178
	add		x7, x6, x7	# 2178
	flw		f1, 0(x7)	# 2178
	fmul	f1, f0, f1	# 2178
	flw		f3, 48(x2)	# 2178
	fadd	f1, f1, f3	# 2178
	mul		x4, x4, 8	# 2178
	add		x4, x5, x4	# 2178
	fsw		f1, 0(x4)	# 2178
	lui		x4, 2	# 2179
	ori		x4, x0, 2	# 2179
	lui		x7, 2	# 2179
	ori		x7, x0, 2	# 2179
	mul		x7, x7, 8	# 2179
	add		x6, x6, x7	# 2179
	flw		f1, 0(x6)	# 2179
	fmul	f0, f0, f1	# 2179
	flw		f1, 40(x2)	# 2179
	fadd	f0, f0, f1	# 2179
	mul		x4, x4, 8	# 2179
	add		x4, x5, x4	# 2179
	fsw		f0, 0(x4)	# 2179
	lui		x4, 0	# 2180
	ori		x4, x0, 0	# 2180
	addi	x31, x5, 0
	addi	x5, x4, 0
	addi	x4, x31, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, vecunit_sgn.2530
	addi	x2, x2, -96
	lw		x1, 92(x2)
	lw		x4, 32(x2)	# 2181
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, vecbzero.2525
	addi	x2, x2, -96
	lw		x1, 92(x2)
	lw		x4, 28(x2)	# 2182
	lw		x5, 24(x2)	# 2182
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, veccpy.2527
	addi	x2, x2, -96
	lw		x1, 92(x2)
	lui		x4, 0	# 2185
	ori		x4, x0, 0	# 2185
	lui		x5, %hi(l.6062)	# 2185
	ori		x5, %lo(l.6062)	# 2185
	flw		f0, 0(x5)	# 2185
	lw		x5, 20(x2)	# 2185
	mul		x6, x5, 4	# 2185
	lw		x7, 16(x2)	# 2185
	add		x6, x7, x6	# 2185
	lw		x6, 0(x6)	# 2185
	lui		x8, %hi(l.6055)	# 2185
	ori		x8, %lo(l.6055)	# 2185
	flw		f1, 0(x8)	# 2185
	lw		x8, 56(x2)	# 2185
	lw		x27, 12(x2)	# 2185
	addi	x5, x8, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -96
	lw		x1, 92(x2)
	lw		x4, 20(x2)	# 2186
	mul		x5, x4, 4	# 2186
	lw		x6, 16(x2)	# 2186
	add		x5, x6, x5	# 2186
	lw		x5, 0(x5)	# 2186
	addi	x4, x5, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, p_rgb.2597
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 2186
	lw		x5, 32(x2)	# 2186
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, veccpy.2527
	addi	x2, x2, -96
	lw		x1, 92(x2)
	lw		x4, 20(x2)	# 2187
	mul		x5, x4, 4	# 2187
	lw		x6, 16(x2)	# 2187
	add		x5, x6, x5	# 2187
	lw		x5, 0(x5)	# 2187
	lw		x7, 8(x2)	# 2187
	addi	x4, x5, 0
	addi	x5, x7, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, p_set_group_id.2611
	addi	x2, x2, -96
	lw		x1, 92(x2)
	lw		x4, 20(x2)	# 2190
	mul		x5, x4, 4	# 2190
	lw		x6, 16(x2)	# 2190
	add		x5, x6, x5	# 2190
	lw		x5, 0(x5)	# 2190
	lui		x7, 0	# 2190
	ori		x7, x0, 0	# 2190
	lw		x27, 4(x2)	# 2190
	addi	x4, x5, 0
	addi	x5, x7, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -96
	lw		x1, 92(x2)
	lui		x4, 1	# 2192
	ori		x4, x0, 1	# 2192
	lw		x5, 20(x2)	# 2192
	sub		x4, x5, x4	# 2192
	lui		x5, 1	# 2192
	ori		x5, x0, 1	# 2192
	lw		x6, 8(x2)	# 2192
	sw		x4, 88(x2)	# 2192
	addi	x4, x6, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, add_mod5.2514
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x6, x10, 0	# 2192
	flw		f0, 64(x2)	# 2192
	flw		f1, 48(x2)	# 2192
	flw		f2, 40(x2)	# 2192
	lw		x4, 16(x2)	# 2192
	lw		x5, 88(x2)	# 2192
	lw		x27, 0(x2)	# 2192
	lw		x31, 0(x27)	# 2192
	jalr	x0, x31, 0	# 2192
pretrace_line.2908:
	lw		x7, 24(x27)	# 2199
	lw		x8, 20(x27)	# 2199
	lw		x9, 16(x27)	# 2199
	lw		x11, 12(x27)	# 2199
	lw		x12, 8(x27)	# 2199
	lw		x13, 4(x27)	# 2199
	lui		x14, 0	# 2199
	ori		x14, x0, 0	# 2199
	mul		x14, x14, 8	# 2199
	add		x9, x9, x14	# 2199
	flw		f0, 0(x9)	# 2199
	lui		x9, 1	# 2199
	ori		x9, x0, 1	# 2199
	mul		x9, x9, 4	# 2199
	add		x9, x13, x9	# 2199
	lw		x9, 0(x9)	# 2199
	sub		x5, x5, x9	# 2199
	sw		x6, 0(x2)	# 2199
	sw		x4, 4(x2)	# 2199
	sw		x11, 8(x2)	# 2199
	sw		x12, 12(x2)	# 2199
	sw		x7, 16(x2)	# 2199
	sw		x8, 20(x2)	# 2199
	fsw		f0, 24(x2)	# 2199
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, float_of_int.2464
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 2199
	fadd	f0, f0, f10	# 2199
	flw		f1, 24(x2)	# 2199
	fmul	f0, f1, f0	# 2199
	lui		x4, 0	# 2202
	ori		x4, x0, 0	# 2202
	mul		x4, x4, 8	# 2202
	lw		x5, 20(x2)	# 2202
	add		x4, x5, x4	# 2202
	flw		f1, 0(x4)	# 2202
	fmul	f1, f0, f1	# 2202
	lui		x4, 0	# 2202
	ori		x4, x0, 0	# 2202
	mul		x4, x4, 8	# 2202
	lw		x6, 16(x2)	# 2202
	add		x4, x6, x4	# 2202
	flw		f2, 0(x4)	# 2202
	fadd	f1, f1, f2	# 2202
	lui		x4, 1	# 2203
	ori		x4, x0, 1	# 2203
	mul		x4, x4, 8	# 2203
	add		x4, x5, x4	# 2203
	flw		f2, 0(x4)	# 2203
	fmul	f2, f0, f2	# 2203
	lui		x4, 1	# 2203
	ori		x4, x0, 1	# 2203
	mul		x4, x4, 8	# 2203
	add		x4, x6, x4	# 2203
	flw		f3, 0(x4)	# 2203
	fadd	f2, f2, f3	# 2203
	lui		x4, 2	# 2204
	ori		x4, x0, 2	# 2204
	mul		x4, x4, 8	# 2204
	add		x4, x5, x4	# 2204
	flw		f3, 0(x4)	# 2204
	fmul	f0, f0, f3	# 2204
	lui		x4, 2	# 2204
	ori		x4, x0, 2	# 2204
	mul		x4, x4, 8	# 2204
	add		x4, x6, x4	# 2204
	flw		f3, 0(x4)	# 2204
	fadd	f0, f0, f3	# 2204
	lui		x4, 0	# 2205
	ori		x4, x0, 0	# 2205
	mul		x4, x4, 4	# 2205
	lw		x5, 12(x2)	# 2205
	add		x4, x5, x4	# 2205
	lw		x4, 0(x4)	# 2205
	lui		x5, 1	# 2205
	ori		x5, x0, 1	# 2205
	sub		x5, x4, x5	# 2205
	lw		x4, 4(x2)	# 2205
	lw		x6, 0(x2)	# 2205
	lw		x27, 8(x2)	# 2205
	fsub	f31, f31, f31
	fadd	f31, f31, f2
	fsub	f2, f2, f2
	fadd	f2, f2, f0
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	fsub	f1, f1, f1
	fadd	f1, f1, f31
	lw		x31, 0(x27)	# 2205
	jalr	x0, x31, 0	# 2205
scan_pixel.2912:
	lw		x11, 24(x27)	# 2215
	lw		x12, 20(x27)	# 2215
	lw		x13, 16(x27)	# 2215
	lw		x14, 12(x27)	# 2215
	lw		x15, 8(x27)	# 2215
	lw		x16, 4(x27)	# 2215
	lui		x17, 0	# 2215
	ori		x17, x0, 0	# 2215
	mul		x17, x17, 4	# 2215
	add		x15, x15, x17	# 2215
	lw		x15, 0(x15)	# 2215
	ble		x15, x4, ble.9985	# 2215
	mul		x15, x4, 4	# 2218
	add		x15, x7, x15	# 2218
	lw		x15, 0(x15)	# 2218
	sw		x27, 0(x2)	# 2218
	sw		x9, 4(x2)	# 2218
	sw		x11, 8(x2)	# 2218
	sw		x6, 12(x2)	# 2218
	sw		x12, 16(x2)	# 2218
	sw		x16, 20(x2)	# 2218
	sw		x7, 24(x2)	# 2218
	sw		x8, 28(x2)	# 2218
	sw		x5, 32(x2)	# 2218
	sw		x4, 36(x2)	# 2218
	sw		x14, 40(x2)	# 2218
	sw		x13, 44(x2)	# 2218
	addi	x4, x15, 0
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, p_rgb.2597
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x5, x10, 0	# 2218
	lw		x4, 44(x2)	# 2218
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, veccpy.2527
	addi	x2, x2, -56
	lw		x1, 52(x2)
	lw		x4, 36(x2)	# 2221
	lw		x5, 32(x2)	# 2221
	lw		x6, 28(x2)	# 2221
	lw		x27, 40(x2)	# 2221
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 2221
	lui		x5, 0	# 2221
	ori		x5, x0, 0	# 2221
	beq		x4, x5, beq.9986	# 2221
	lui		x9, 0	# 2222
	ori		x9, x0, 0	# 2222
	lw		x4, 36(x2)	# 2222
	lw		x5, 32(x2)	# 2222
	lw		x6, 12(x2)	# 2222
	lw		x7, 24(x2)	# 2222
	lw		x8, 28(x2)	# 2222
	lw		x27, 16(x2)	# 2222
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	jal		x0, beq_cont.9987	# 2221
beq.9986:
	lw		x4, 36(x2)	# 2224
	mul		x5, x4, 4	# 2224
	lw		x6, 24(x2)	# 2224
	add		x5, x6, x5	# 2224
	lw		x5, 0(x5)	# 2224
	lui		x7, 0	# 2224
	ori		x7, x0, 0	# 2224
	lw		x27, 20(x2)	# 2224
	addi	x4, x5, 0
	addi	x5, x7, 0
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
beq_cont.9987:
	lw		x4, 4(x2)	# 2227
	lw		x27, 8(x2)	# 2227
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	lw		x4, 36(x2)	# 2229
	addi	x4, x4, 1	# 2229
	lw		x5, 32(x2)	# 2229
	lw		x6, 12(x2)	# 2229
	lw		x7, 24(x2)	# 2229
	lw		x8, 28(x2)	# 2229
	lw		x9, 4(x2)	# 2229
	lw		x27, 0(x2)	# 2229
	lw		x31, 0(x27)	# 2229
	jalr	x0, x31, 0	# 2229
ble.9985:
	jalr	x0, x1, 0
scan_line.2919:
	lw		x11, 12(x27)	# 2236
	lw		x12, 8(x27)	# 2236
	lw		x13, 4(x27)	# 2236
	lui		x14, 1	# 2236
	ori		x14, x0, 1	# 2236
	mul		x14, x14, 4	# 2236
	add		x14, x13, x14	# 2236
	lw		x14, 0(x14)	# 2236
	ble		x14, x4, ble.9989	# 2236
	lui		x14, 1	# 2238
	ori		x14, x0, 1	# 2238
	mul		x14, x14, 4	# 2238
	add		x13, x13, x14	# 2238
	lw		x13, 0(x13)	# 2238
	lui		x14, 1	# 2238
	ori		x14, x0, 1	# 2238
	sub		x13, x13, x14	# 2238
	sw		x27, 0(x2)	# 2238
	sw		x8, 4(x2)	# 2238
	sw		x9, 8(x2)	# 2238
	sw		x7, 12(x2)	# 2238
	sw		x6, 16(x2)	# 2238
	sw		x5, 20(x2)	# 2238
	sw		x4, 24(x2)	# 2238
	sw		x11, 28(x2)	# 2238
	ble		x13, x4, ble.9990	# 2238
	addi	x13, x4, 1	# 2239
	addi	x6, x8, 0
	addi	x5, x13, 0
	addi	x4, x7, 0
	addi	x27, x12, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	jal		x0, ble_cont.9991	# 2238
ble.9990:
ble_cont.9991:
	lui		x4, 0	# 2241
	ori		x4, x0, 0	# 2241
	lw		x5, 24(x2)	# 2241
	lw		x6, 20(x2)	# 2241
	lw		x7, 16(x2)	# 2241
	lw		x8, 12(x2)	# 2241
	lw		x9, 8(x2)	# 2241
	lw		x27, 28(x2)	# 2241
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	lw		x4, 24(x2)	# 2242
	addi	x4, x4, 1	# 2242
	lui		x5, 2	# 2242
	ori		x5, x0, 2	# 2242
	lw		x6, 4(x2)	# 2242
	sw		x4, 32(x2)	# 2242
	addi	x4, x6, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, add_mod5.2514
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x8, x10, 0	# 2242
	lw		x4, 32(x2)	# 2242
	lw		x5, 16(x2)	# 2242
	lw		x6, 12(x2)	# 2242
	lw		x7, 20(x2)	# 2242
	lw		x9, 8(x2)	# 2242
	lw		x27, 0(x2)	# 2242
	lw		x31, 0(x27)	# 2242
	jalr	x0, x31, 0	# 2242
ble.9989:
	jalr	x0, x1, 0
create_float5x3array.2926:
	lui		x4, 3	# 2253
	ori		x4, x0, 3	# 2253
	lui		x5, %hi(l.6055)	# 2253
	ori		x5, %lo(l.6055)	# 2253
	flw		f0, 0(x5)	# 2253
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x5, x10, 0	# 2253
	lui		x4, 5	# 2254
	ori		x4, x0, 5	# 2254
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, min_caml_create_array
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 2254
	lui		x5, 1	# 2255
	ori		x5, x0, 1	# 2255
	lui		x6, 3	# 2255
	ori		x6, x0, 3	# 2255
	lui		x7, %hi(l.6055)	# 2255
	ori		x7, %lo(l.6055)	# 2255
	flw		f0, 0(x7)	# 2255
	sw		x4, 0(x2)	# 2255
	sw		x5, 4(x2)	# 2255
	addi	x4, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 2255
	lw		x5, 4(x2)	# 2255
	mul		x5, x5, 4	# 2255
	lw		x6, 0(x2)	# 2255
	add		x5, x6, x5	# 2255
	sw		x4, 0(x5)	# 2255
	lui		x4, 2	# 2256
	ori		x4, x0, 2	# 2256
	lui		x5, 3	# 2256
	ori		x5, x0, 3	# 2256
	lui		x7, %hi(l.6055)	# 2256
	ori		x7, %lo(l.6055)	# 2256
	flw		f0, 0(x7)	# 2256
	sw		x4, 8(x2)	# 2256
	addi	x4, x5, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 2256
	lw		x5, 8(x2)	# 2256
	mul		x5, x5, 4	# 2256
	lw		x6, 0(x2)	# 2256
	add		x5, x6, x5	# 2256
	sw		x4, 0(x5)	# 2256
	lui		x4, 3	# 2257
	ori		x4, x0, 3	# 2257
	lui		x5, 3	# 2257
	ori		x5, x0, 3	# 2257
	lui		x7, %hi(l.6055)	# 2257
	ori		x7, %lo(l.6055)	# 2257
	flw		f0, 0(x7)	# 2257
	sw		x4, 12(x2)	# 2257
	addi	x4, x5, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2257
	lw		x5, 12(x2)	# 2257
	mul		x5, x5, 4	# 2257
	lw		x6, 0(x2)	# 2257
	add		x5, x6, x5	# 2257
	sw		x4, 0(x5)	# 2257
	lui		x4, 4	# 2258
	ori		x4, x0, 4	# 2258
	lui		x5, 3	# 2258
	ori		x5, x0, 3	# 2258
	lui		x7, %hi(l.6055)	# 2258
	ori		x7, %lo(l.6055)	# 2258
	flw		f0, 0(x7)	# 2258
	sw		x4, 16(x2)	# 2258
	addi	x4, x5, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2258
	lw		x5, 16(x2)	# 2258
	mul		x5, x5, 4	# 2258
	lw		x6, 0(x2)	# 2258
	add		x5, x6, x5	# 2258
	sw		x4, 0(x5)	# 2258
	addi	x10, x6, 0	# 2259
	jalr	x0, x1, 0
create_pixel.2928:
	lui		x4, 3	# 2265
	ori		x4, x0, 3	# 2265
	lui		x5, %hi(l.6055)	# 2265
	ori		x5, %lo(l.6055)	# 2265
	flw		f0, 0(x5)	# 2265
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 2265
	sw		x4, 0(x2)	# 2266
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, create_float5x3array.2926
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x4, x10, 0	# 2266
	lui		x5, 5	# 2267
	ori		x5, x0, 5	# 2267
	lui		x6, 0	# 2267
	ori		x6, x0, 0	# 2267
	sw		x4, 4(x2)	# 2267
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 2267
	lui		x5, 5	# 2268
	ori		x5, x0, 5	# 2268
	lui		x6, 0	# 2268
	ori		x6, x0, 0	# 2268
	sw		x4, 8(x2)	# 2268
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 2268
	sw		x4, 12(x2)	# 2269
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, create_float5x3array.2926
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2269
	sw		x4, 16(x2)	# 2270
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, create_float5x3array.2926
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2270
	lui		x5, 1	# 2271
	ori		x5, x0, 1	# 2271
	lui		x6, 0	# 2271
	ori		x6, x0, 0	# 2271
	sw		x4, 20(x2)	# 2271
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, min_caml_create_array
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2271
	sw		x4, 24(x2)	# 2272
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, create_float5x3array.2926
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 2272
	addi	x5, x3, 0	# 2273
	addi	x3, x3, 32	# 2273
	sw		x4, 28(x5)	# 2273
	lw		x4, 24(x2)	# 2273
	sw		x4, 24(x5)	# 2273
	lw		x4, 20(x2)	# 2273
	sw		x4, 20(x5)	# 2273
	lw		x4, 16(x2)	# 2273
	sw		x4, 16(x5)	# 2273
	lw		x4, 12(x2)	# 2273
	sw		x4, 12(x5)	# 2273
	lw		x4, 8(x2)	# 2273
	sw		x4, 8(x5)	# 2273
	lw		x4, 4(x2)	# 2273
	sw		x4, 4(x5)	# 2273
	lw		x4, 0(x2)	# 2273
	sw		x4, 0(x5)	# 2273
	addi	x10, x5, 0	# 2273
	jalr	x0, x1, 0
init_line_elements.2930:
	lui		x6, 0	# 2278
	ori		x6, x0, 0	# 2278
	ble		x6, x5, ble.9993	# 2278
	addi	x10, x4, 0	# 2282
	jalr	x0, x1, 0
ble.9993:
	sw		x4, 0(x2)	# 2279
	sw		x5, 4(x2)	# 2279
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, create_pixel.2928
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 2279
	lw		x5, 4(x2)	# 2279
	mul		x6, x5, 4	# 2279
	lw		x7, 0(x2)	# 2279
	add		x6, x7, x6	# 2279
	sw		x4, 0(x6)	# 2279
	lui		x4, 1	# 2280
	ori		x4, x0, 1	# 2280
	sub		x5, x5, x4	# 2280
	addi	x4, x7, 0
	jal		x0, init_line_elements.2930	# 2280
create_pixelline.2933:
	lw		x4, 4(x27)	# 2287
	lui		x5, 0	# 2287
	ori		x5, x0, 0	# 2287
	mul		x5, x5, 4	# 2287
	add		x5, x4, x5	# 2287
	lw		x5, 0(x5)	# 2287
	sw		x4, 0(x2)	# 2287
	sw		x5, 4(x2)	# 2287
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, create_pixel.2928
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x5, x10, 0	# 2287
	lw		x4, 4(x2)	# 2287
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 2287
	lui		x5, 0	# 2288
	ori		x5, x0, 0	# 2288
	mul		x5, x5, 4	# 2288
	lw		x6, 0(x2)	# 2288
	add		x5, x6, x5	# 2288
	lw		x5, 0(x5)	# 2288
	lui		x6, 2	# 2288
	ori		x6, x0, 2	# 2288
	sub		x5, x5, x6	# 2288
	jal		x0, init_line_elements.2930	# 2288
tan.2935:
	lw		x4, 8(x27)	# 2301
	lw		x5, 4(x27)	# 2301
	fsw		f0, 0(x2)	# 2301
	sw		x5, 8(x2)	# 2301
	addi	x27, x4, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	fsub	f0, f0, f0	# 2301
	fadd	f0, f0, f10	# 2301
	flw		f1, 0(x2)	# 2301
	lw		x27, 8(x2)	# 2301
	fsw		f0, 16(x2)	# 2301
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 28(x2)
	addi	x2, x2, 32
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 2301
	fadd	f0, f0, f10	# 2301
	flw		f1, 16(x2)	# 2301
	fdiv	f10, f1, f0	# 2301
	jalr	x0, x1, 0
adjust_position.2937:
	lw		x4, 8(x27)	# 2306
	lw		x5, 4(x27)	# 2306
	fmul	f0, f0, f0	# 2306
	lui		x6, %hi(l.7029)	# 2306
	ori		x6, %lo(l.7029)	# 2306
	flw		f2, 0(x6)	# 2306
	fadd	f0, f0, f2	# 2306
	sw		x4, 0(x2)	# 2306
	fsw		f1, 8(x2)	# 2306
	sw		x5, 16(x2)	# 2306
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_sqrt
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 2306
	fadd	f0, f0, f10	# 2306
	lui		x4, %hi(l.6062)	# 2307
	ori		x4, %lo(l.6062)	# 2307
	flw		f1, 0(x4)	# 2307
	fdiv	f1, f1, f0	# 2307
	lw		x27, 16(x2)	# 2308
	fsw		f0, 24(x2)	# 2308
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 2308
	fadd	f0, f0, f10	# 2308
	flw		f1, 8(x2)	# 2309
	fmul	f0, f0, f1	# 2309
	lw		x27, 0(x2)	# 2309
	sw		x1, 36(x2)
	addi	x2, x2, 40
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 2309
	fadd	f0, f0, f10	# 2309
	flw		f1, 24(x2)	# 2310
	fmul	f10, f0, f1	# 2310
	jalr	x0, x1, 0
calc_dirvec.2940:
	lw		x7, 8(x27)	# 2315
	lw		x8, 4(x27)	# 2315
	lui		x9, 5	# 2315
	ori		x9, x0, 5	# 2315
	ble		x9, x4, ble.9997	# 2315
	fsw		f2, 0(x2)	# 2330
	sw		x6, 8(x2)	# 2330
	sw		x5, 12(x2)	# 2330
	sw		x27, 16(x2)	# 2330
	fsw		f3, 24(x2)	# 2330
	sw		x8, 32(x2)	# 2330
	sw		x4, 36(x2)	# 2330
	addi	x27, x8, 0
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	fsub	f1, f1, f1
	fadd	f1, f1, f2
	sw		x1, 44(x2)
	addi	x2, x2, 48
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 2330
	fadd	f0, f0, f10	# 2330
	lw		x4, 36(x2)	# 2331
	addi	x4, x4, 1	# 2331
	flw		f1, 24(x2)	# 2331
	lw		x27, 32(x2)	# 2331
	fsw		f0, 40(x2)	# 2331
	sw		x4, 48(x2)	# 2331
	sw		x1, 52(x2)
	addi	x2, x2, 56
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f1, f1, f1	# 2331
	fadd	f1, f1, f10	# 2331
	flw		f0, 40(x2)	# 2331
	flw		f2, 0(x2)	# 2331
	flw		f3, 24(x2)	# 2331
	lw		x4, 48(x2)	# 2331
	lw		x5, 12(x2)	# 2331
	lw		x6, 8(x2)	# 2331
	lw		x27, 16(x2)	# 2331
	lw		x31, 0(x27)	# 2331
	jalr	x0, x31, 0	# 2331
ble.9997:
	sw		x6, 8(x2)	# 2316
	sw		x7, 52(x2)	# 2316
	sw		x5, 12(x2)	# 2316
	fsw		f0, 56(x2)	# 2316
	fsw		f1, 64(x2)	# 2316
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, fsqr.2458
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 2316
	fadd	f0, f0, f10	# 2316
	flw		f1, 64(x2)	# 2316
	fsw		f0, 72(x2)	# 2316
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, fsqr.2458
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 2316
	fadd	f0, f0, f10	# 2316
	flw		f1, 72(x2)	# 2316
	fadd	f0, f1, f0	# 2316
	lui		x4, %hi(l.6062)	# 2316
	ori		x4, %lo(l.6062)	# 2316
	flw		f1, 0(x4)	# 2316
	fadd	f0, f0, f1	# 2316
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, min_caml_sqrt
	addi	x2, x2, -88
	lw		x1, 84(x2)
	fsub	f0, f0, f0	# 2316
	fadd	f0, f0, f10	# 2316
	flw		f1, 56(x2)	# 2317
	fdiv	f1, f1, f0	# 2317
	flw		f2, 64(x2)	# 2318
	fdiv	f2, f2, f0	# 2318
	lui		x4, %hi(l.6062)	# 2319
	ori		x4, %lo(l.6062)	# 2319
	flw		f3, 0(x4)	# 2319
	fdiv	f0, f3, f0	# 2319
	lw		x4, 12(x2)	# 2322
	mul		x4, x4, 4	# 2322
	lw		x5, 52(x2)	# 2322
	add		x4, x5, x4	# 2322
	lw		x4, 0(x4)	# 2322
	lw		x5, 8(x2)	# 2323
	mul		x6, x5, 4	# 2323
	add		x6, x4, x6	# 2323
	lw		x6, 0(x6)	# 2323
	sw		x4, 80(x2)	# 2323
	fsw		f0, 88(x2)	# 2323
	fsw		f2, 96(x2)	# 2323
	fsw		f1, 104(x2)	# 2323
	addi	x4, x6, 0
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, d_vec.2616
	addi	x2, x2, -120
	lw		x1, 116(x2)
	addi	x4, x10, 0	# 2323
	flw		f0, 104(x2)	# 2323
	flw		f1, 96(x2)	# 2323
	flw		f2, 88(x2)	# 2323
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, vecset.2517
	addi	x2, x2, -120
	lw		x1, 116(x2)
	lw		x4, 8(x2)	# 2324
	addi	x5, x4, 40	# 2324
	mul		x5, x5, 4	# 2324
	lw		x6, 80(x2)	# 2324
	add		x5, x6, x5	# 2324
	lw		x5, 0(x5)	# 2324
	addi	x4, x5, 0
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, d_vec.2616
	addi	x2, x2, -120
	lw		x1, 116(x2)
	addi	x4, x10, 0	# 2324
	flw		f0, 96(x2)	# 2324
	sw		x4, 112(x2)	# 2324
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, fneg.2449
	addi	x2, x2, -120
	lw		x1, 116(x2)
	fsub	f2, f2, f2	# 2324
	fadd	f2, f2, f10	# 2324
	flw		f0, 104(x2)	# 2324
	flw		f1, 88(x2)	# 2324
	lw		x4, 112(x2)	# 2324
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, vecset.2517
	addi	x2, x2, -120
	lw		x1, 116(x2)
	lw		x4, 8(x2)	# 2325
	addi	x5, x4, 80	# 2325
	mul		x5, x5, 4	# 2325
	lw		x6, 80(x2)	# 2325
	add		x5, x6, x5	# 2325
	lw		x5, 0(x5)	# 2325
	addi	x4, x5, 0
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, d_vec.2616
	addi	x2, x2, -120
	lw		x1, 116(x2)
	addi	x4, x10, 0	# 2325
	flw		f0, 104(x2)	# 2325
	sw		x4, 116(x2)	# 2325
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, fneg.2449
	addi	x2, x2, -128
	lw		x1, 124(x2)
	fsub	f0, f0, f0	# 2325
	fadd	f0, f0, f10	# 2325
	flw		f1, 96(x2)	# 2325
	fsw		f0, 120(x2)	# 2325
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, fneg.2449
	addi	x2, x2, -136
	lw		x1, 132(x2)
	fsub	f2, f2, f2	# 2325
	fadd	f2, f2, f10	# 2325
	flw		f0, 88(x2)	# 2325
	flw		f1, 120(x2)	# 2325
	lw		x4, 116(x2)	# 2325
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, vecset.2517
	addi	x2, x2, -136
	lw		x1, 132(x2)
	lw		x4, 8(x2)	# 2326
	addi	x5, x4, 1	# 2326
	mul		x5, x5, 4	# 2326
	lw		x6, 80(x2)	# 2326
	add		x5, x6, x5	# 2326
	lw		x5, 0(x5)	# 2326
	addi	x4, x5, 0
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, d_vec.2616
	addi	x2, x2, -136
	lw		x1, 132(x2)
	addi	x4, x10, 0	# 2326
	flw		f0, 104(x2)	# 2326
	sw		x4, 128(x2)	# 2326
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, fneg.2449
	addi	x2, x2, -136
	lw		x1, 132(x2)
	fsub	f0, f0, f0	# 2326
	fadd	f0, f0, f10	# 2326
	flw		f1, 96(x2)	# 2326
	fsw		f0, 136(x2)	# 2326
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, fneg.2449
	addi	x2, x2, -152
	lw		x1, 148(x2)
	fsub	f0, f0, f0	# 2326
	fadd	f0, f0, f10	# 2326
	flw		f1, 88(x2)	# 2326
	fsw		f0, 144(x2)	# 2326
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, fneg.2449
	addi	x2, x2, -160
	lw		x1, 156(x2)
	fsub	f2, f2, f2	# 2326
	fadd	f2, f2, f10	# 2326
	flw		f0, 136(x2)	# 2326
	flw		f1, 144(x2)	# 2326
	lw		x4, 128(x2)	# 2326
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, vecset.2517
	addi	x2, x2, -160
	lw		x1, 156(x2)
	lw		x4, 8(x2)	# 2327
	addi	x5, x4, 41	# 2327
	mul		x5, x5, 4	# 2327
	lw		x6, 80(x2)	# 2327
	add		x5, x6, x5	# 2327
	lw		x5, 0(x5)	# 2327
	addi	x4, x5, 0
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, d_vec.2616
	addi	x2, x2, -160
	lw		x1, 156(x2)
	addi	x4, x10, 0	# 2327
	flw		f0, 104(x2)	# 2327
	sw		x4, 152(x2)	# 2327
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, fneg.2449
	addi	x2, x2, -160
	lw		x1, 156(x2)
	fsub	f0, f0, f0	# 2327
	fadd	f0, f0, f10	# 2327
	flw		f1, 88(x2)	# 2327
	fsw		f0, 160(x2)	# 2327
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, fneg.2449
	addi	x2, x2, -176
	lw		x1, 172(x2)
	fsub	f1, f1, f1	# 2327
	fadd	f1, f1, f10	# 2327
	flw		f0, 160(x2)	# 2327
	flw		f2, 96(x2)	# 2327
	lw		x4, 152(x2)	# 2327
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, vecset.2517
	addi	x2, x2, -176
	lw		x1, 172(x2)
	lw		x4, 8(x2)	# 2328
	addi	x4, x4, 81	# 2328
	mul		x4, x4, 4	# 2328
	lw		x5, 80(x2)	# 2328
	add		x4, x5, x4	# 2328
	lw		x4, 0(x4)	# 2328
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, d_vec.2616
	addi	x2, x2, -176
	lw		x1, 172(x2)
	addi	x4, x10, 0	# 2328
	flw		f0, 88(x2)	# 2328
	sw		x4, 168(x2)	# 2328
	sw		x1, 172(x2)
	addi	x2, x2, 176
	jal		x1, fneg.2449
	addi	x2, x2, -176
	lw		x1, 172(x2)
	fsub	f0, f0, f0	# 2328
	fadd	f0, f0, f10	# 2328
	flw		f1, 104(x2)	# 2328
	flw		f2, 96(x2)	# 2328
	lw		x4, 168(x2)	# 2328
	jal		x0, vecset.2517	# 2328
calc_dirvecs.2948:
	lw		x7, 4(x27)	# 2336
	lui		x8, 0	# 2336
	ori		x8, x0, 0	# 2336
	ble		x8, x4, ble.10002	# 2336
	jalr	x0, x1, 0
ble.10002:
	sw		x27, 0(x2)	# 2338
	sw		x4, 4(x2)	# 2338
	fsw		f0, 8(x2)	# 2338
	sw		x6, 16(x2)	# 2338
	sw		x5, 20(x2)	# 2338
	sw		x7, 24(x2)	# 2338
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, float_of_int.2464
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 2338
	fadd	f0, f0, f10	# 2338
	lui		x4, %hi(l.6088)	# 2338
	ori		x4, %lo(l.6088)	# 2338
	flw		f1, 0(x4)	# 2338
	fmul	f0, f0, f1	# 2338
	lui		x4, %hi(l.7265)	# 2338
	ori		x4, %lo(l.7265)	# 2338
	flw		f1, 0(x4)	# 2338
	fsub	f2, f0, f1	# 2338
	lui		x4, 0	# 2339
	ori		x4, x0, 0	# 2339
	lui		x5, %hi(l.6055)	# 2339
	ori		x5, %lo(l.6055)	# 2339
	flw		f0, 0(x5)	# 2339
	lui		x5, %hi(l.6055)	# 2339
	ori		x5, %lo(l.6055)	# 2339
	flw		f1, 0(x5)	# 2339
	flw		f3, 8(x2)	# 2339
	lw		x5, 20(x2)	# 2339
	lw		x6, 16(x2)	# 2339
	lw		x27, 24(x2)	# 2339
	sw		x1, 28(x2)
	addi	x2, x2, 32
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -32
	lw		x1, 28(x2)
	lw		x4, 4(x2)	# 2341
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, float_of_int.2464
	addi	x2, x2, -32
	lw		x1, 28(x2)
	fsub	f0, f0, f0	# 2341
	fadd	f0, f0, f10	# 2341
	lui		x4, %hi(l.6088)	# 2341
	ori		x4, %lo(l.6088)	# 2341
	flw		f1, 0(x4)	# 2341
	fmul	f0, f0, f1	# 2341
	lui		x4, %hi(l.7029)	# 2341
	ori		x4, %lo(l.7029)	# 2341
	flw		f1, 0(x4)	# 2341
	fadd	f2, f0, f1	# 2341
	lui		x4, 0	# 2342
	ori		x4, x0, 0	# 2342
	lui		x5, %hi(l.6055)	# 2342
	ori		x5, %lo(l.6055)	# 2342
	flw		f0, 0(x5)	# 2342
	lui		x5, %hi(l.6055)	# 2342
	ori		x5, %lo(l.6055)	# 2342
	flw		f1, 0(x5)	# 2342
	lw		x5, 16(x2)	# 2342
	addi	x6, x5, 2	# 2342
	flw		f3, 8(x2)	# 2342
	lw		x7, 20(x2)	# 2342
	lw		x27, 24(x2)	# 2342
	addi	x5, x7, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -32
	lw		x1, 28(x2)
	lui		x4, 1	# 2344
	ori		x4, x0, 1	# 2344
	lw		x5, 4(x2)	# 2344
	sub		x4, x5, x4	# 2344
	lui		x5, 1	# 2344
	ori		x5, x0, 1	# 2344
	lw		x6, 20(x2)	# 2344
	sw		x4, 28(x2)	# 2344
	addi	x4, x6, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, add_mod5.2514
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x5, x10, 0	# 2344
	flw		f0, 8(x2)	# 2344
	lw		x4, 28(x2)	# 2344
	lw		x6, 16(x2)	# 2344
	lw		x27, 0(x2)	# 2344
	lw		x31, 0(x27)	# 2344
	jalr	x0, x31, 0	# 2344
calc_dirvec_rows.2953:
	lw		x7, 4(x27)	# 2350
	lui		x8, 0	# 2350
	ori		x8, x0, 0	# 2350
	ble		x8, x4, ble.10004	# 2350
	jalr	x0, x1, 0
ble.10004:
	sw		x27, 0(x2)	# 2351
	sw		x4, 4(x2)	# 2351
	sw		x6, 8(x2)	# 2351
	sw		x5, 12(x2)	# 2351
	sw		x7, 16(x2)	# 2351
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, float_of_int.2464
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 2351
	fadd	f0, f0, f10	# 2351
	lui		x4, %hi(l.6088)	# 2351
	ori		x4, %lo(l.6088)	# 2351
	flw		f1, 0(x4)	# 2351
	fmul	f0, f0, f1	# 2351
	lui		x4, %hi(l.7265)	# 2351
	ori		x4, %lo(l.7265)	# 2351
	flw		f1, 0(x4)	# 2351
	fsub	f0, f0, f1	# 2351
	lui		x4, 4	# 2352
	ori		x4, x0, 4	# 2352
	lw		x5, 12(x2)	# 2352
	lw		x6, 8(x2)	# 2352
	lw		x27, 16(x2)	# 2352
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lui		x4, 1	# 2353
	ori		x4, x0, 1	# 2353
	lw		x5, 4(x2)	# 2353
	sub		x4, x5, x4	# 2353
	lui		x5, 2	# 2353
	ori		x5, x0, 2	# 2353
	lw		x6, 12(x2)	# 2353
	sw		x4, 20(x2)	# 2353
	addi	x4, x6, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, add_mod5.2514
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x5, x10, 0	# 2353
	lw		x4, 8(x2)	# 2353
	addi	x6, x4, 4	# 2353
	lw		x4, 20(x2)	# 2353
	lw		x27, 0(x2)	# 2353
	lw		x31, 0(x27)	# 2353
	jalr	x0, x31, 0	# 2353
create_dirvec.2957:
	lw		x4, 4(x27)	# 2363
	lui		x5, 3	# 2363
	ori		x5, x0, 3	# 2363
	lui		x6, %hi(l.6055)	# 2363
	ori		x6, %lo(l.6055)	# 2363
	flw		f0, 0(x6)	# 2363
	sw		x4, 0(x2)	# 2363
	addi	x4, x5, 0
	sw		x1, 4(x2)
	addi	x2, x2, 8
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -8
	lw		x1, 4(x2)
	addi	x5, x10, 0	# 2363
	lui		x4, 0	# 2364
	ori		x4, x0, 0	# 2364
	mul		x4, x4, 4	# 2364
	lw		x6, 0(x2)	# 2364
	add		x4, x6, x4	# 2364
	lw		x4, 0(x4)	# 2364
	sw		x5, 4(x2)	# 2364
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 2364
	addi	x5, x3, 0	# 2365
	addi	x3, x3, 8	# 2365
	sw		x4, 4(x5)	# 2365
	lw		x4, 4(x2)	# 2365
	sw		x4, 0(x5)	# 2365
	addi	x10, x5, 0	# 2365
	jalr	x0, x1, 0
create_dirvec_elements.2959:
	lw		x6, 4(x27)	# 2369
	lui		x7, 0	# 2369
	ori		x7, x0, 0	# 2369
	ble		x7, x5, ble.10006	# 2369
	jalr	x0, x1, 0
ble.10006:
	sw		x27, 0(x2)	# 2370
	sw		x4, 4(x2)	# 2370
	sw		x5, 8(x2)	# 2370
	addi	x27, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 2370
	lw		x5, 8(x2)	# 2370
	mul		x6, x5, 4	# 2370
	lw		x7, 4(x2)	# 2370
	add		x6, x7, x6	# 2370
	sw		x4, 0(x6)	# 2370
	lui		x4, 1	# 2371
	ori		x4, x0, 1	# 2371
	sub		x5, x5, x4	# 2371
	lw		x27, 0(x2)	# 2371
	addi	x4, x7, 0
	lw		x31, 0(x27)	# 2371
	jalr	x0, x31, 0	# 2371
create_dirvecs.2962:
	lw		x5, 12(x27)	# 2376
	lw		x6, 8(x27)	# 2376
	lw		x7, 4(x27)	# 2376
	lui		x8, 0	# 2376
	ori		x8, x0, 0	# 2376
	ble		x8, x4, ble.10008	# 2376
	jalr	x0, x1, 0
ble.10008:
	lui		x8, 120	# 2377
	ori		x8, x0, 120	# 2377
	sw		x27, 0(x2)	# 2377
	sw		x6, 4(x2)	# 2377
	sw		x5, 8(x2)	# 2377
	sw		x4, 12(x2)	# 2377
	sw		x8, 16(x2)	# 2377
	addi	x27, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x5, x10, 0	# 2377
	lw		x4, 16(x2)	# 2377
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_create_array
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2377
	lw		x5, 12(x2)	# 2377
	mul		x6, x5, 4	# 2377
	lw		x7, 8(x2)	# 2377
	add		x6, x7, x6	# 2377
	sw		x4, 0(x6)	# 2377
	mul		x4, x5, 4	# 2378
	add		x4, x7, x4	# 2378
	lw		x4, 0(x4)	# 2378
	lui		x6, 118	# 2378
	ori		x6, x0, 118	# 2378
	lw		x27, 4(x2)	# 2378
	addi	x5, x6, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -24
	lw		x1, 20(x2)
	lui		x4, 1	# 2379
	ori		x4, x0, 1	# 2379
	lw		x5, 12(x2)	# 2379
	sub		x4, x5, x4	# 2379
	lw		x27, 0(x2)	# 2379
	lw		x31, 0(x27)	# 2379
	jalr	x0, x31, 0	# 2379
init_dirvec_constants.2964:
	lw		x6, 4(x27)	# 2388
	lui		x7, 0	# 2388
	ori		x7, x0, 0	# 2388
	ble		x7, x5, ble.10010	# 2388
	jalr	x0, x1, 0
ble.10010:
	mul		x7, x5, 4	# 2389
	add		x7, x4, x7	# 2389
	lw		x7, 0(x7)	# 2389
	sw		x4, 0(x2)	# 2389
	sw		x27, 4(x2)	# 2389
	sw		x5, 8(x2)	# 2389
	addi	x4, x7, 0
	addi	x27, x6, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 1	# 2390
	ori		x4, x0, 1	# 2390
	lw		x5, 8(x2)	# 2390
	sub		x5, x5, x4	# 2390
	lw		x4, 0(x2)	# 2390
	lw		x27, 4(x2)	# 2390
	lw		x31, 0(x27)	# 2390
	jalr	x0, x31, 0	# 2390
init_vecset_constants.2967:
	lw		x5, 8(x27)	# 2395
	lw		x6, 4(x27)	# 2395
	lui		x7, 0	# 2395
	ori		x7, x0, 0	# 2395
	ble		x7, x4, ble.10012	# 2395
	jalr	x0, x1, 0
ble.10012:
	mul		x7, x4, 4	# 2396
	add		x6, x6, x7	# 2396
	lw		x6, 0(x6)	# 2396
	lui		x7, 119	# 2396
	ori		x7, x0, 119	# 2396
	sw		x27, 0(x2)	# 2396
	sw		x4, 4(x2)	# 2396
	addi	x4, x6, 0
	addi	x27, x5, 0
	addi	x5, x7, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 1	# 2397
	ori		x4, x0, 1	# 2397
	lw		x5, 4(x2)	# 2397
	sub		x4, x5, x4	# 2397
	lw		x27, 0(x2)	# 2397
	lw		x31, 0(x27)	# 2397
	jalr	x0, x31, 0	# 2397
init_dirvecs.2969:
	lw		x4, 12(x27)	# 2402
	lw		x5, 8(x27)	# 2402
	lw		x6, 4(x27)	# 2402
	lui		x7, 4	# 2402
	ori		x7, x0, 4	# 2402
	sw		x4, 0(x2)	# 2402
	sw		x6, 4(x2)	# 2402
	addi	x4, x7, 0
	addi	x27, x5, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 9	# 2403
	ori		x4, x0, 9	# 2403
	lui		x5, 0	# 2403
	ori		x5, x0, 0	# 2403
	lui		x6, 0	# 2403
	ori		x6, x0, 0	# 2403
	lw		x27, 4(x2)	# 2403
	sw		x1, 12(x2)
	addi	x2, x2, 16
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -16
	lw		x1, 12(x2)
	lui		x4, 4	# 2404
	ori		x4, x0, 4	# 2404
	lw		x27, 0(x2)	# 2404
	lw		x31, 0(x27)	# 2404
	jalr	x0, x31, 0	# 2404
add_reflection.2971:
	lw		x6, 12(x27)	# 2413
	lw		x7, 8(x27)	# 2413
	lw		x27, 4(x27)	# 2413
	sw		x7, 0(x2)	# 2413
	sw		x4, 4(x2)	# 2413
	sw		x5, 8(x2)	# 2413
	fsw		f0, 16(x2)	# 2413
	sw		x6, 24(x2)	# 2413
	fsw		f3, 32(x2)	# 2413
	fsw		f2, 40(x2)	# 2413
	fsw		f1, 48(x2)	# 2413
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 2413
	sw		x4, 56(x2)	# 2414
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, d_vec.2616
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 2414
	flw		f0, 48(x2)	# 2414
	flw		f1, 40(x2)	# 2414
	flw		f2, 32(x2)	# 2414
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, vecset.2517
	addi	x2, x2, -64
	lw		x1, 60(x2)
	lw		x4, 56(x2)	# 2415
	lw		x27, 24(x2)	# 2415
	sw		x1, 60(x2)
	addi	x2, x2, 64
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x3, 0	# 2417
	addi	x3, x3, 16	# 2417
	flw		f0, 16(x2)	# 2417
	fsw		f0, 8(x4)	# 2417
	lw		x5, 56(x2)	# 2417
	sw		x5, 4(x4)	# 2417
	lw		x5, 8(x2)	# 2417
	sw		x5, 0(x4)	# 2417
	lw		x5, 4(x2)	# 2417
	mul		x5, x5, 4	# 2417
	lw		x6, 0(x2)	# 2417
	add		x5, x6, x5	# 2417
	sw		x4, 0(x5)	# 2417
	jalr	x0, x1, 0
setup_rect_reflection.2978:
	lw		x6, 12(x27)	# 2422
	lw		x7, 8(x27)	# 2422
	lw		x8, 4(x27)	# 2422
	lui		x9, 4	# 2422
	ori		x9, x0, 4	# 2422
	mul		x4, x4, x9	# 2422
	lui		x9, 0	# 2423
	ori		x9, x0, 0	# 2423
	mul		x9, x9, 4	# 2423
	add		x9, x6, x9	# 2423
	lw		x9, 0(x9)	# 2423
	lui		x11, %hi(l.6062)	# 2424
	ori		x11, %lo(l.6062)	# 2424
	flw		f0, 0(x11)	# 2424
	sw		x6, 0(x2)	# 2424
	sw		x9, 4(x2)	# 2424
	sw		x8, 8(x2)	# 2424
	sw		x4, 12(x2)	# 2424
	sw		x7, 16(x2)	# 2424
	fsw		f0, 24(x2)	# 2424
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_diffuse.2579
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 2424
	fadd	f0, f0, f10	# 2424
	flw		f1, 24(x2)	# 2424
	fsub	f0, f1, f0	# 2424
	lui		x4, 0	# 2425
	ori		x4, x0, 0	# 2425
	mul		x4, x4, 8	# 2425
	lw		x5, 16(x2)	# 2425
	add		x4, x5, x4	# 2425
	flw		f1, 0(x4)	# 2425
	fsw		f0, 32(x2)	# 2425
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, fneg.2449
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 2425
	fadd	f0, f0, f10	# 2425
	lui		x4, 1	# 2426
	ori		x4, x0, 1	# 2426
	mul		x4, x4, 8	# 2426
	lw		x5, 16(x2)	# 2426
	add		x4, x5, x4	# 2426
	flw		f1, 0(x4)	# 2426
	fsw		f0, 40(x2)	# 2426
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, fneg.2449
	addi	x2, x2, -56
	lw		x1, 52(x2)
	fsub	f0, f0, f0	# 2426
	fadd	f0, f0, f10	# 2426
	lui		x4, 2	# 2427
	ori		x4, x0, 2	# 2427
	mul		x4, x4, 8	# 2427
	lw		x5, 16(x2)	# 2427
	add		x4, x5, x4	# 2427
	flw		f1, 0(x4)	# 2427
	fsw		f0, 48(x2)	# 2427
	fsub	f0, f0, f0
	fadd	f0, f0, f1
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, fneg.2449
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f3, f3, f3	# 2427
	fadd	f3, f3, f10	# 2427
	lw		x4, 12(x2)	# 2428
	addi	x5, x4, 1	# 2428
	lui		x6, 0	# 2428
	ori		x6, x0, 0	# 2428
	mul		x6, x6, 8	# 2428
	lw		x7, 16(x2)	# 2428
	add		x6, x7, x6	# 2428
	flw		f1, 0(x6)	# 2428
	flw		f0, 32(x2)	# 2428
	flw		f2, 48(x2)	# 2428
	lw		x6, 4(x2)	# 2428
	lw		x27, 8(x2)	# 2428
	fsw		f3, 56(x2)	# 2428
	addi	x4, x6, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -72
	lw		x1, 68(x2)
	lw		x4, 4(x2)	# 2429
	addi	x5, x4, 1	# 2429
	lw		x6, 12(x2)	# 2429
	addi	x7, x6, 2	# 2429
	lui		x8, 1	# 2429
	ori		x8, x0, 1	# 2429
	mul		x8, x8, 8	# 2429
	lw		x9, 16(x2)	# 2429
	add		x8, x9, x8	# 2429
	flw		f2, 0(x8)	# 2429
	flw		f0, 32(x2)	# 2429
	flw		f1, 40(x2)	# 2429
	flw		f3, 56(x2)	# 2429
	lw		x27, 8(x2)	# 2429
	addi	x4, x5, 0
	addi	x5, x7, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -72
	lw		x1, 68(x2)
	lw		x4, 4(x2)	# 2430
	addi	x5, x4, 2	# 2430
	lw		x6, 12(x2)	# 2430
	addi	x6, x6, 3	# 2430
	lui		x7, 2	# 2430
	ori		x7, x0, 2	# 2430
	mul		x7, x7, 8	# 2430
	lw		x8, 16(x2)	# 2430
	add		x7, x8, x7	# 2430
	flw		f3, 0(x7)	# 2430
	flw		f0, 32(x2)	# 2430
	flw		f1, 40(x2)	# 2430
	flw		f2, 48(x2)	# 2430
	lw		x27, 8(x2)	# 2430
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -72
	lw		x1, 68(x2)
	lui		x4, 0	# 2431
	ori		x4, x0, 0	# 2431
	lw		x5, 4(x2)	# 2431
	addi	x5, x5, 3	# 2431
	mul		x4, x4, 4	# 2431
	lw		x6, 0(x2)	# 2431
	add		x4, x6, x4	# 2431
	sw		x5, 0(x4)	# 2431
	jalr	x0, x1, 0
setup_surface_reflection.2981:
	lw		x6, 12(x27)	# 2436
	lw		x7, 8(x27)	# 2436
	lw		x8, 4(x27)	# 2436
	lui		x9, 4	# 2436
	ori		x9, x0, 4	# 2436
	mul		x4, x4, x9	# 2436
	addi	x4, x4, 1	# 2436
	lui		x9, 0	# 2437
	ori		x9, x0, 0	# 2437
	mul		x9, x9, 4	# 2437
	add		x9, x6, x9	# 2437
	lw		x9, 0(x9)	# 2437
	lui		x11, %hi(l.6062)	# 2438
	ori		x11, %lo(l.6062)	# 2438
	flw		f0, 0(x11)	# 2438
	sw		x6, 0(x2)	# 2438
	sw		x4, 4(x2)	# 2438
	sw		x9, 8(x2)	# 2438
	sw		x8, 12(x2)	# 2438
	sw		x7, 16(x2)	# 2438
	sw		x5, 20(x2)	# 2438
	fsw		f0, 24(x2)	# 2438
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, o_diffuse.2579
	addi	x2, x2, -40
	lw		x1, 36(x2)
	fsub	f0, f0, f0	# 2438
	fadd	f0, f0, f10	# 2438
	flw		f1, 24(x2)	# 2438
	fsub	f0, f1, f0	# 2438
	lw		x4, 20(x2)	# 2439
	fsw		f0, 32(x2)	# 2439
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, o_param_abc.2571
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x5, x10, 0	# 2439
	lw		x4, 16(x2)	# 2439
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, veciprod.2533
	addi	x2, x2, -48
	lw		x1, 44(x2)
	fsub	f0, f0, f0	# 2439
	fadd	f0, f0, f10	# 2439
	lui		x4, %hi(l.6345)	# 2442
	ori		x4, %lo(l.6345)	# 2442
	flw		f1, 0(x4)	# 2442
	lw		x4, 20(x2)	# 2442
	fsw		f0, 40(x2)	# 2442
	fsw		f1, 48(x2)	# 2442
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, o_param_a.2565
	addi	x2, x2, -64
	lw		x1, 60(x2)
	fsub	f0, f0, f0	# 2442
	fadd	f0, f0, f10	# 2442
	flw		f1, 48(x2)	# 2442
	fmul	f0, f1, f0	# 2442
	flw		f1, 40(x2)	# 2442
	fmul	f0, f0, f1	# 2442
	lui		x4, 0	# 2442
	ori		x4, x0, 0	# 2442
	mul		x4, x4, 8	# 2442
	lw		x5, 16(x2)	# 2442
	add		x4, x5, x4	# 2442
	flw		f2, 0(x4)	# 2442
	fsub	f0, f0, f2	# 2442
	lui		x4, %hi(l.6345)	# 2443
	ori		x4, %lo(l.6345)	# 2443
	flw		f2, 0(x4)	# 2443
	lw		x4, 20(x2)	# 2443
	fsw		f0, 56(x2)	# 2443
	fsw		f2, 64(x2)	# 2443
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, o_param_b.2567
	addi	x2, x2, -80
	lw		x1, 76(x2)
	fsub	f0, f0, f0	# 2443
	fadd	f0, f0, f10	# 2443
	flw		f1, 64(x2)	# 2443
	fmul	f0, f1, f0	# 2443
	flw		f1, 40(x2)	# 2443
	fmul	f0, f0, f1	# 2443
	lui		x4, 1	# 2443
	ori		x4, x0, 1	# 2443
	mul		x4, x4, 8	# 2443
	lw		x5, 16(x2)	# 2443
	add		x4, x5, x4	# 2443
	flw		f2, 0(x4)	# 2443
	fsub	f0, f0, f2	# 2443
	lui		x4, %hi(l.6345)	# 2444
	ori		x4, %lo(l.6345)	# 2444
	flw		f2, 0(x4)	# 2444
	lw		x4, 20(x2)	# 2444
	fsw		f0, 72(x2)	# 2444
	fsw		f2, 80(x2)	# 2444
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, o_param_c.2569
	addi	x2, x2, -96
	lw		x1, 92(x2)
	fsub	f0, f0, f0	# 2444
	fadd	f0, f0, f10	# 2444
	flw		f1, 80(x2)	# 2444
	fmul	f0, f1, f0	# 2444
	flw		f1, 40(x2)	# 2444
	fmul	f0, f0, f1	# 2444
	lui		x4, 2	# 2444
	ori		x4, x0, 2	# 2444
	mul		x4, x4, 8	# 2444
	lw		x5, 16(x2)	# 2444
	add		x4, x5, x4	# 2444
	flw		f1, 0(x4)	# 2444
	fsub	f3, f0, f1	# 2444
	flw		f0, 32(x2)	# 2441
	flw		f1, 56(x2)	# 2441
	flw		f2, 72(x2)	# 2441
	lw		x4, 8(x2)	# 2441
	lw		x5, 4(x2)	# 2441
	lw		x27, 12(x2)	# 2441
	sw		x1, 92(x2)
	addi	x2, x2, 96
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -96
	lw		x1, 92(x2)
	lui		x4, 0	# 2445
	ori		x4, x0, 0	# 2445
	lw		x5, 8(x2)	# 2445
	addi	x5, x5, 1	# 2445
	mul		x4, x4, 4	# 2445
	lw		x6, 0(x2)	# 2445
	add		x4, x6, x4	# 2445
	sw		x5, 0(x4)	# 2445
	jalr	x0, x1, 0
setup_reflections.2984:
	lw		x5, 12(x27)	# 2451
	lw		x6, 8(x27)	# 2451
	lw		x7, 4(x27)	# 2451
	lui		x8, 0	# 2451
	ori		x8, x0, 0	# 2451
	ble		x8, x4, ble.10020	# 2451
	jalr	x0, x1, 0
ble.10020:
	mul		x8, x4, 4	# 2452
	add		x7, x7, x8	# 2452
	lw		x7, 0(x7)	# 2452
	sw		x5, 0(x2)	# 2453
	sw		x4, 4(x2)	# 2453
	sw		x6, 8(x2)	# 2453
	sw		x7, 12(x2)	# 2453
	addi	x4, x7, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_reflectiontype.2559
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2453
	lui		x5, 2	# 2453
	ori		x5, x0, 2	# 2453
	beq		x4, x5, beq.10022	# 2453
	jalr	x0, x1, 0
beq.10022:
	lw		x4, 12(x2)	# 2454
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_diffuse.2579
	addi	x2, x2, -24
	lw		x1, 20(x2)
	fsub	f0, f0, f0	# 2454
	fadd	f0, f0, f10	# 2454
	lui		x4, %hi(l.6062)	# 2454
	ori		x4, %lo(l.6062)	# 2454
	flw		f1, 0(x4)	# 2454
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, fless.2453
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2454
	lui		x5, 0	# 2454
	ori		x5, x0, 0	# 2454
	beq		x4, x5, beq.10024	# 2454
	lw		x4, 12(x2)	# 2455
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, o_form.2557
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 2455
	lui		x5, 1	# 2457
	ori		x5, x0, 1	# 2457
	beq		x4, x5, beq.10025	# 2457
	lui		x5, 2	# 2459
	ori		x5, x0, 2	# 2459
	beq		x4, x5, beq.10026	# 2459
	jalr	x0, x1, 0
beq.10026:
	lw		x4, 4(x2)	# 2460
	lw		x5, 12(x2)	# 2460
	lw		x27, 0(x2)	# 2460
	lw		x31, 0(x27)	# 2460
	jalr	x0, x31, 0	# 2460
beq.10025:
	lw		x4, 4(x2)	# 2458
	lw		x5, 12(x2)	# 2458
	lw		x27, 8(x2)	# 2458
	lw		x31, 0(x27)	# 2458
	jalr	x0, x31, 0	# 2458
beq.10024:
	jalr	x0, x1, 0
rt.2986:
	lw		x7, 56(x27)	# 2473
	lw		x8, 52(x27)	# 2473
	lw		x9, 48(x27)	# 2473
	lw		x11, 44(x27)	# 2473
	lw		x12, 40(x27)	# 2473
	lw		x13, 36(x27)	# 2473
	lw		x14, 32(x27)	# 2473
	lw		x15, 28(x27)	# 2473
	lw		x16, 24(x27)	# 2473
	lw		x17, 20(x27)	# 2473
	lw		x18, 16(x27)	# 2473
	lw		x19, 12(x27)	# 2473
	lw		x20, 8(x27)	# 2473
	lw		x21, 4(x27)	# 2473
	lui		x22, 0	# 2473
	ori		x22, x0, 0	# 2473
	mul		x22, x22, 4	# 2473
	add		x22, x19, x22	# 2473
	sw		x4, 0(x22)	# 2473
	lui		x22, 1	# 2474
	ori		x22, x0, 1	# 2474
	mul		x22, x22, 4	# 2474
	add		x19, x19, x22	# 2474
	sw		x5, 0(x19)	# 2474
	lui		x19, 0	# 2475
	ori		x19, x0, 0	# 2475
	lui		x22, 2	# 2475
	ori		x22, x0, 2	# 2475
	div		x22, x4, x22	# 2475
	mul		x19, x19, 4	# 2475
	add		x19, x20, x19	# 2475
	sw		x22, 0(x19)	# 2475
	lui		x19, 1	# 2476
	ori		x19, x0, 1	# 2476
	lui		x22, 2	# 2476
	ori		x22, x0, 2	# 2476
	div		x5, x5, x22	# 2476
	mul		x19, x19, 4	# 2476
	add		x19, x20, x19	# 2476
	sw		x5, 0(x19)	# 2476
	lui		x5, 0	# 2477
	ori		x5, x0, 0	# 2477
	lui		x19, %hi(l.7339)	# 2477
	ori		x19, %lo(l.7339)	# 2477
	flw		f0, 0(x19)	# 2477
	sw		x12, 0(x2)	# 2477
	sw		x14, 4(x2)	# 2477
	sw		x8, 8(x2)	# 2477
	sw		x15, 12(x2)	# 2477
	sw		x9, 16(x2)	# 2477
	sw		x17, 20(x2)	# 2477
	sw		x16, 24(x2)	# 2477
	sw		x18, 28(x2)	# 2477
	sw		x6, 32(x2)	# 2477
	sw		x7, 36(x2)	# 2477
	sw		x13, 40(x2)	# 2477
	sw		x21, 44(x2)	# 2477
	sw		x11, 48(x2)	# 2477
	sw		x5, 52(x2)	# 2477
	fsw		f0, 56(x2)	# 2477
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, float_of_int.2464
	addi	x2, x2, -72
	lw		x1, 68(x2)
	fsub	f0, f0, f0	# 2477
	fadd	f0, f0, f10	# 2477
	flw		f1, 56(x2)	# 2477
	fdiv	f0, f1, f0	# 2477
	lw		x4, 52(x2)	# 2477
	mul		x4, x4, 8	# 2477
	lw		x5, 48(x2)	# 2477
	add		x4, x5, x4	# 2477
	fsw		f0, 0(x4)	# 2477
	lw		x27, 44(x2)	# 2478
	sw		x1, 68(x2)
	addi	x2, x2, 72
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 2478
	lw		x27, 44(x2)	# 2479
	sw		x4, 64(x2)	# 2479
	sw		x1, 68(x2)
	addi	x2, x2, 72
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 2479
	lw		x27, 44(x2)	# 2480
	sw		x4, 68(x2)	# 2480
	sw		x1, 76(x2)
	addi	x2, x2, 80
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 2480
	lw		x27, 40(x2)	# 2481
	sw		x4, 72(x2)	# 2481
	sw		x1, 76(x2)
	addi	x2, x2, 80
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -80
	lw		x1, 76(x2)
	lw		x4, 32(x2)	# 2482
	lw		x27, 36(x2)	# 2482
	sw		x1, 76(x2)
	addi	x2, x2, 80
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -80
	lw		x1, 76(x2)
	lw		x27, 28(x2)	# 2483
	sw		x1, 76(x2)
	addi	x2, x2, 80
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -80
	lw		x1, 76(x2)
	lw		x4, 24(x2)	# 2484
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, d_vec.2616
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 2484
	lw		x5, 20(x2)	# 2484
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, veccpy.2527
	addi	x2, x2, -80
	lw		x1, 76(x2)
	lw		x4, 24(x2)	# 2485
	lw		x27, 16(x2)	# 2485
	sw		x1, 76(x2)
	addi	x2, x2, 80
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -80
	lw		x1, 76(x2)
	lui		x4, 0	# 2486
	ori		x4, x0, 0	# 2486
	mul		x4, x4, 4	# 2486
	lw		x5, 12(x2)	# 2486
	add		x4, x5, x4	# 2486
	lw		x4, 0(x4)	# 2486
	lui		x5, 1	# 2486
	ori		x5, x0, 1	# 2486
	sub		x4, x4, x5	# 2486
	lw		x27, 8(x2)	# 2486
	sw		x1, 76(x2)
	addi	x2, x2, 80
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -80
	lw		x1, 76(x2)
	lui		x5, 0	# 2487
	ori		x5, x0, 0	# 2487
	lui		x6, 0	# 2487
	ori		x6, x0, 0	# 2487
	lw		x4, 68(x2)	# 2487
	lw		x27, 4(x2)	# 2487
	sw		x1, 76(x2)
	addi	x2, x2, 80
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -80
	lw		x1, 76(x2)
	lui		x4, 0	# 2488
	ori		x4, x0, 0	# 2488
	lui		x8, 2	# 2488
	ori		x8, x0, 2	# 2488
	lw		x5, 64(x2)	# 2488
	lw		x6, 68(x2)	# 2488
	lw		x7, 72(x2)	# 2488
	lw		x9, 32(x2)	# 2488
	lw		x27, 0(x2)	# 2488
	lw		x31, 0(x27)	# 2488
	jalr	x0, x31, 0	# 2488
min_caml_start:
	addi	x2, x2, -112
	addi	x29, x0, 0
	addi	x30, x0, 0
	lui		x4, %hi(l.7345)	# 12
	ori		x4, %lo(l.7345)	# 12
	flw		f0, 0(x4)	# 12
	lui		x4, %hi(l.7347)	# 13
	ori		x4, %lo(l.7347)	# 13
	flw		f1, 0(x4)	# 13
	lui		x4, %hi(l.7349)	# 14
	ori		x4, %lo(l.7349)	# 14
	flw		f2, 0(x4)	# 14
	lui		x4, %hi(l.7351)	# 15
	ori		x4, %lo(l.7351)	# 15
	flw		f3, 0(x4)	# 15
	addi	x4, x3, 0	# 26
	addi	x3, x3, 40	# 26
	lui		x5, %hi(sin.2470)	# 26
	ori		x5, %lo(sin.2470)	# 26
	sw		x5, 0(x4)	# 37
	fsw		f3, 32(x4)	# 37
	fsw		f2, 24(x4)	# 37
	fsw		f1, 16(x4)	# 37
	fsw		f0, 8(x4)	# 37
	addi	x5, x3, 0	# 37
	addi	x3, x3, 32	# 37
	lui		x6, %hi(cos.2472)	# 37
	ori		x6, %lo(cos.2472)	# 37
	sw		x6, 0(x5)	# 45
	sw		x4, 24(x5)	# 45
	fsw		f3, 16(x5)	# 45
	fsw		f2, 8(x5)	# 45
	addi	x6, x3, 0	# 45
	addi	x3, x3, 16	# 45
	lui		x7, %hi(atan.2474)	# 45
	ori		x7, %lo(atan.2474)	# 45
	sw		x7, 0(x6)	# 57
	fsw		f2, 8(x6)	# 57
	lui		x7, 1	# 57
	ori		x7, x0, 1	# 57
	lui		x8, 0	# 57
	ori		x8, x0, 0	# 57
	sw		x6, 0(x2)	# 57
	sw		x5, 4(x2)	# 57
	sw		x4, 8(x2)	# 57
	addi	x5, x8, 0
	addi	x4, x7, 0
	sw		x1, 12(x2)
	addi	x2, x2, 16
	jal		x1, min_caml_create_array
	addi	x2, x2, -16
	lw		x1, 12(x2)
	addi	x4, x10, 0	# 57
	lui		x5, 0	# 62
	ori		x5, x0, 0	# 62
	lui		x6, %hi(l.6055)	# 62
	ori		x6, %lo(l.6055)	# 62
	flw		f0, 0(x6)	# 62
	sw		x4, 12(x2)	# 62
	addi	x4, x5, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 62
	lui		x5, 60	# 63
	ori		x5, x0, 60	# 63
	lui		x6, 0	# 63
	ori		x6, x0, 0	# 63
	lui		x7, 0	# 63
	ori		x7, x0, 0	# 63
	lui		x8, 0	# 63
	ori		x8, x0, 0	# 63
	lui		x9, 0	# 63
	ori		x9, x0, 0	# 63
	lui		x11, 0	# 63
	ori		x11, x0, 0	# 63
	addi	x12, x3, 0	# 63
	addi	x3, x3, 48	# 63
	sw		x4, 40(x12)	# 63
	sw		x4, 36(x12)	# 63
	sw		x4, 32(x12)	# 63
	sw		x4, 28(x12)	# 63
	sw		x11, 24(x12)	# 63
	sw		x4, 20(x12)	# 63
	sw		x4, 16(x12)	# 63
	sw		x9, 12(x12)	# 63
	sw		x8, 8(x12)	# 63
	sw		x7, 4(x12)	# 63
	sw		x6, 0(x12)	# 63
	addi	x4, x12, 0	# 63
	addi	x31, x5, 0
	addi	x5, x4, 0
	addi	x4, x31, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_create_array
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 63
	lui		x5, 3	# 67
	ori		x5, x0, 3	# 67
	lui		x6, %hi(l.6055)	# 67
	ori		x6, %lo(l.6055)	# 67
	flw		f0, 0(x6)	# 67
	sw		x4, 16(x2)	# 67
	addi	x4, x5, 0
	sw		x1, 20(x2)
	addi	x2, x2, 24
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -24
	lw		x1, 20(x2)
	addi	x4, x10, 0	# 67
	lui		x5, 3	# 70
	ori		x5, x0, 3	# 70
	lui		x6, %hi(l.6055)	# 70
	ori		x6, %lo(l.6055)	# 70
	flw		f0, 0(x6)	# 70
	sw		x4, 20(x2)	# 70
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 70
	lui		x5, 3	# 73
	ori		x5, x0, 3	# 73
	lui		x6, %hi(l.6055)	# 73
	ori		x6, %lo(l.6055)	# 73
	flw		f0, 0(x6)	# 73
	sw		x4, 24(x2)	# 73
	addi	x4, x5, 0
	sw		x1, 28(x2)
	addi	x2, x2, 32
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -32
	lw		x1, 28(x2)
	addi	x4, x10, 0	# 73
	lui		x5, 1	# 76
	ori		x5, x0, 1	# 76
	lui		x6, %hi(l.6931)	# 76
	ori		x6, %lo(l.6931)	# 76
	flw		f0, 0(x6)	# 76
	sw		x4, 28(x2)	# 76
	addi	x4, x5, 0
	sw		x1, 36(x2)
	addi	x2, x2, 40
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -40
	lw		x1, 36(x2)
	addi	x4, x10, 0	# 76
	lui		x5, 50	# 79
	ori		x5, x0, 50	# 79
	lui		x6, 1	# 79
	ori		x6, x0, 1	# 79
	lui		x7, -1	# 79
	ori		x7, x0, -1	# 79
	sw		x4, 32(x2)	# 79
	sw		x5, 36(x2)	# 79
	addi	x5, x7, 0
	addi	x4, x6, 0
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, min_caml_create_array
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x5, x10, 0	# 79
	lw		x4, 36(x2)	# 79
	sw		x1, 44(x2)
	addi	x2, x2, 48
	jal		x1, min_caml_create_array
	addi	x2, x2, -48
	lw		x1, 44(x2)
	addi	x4, x10, 0	# 79
	lui		x5, 1	# 82
	ori		x5, x0, 1	# 82
	lui		x6, 1	# 82
	ori		x6, x0, 1	# 82
	lui		x7, 0	# 82
	ori		x7, x0, 0	# 82
	mul		x7, x7, 4	# 82
	add		x7, x4, x7	# 82
	lw		x7, 0(x7)	# 82
	sw		x4, 40(x2)	# 82
	sw		x5, 44(x2)	# 82
	addi	x5, x7, 0
	addi	x4, x6, 0
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, min_caml_create_array
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x5, x10, 0	# 82
	lw		x4, 44(x2)	# 82
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, min_caml_create_array
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 82
	lui		x5, 1	# 87
	ori		x5, x0, 1	# 87
	lui		x6, %hi(l.6055)	# 87
	ori		x6, %lo(l.6055)	# 87
	flw		f0, 0(x6)	# 87
	sw		x4, 48(x2)	# 87
	addi	x4, x5, 0
	sw		x1, 52(x2)
	addi	x2, x2, 56
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -56
	lw		x1, 52(x2)
	addi	x4, x10, 0	# 87
	lui		x5, 1	# 90
	ori		x5, x0, 1	# 90
	lui		x6, 0	# 90
	ori		x6, x0, 0	# 90
	sw		x4, 52(x2)	# 90
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, min_caml_create_array
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 90
	lui		x5, 1	# 93
	ori		x5, x0, 1	# 93
	lui		x6, %hi(l.6812)	# 93
	ori		x6, %lo(l.6812)	# 93
	flw		f0, 0(x6)	# 93
	sw		x4, 56(x2)	# 93
	addi	x4, x5, 0
	sw		x1, 60(x2)
	addi	x2, x2, 64
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -64
	lw		x1, 60(x2)
	addi	x4, x10, 0	# 93
	lui		x5, 3	# 96
	ori		x5, x0, 3	# 96
	lui		x6, %hi(l.6055)	# 96
	ori		x6, %lo(l.6055)	# 96
	flw		f0, 0(x6)	# 96
	sw		x4, 60(x2)	# 96
	addi	x4, x5, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 96
	lui		x5, 1	# 99
	ori		x5, x0, 1	# 99
	lui		x6, 0	# 99
	ori		x6, x0, 0	# 99
	sw		x4, 64(x2)	# 99
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 68(x2)
	addi	x2, x2, 72
	jal		x1, min_caml_create_array
	addi	x2, x2, -72
	lw		x1, 68(x2)
	addi	x4, x10, 0	# 99
	lui		x5, 3	# 102
	ori		x5, x0, 3	# 102
	lui		x6, %hi(l.6055)	# 102
	ori		x6, %lo(l.6055)	# 102
	flw		f0, 0(x6)	# 102
	sw		x4, 68(x2)	# 102
	addi	x4, x5, 0
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 102
	lui		x5, 3	# 105
	ori		x5, x0, 3	# 105
	lui		x6, %hi(l.6055)	# 105
	ori		x6, %lo(l.6055)	# 105
	flw		f0, 0(x6)	# 105
	sw		x4, 72(x2)	# 105
	addi	x4, x5, 0
	sw		x1, 76(x2)
	addi	x2, x2, 80
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -80
	lw		x1, 76(x2)
	addi	x4, x10, 0	# 105
	lui		x5, 3	# 109
	ori		x5, x0, 3	# 109
	lui		x6, %hi(l.6055)	# 109
	ori		x6, %lo(l.6055)	# 109
	flw		f0, 0(x6)	# 109
	sw		x4, 76(x2)	# 109
	addi	x4, x5, 0
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 109
	lui		x5, 3	# 112
	ori		x5, x0, 3	# 112
	lui		x6, %hi(l.6055)	# 112
	ori		x6, %lo(l.6055)	# 112
	flw		f0, 0(x6)	# 112
	sw		x4, 80(x2)	# 112
	addi	x4, x5, 0
	sw		x1, 84(x2)
	addi	x2, x2, 88
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -88
	lw		x1, 84(x2)
	addi	x4, x10, 0	# 112
	lui		x5, 2	# 116
	ori		x5, x0, 2	# 116
	lui		x6, 0	# 116
	ori		x6, x0, 0	# 116
	sw		x4, 84(x2)	# 116
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, min_caml_create_array
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 116
	lui		x5, 2	# 119
	ori		x5, x0, 2	# 119
	lui		x6, 0	# 119
	ori		x6, x0, 0	# 119
	sw		x4, 88(x2)	# 119
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 92(x2)
	addi	x2, x2, 96
	jal		x1, min_caml_create_array
	addi	x2, x2, -96
	lw		x1, 92(x2)
	addi	x4, x10, 0	# 119
	lui		x5, 1	# 122
	ori		x5, x0, 1	# 122
	lui		x6, %hi(l.6055)	# 122
	ori		x6, %lo(l.6055)	# 122
	flw		f0, 0(x6)	# 122
	sw		x4, 92(x2)	# 122
	addi	x4, x5, 0
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -104
	lw		x1, 100(x2)
	addi	x4, x10, 0	# 122
	lui		x5, 3	# 126
	ori		x5, x0, 3	# 126
	lui		x6, %hi(l.6055)	# 126
	ori		x6, %lo(l.6055)	# 126
	flw		f0, 0(x6)	# 126
	sw		x4, 96(x2)	# 126
	addi	x4, x5, 0
	sw		x1, 100(x2)
	addi	x2, x2, 104
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -104
	lw		x1, 100(x2)
	addi	x4, x10, 0	# 126
	lui		x5, 3	# 129
	ori		x5, x0, 3	# 129
	lui		x6, %hi(l.6055)	# 129
	ori		x6, %lo(l.6055)	# 129
	flw		f0, 0(x6)	# 129
	sw		x4, 100(x2)	# 129
	addi	x4, x5, 0
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -112
	lw		x1, 108(x2)
	addi	x4, x10, 0	# 129
	lui		x5, 3	# 133
	ori		x5, x0, 3	# 133
	lui		x6, %hi(l.6055)	# 133
	ori		x6, %lo(l.6055)	# 133
	flw		f0, 0(x6)	# 133
	sw		x4, 104(x2)	# 133
	addi	x4, x5, 0
	sw		x1, 108(x2)
	addi	x2, x2, 112
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -112
	lw		x1, 108(x2)
	addi	x4, x10, 0	# 133
	lui		x5, 3	# 135
	ori		x5, x0, 3	# 135
	lui		x6, %hi(l.6055)	# 135
	ori		x6, %lo(l.6055)	# 135
	flw		f0, 0(x6)	# 135
	sw		x4, 108(x2)	# 135
	addi	x4, x5, 0
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -120
	lw		x1, 116(x2)
	addi	x4, x10, 0	# 135
	lui		x5, 3	# 137
	ori		x5, x0, 3	# 137
	lui		x6, %hi(l.6055)	# 137
	ori		x6, %lo(l.6055)	# 137
	flw		f0, 0(x6)	# 137
	sw		x4, 112(x2)	# 137
	addi	x4, x5, 0
	sw		x1, 116(x2)
	addi	x2, x2, 120
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -120
	lw		x1, 116(x2)
	addi	x4, x10, 0	# 137
	lui		x5, 3	# 141
	ori		x5, x0, 3	# 141
	lui		x6, %hi(l.6055)	# 141
	ori		x6, %lo(l.6055)	# 141
	flw		f0, 0(x6)	# 141
	sw		x4, 116(x2)	# 141
	addi	x4, x5, 0
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -128
	lw		x1, 124(x2)
	addi	x4, x10, 0	# 141
	lui		x5, 0	# 146
	ori		x5, x0, 0	# 146
	lui		x6, %hi(l.6055)	# 146
	ori		x6, %lo(l.6055)	# 146
	flw		f0, 0(x6)	# 146
	sw		x4, 120(x2)	# 146
	addi	x4, x5, 0
	sw		x1, 124(x2)
	addi	x2, x2, 128
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -128
	lw		x1, 124(x2)
	addi	x5, x10, 0	# 146
	lui		x4, 0	# 147
	ori		x4, x0, 0	# 147
	sw		x5, 124(x2)	# 147
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, min_caml_create_array
	addi	x2, x2, -136
	lw		x1, 132(x2)
	addi	x4, x10, 0	# 147
	lui		x5, 0	# 148
	ori		x5, x0, 0	# 148
	addi	x6, x3, 0	# 148
	addi	x3, x3, 8	# 148
	sw		x4, 4(x6)	# 148
	lw		x4, 124(x2)	# 148
	sw		x4, 0(x6)	# 148
	addi	x4, x6, 0	# 148
	addi	x31, x5, 0
	addi	x5, x4, 0
	addi	x4, x31, 0
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, min_caml_create_array
	addi	x2, x2, -136
	lw		x1, 132(x2)
	addi	x5, x10, 0	# 148
	lui		x4, 5	# 149
	ori		x4, x0, 5	# 149
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, min_caml_create_array
	addi	x2, x2, -136
	lw		x1, 132(x2)
	addi	x4, x10, 0	# 149
	lui		x5, 0	# 154
	ori		x5, x0, 0	# 154
	lui		x6, %hi(l.6055)	# 154
	ori		x6, %lo(l.6055)	# 154
	flw		f0, 0(x6)	# 154
	sw		x4, 128(x2)	# 154
	addi	x4, x5, 0
	sw		x1, 132(x2)
	addi	x2, x2, 136
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -136
	lw		x1, 132(x2)
	addi	x4, x10, 0	# 154
	lui		x5, 3	# 155
	ori		x5, x0, 3	# 155
	lui		x6, %hi(l.6055)	# 155
	ori		x6, %lo(l.6055)	# 155
	flw		f0, 0(x6)	# 155
	sw		x4, 132(x2)	# 155
	addi	x4, x5, 0
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -144
	lw		x1, 140(x2)
	addi	x4, x10, 0	# 155
	lui		x5, 60	# 156
	ori		x5, x0, 60	# 156
	lw		x6, 132(x2)	# 156
	sw		x4, 136(x2)	# 156
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 140(x2)
	addi	x2, x2, 144
	jal		x1, min_caml_create_array
	addi	x2, x2, -144
	lw		x1, 140(x2)
	addi	x4, x10, 0	# 156
	addi	x5, x3, 0	# 157
	addi	x3, x3, 8	# 157
	sw		x4, 4(x5)	# 157
	lw		x4, 136(x2)	# 157
	sw		x4, 0(x5)	# 157
	addi	x4, x5, 0	# 157
	lui		x5, 0	# 162
	ori		x5, x0, 0	# 162
	lui		x6, %hi(l.6055)	# 162
	ori		x6, %lo(l.6055)	# 162
	flw		f0, 0(x6)	# 162
	sw		x4, 140(x2)	# 162
	addi	x4, x5, 0
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, min_caml_create_float_array
	addi	x2, x2, -152
	lw		x1, 148(x2)
	addi	x5, x10, 0	# 162
	lui		x4, 0	# 163
	ori		x4, x0, 0	# 163
	sw		x5, 144(x2)	# 163
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, min_caml_create_array
	addi	x2, x2, -152
	lw		x1, 148(x2)
	addi	x4, x10, 0	# 163
	addi	x5, x3, 0	# 164
	addi	x3, x3, 8	# 164
	sw		x4, 4(x5)	# 164
	lw		x4, 144(x2)	# 164
	sw		x4, 0(x5)	# 164
	addi	x4, x5, 0	# 164
	lui		x5, 180	# 165
	ori		x5, x0, 180	# 165
	lui		x6, 0	# 165
	ori		x6, x0, 0	# 165
	lui		x7, %hi(l.6055)	# 165
	ori		x7, %lo(l.6055)	# 165
	flw		f0, 0(x7)	# 165
	addi	x7, x3, 0	# 165
	addi	x3, x3, 16	# 165
	fsw		f0, 8(x7)	# 165
	sw		x4, 4(x7)	# 165
	sw		x6, 0(x7)	# 165
	addi	x4, x7, 0	# 165
	addi	x31, x5, 0
	addi	x5, x4, 0
	addi	x4, x31, 0
	sw		x1, 148(x2)
	addi	x2, x2, 152
	jal		x1, min_caml_create_array
	addi	x2, x2, -152
	lw		x1, 148(x2)
	addi	x4, x10, 0	# 165
	lui		x5, 1	# 169
	ori		x5, x0, 1	# 169
	lui		x6, 0	# 169
	ori		x6, x0, 0	# 169
	sw		x4, 148(x2)	# 169
	addi	x4, x5, 0
	addi	x5, x6, 0
	sw		x1, 156(x2)
	addi	x2, x2, 160
	jal		x1, min_caml_create_array
	addi	x2, x2, -160
	lw		x1, 156(x2)
	addi	x4, x10, 0	# 169
	addi	x5, x3, 0	# 662
	addi	x3, x3, 32	# 662
	lui		x6, %hi(read_screen_settings.2628)	# 662
	ori		x6, %lo(read_screen_settings.2628)	# 662
	sw		x6, 0(x5)	# 695
	lw		x6, 24(x2)	# 695
	sw		x6, 28(x5)	# 695
	lw		x7, 8(x2)	# 695
	sw		x7, 24(x5)	# 695
	lw		x8, 116(x2)	# 695
	sw		x8, 20(x5)	# 695
	lw		x9, 112(x2)	# 695
	sw		x9, 16(x5)	# 695
	lw		x11, 108(x2)	# 695
	sw		x11, 12(x5)	# 695
	lw		x12, 20(x2)	# 695
	sw		x12, 8(x5)	# 695
	lw		x12, 4(x2)	# 695
	sw		x12, 4(x5)	# 695
	addi	x13, x3, 0	# 695
	addi	x3, x3, 24	# 695
	lui		x14, %hi(read_light.2630)	# 695
	ori		x14, %lo(read_light.2630)	# 695
	sw		x14, 0(x13)	# 717
	sw		x7, 16(x13)	# 717
	lw		x14, 28(x2)	# 717
	sw		x14, 12(x13)	# 717
	sw		x12, 8(x13)	# 717
	lw		x15, 32(x2)	# 717
	sw		x15, 4(x13)	# 717
	addi	x16, x3, 0	# 717
	addi	x3, x3, 16	# 717
	lui		x17, %hi(rotate_quadratic_matrix.2632)	# 717
	ori		x17, %lo(rotate_quadratic_matrix.2632)	# 717
	sw		x17, 0(x16)	# 758
	sw		x7, 8(x16)	# 758
	sw		x12, 4(x16)	# 758
	addi	x17, x3, 0	# 758
	addi	x3, x3, 16	# 758
	lui		x18, %hi(read_nth_object.2635)	# 758
	ori		x18, %lo(read_nth_object.2635)	# 758
	sw		x18, 0(x17)	# 841
	sw		x16, 8(x17)	# 841
	lw		x16, 16(x2)	# 841
	sw		x16, 4(x17)	# 841
	addi	x18, x3, 0	# 841
	addi	x3, x3, 16	# 841
	lui		x19, %hi(read_object.2637)	# 841
	ori		x19, %lo(read_object.2637)	# 841
	sw		x19, 0(x18)	# 850
	sw		x17, 8(x18)	# 850
	lw		x17, 12(x2)	# 850
	sw		x17, 4(x18)	# 850
	addi	x19, x3, 0	# 850
	addi	x3, x3, 8	# 850
	lui		x20, %hi(read_all_object.2639)	# 850
	ori		x20, %lo(read_all_object.2639)	# 850
	sw		x20, 0(x19)	# 874
	sw		x18, 4(x19)	# 874
	addi	x18, x3, 0	# 874
	addi	x3, x3, 8	# 874
	lui		x20, %hi(read_and_network.2645)	# 874
	ori		x20, %lo(read_and_network.2645)	# 874
	sw		x20, 0(x18)	# 883
	lw		x20, 40(x2)	# 883
	sw		x20, 4(x18)	# 883
	addi	x21, x3, 0	# 883
	addi	x3, x3, 24	# 883
	lui		x22, %hi(read_parameter.2647)	# 883
	ori		x22, %lo(read_parameter.2647)	# 883
	sw		x22, 0(x21)	# 908
	sw		x5, 20(x21)	# 908
	sw		x13, 16(x21)	# 908
	sw		x18, 12(x21)	# 908
	sw		x19, 8(x21)	# 908
	lw		x5, 48(x2)	# 908
	sw		x5, 4(x21)	# 908
	addi	x13, x3, 0	# 908
	addi	x3, x3, 8	# 908
	lui		x18, %hi(solver_rect_surface.2649)	# 908
	ori		x18, %lo(solver_rect_surface.2649)	# 908
	sw		x18, 0(x13)	# 923
	lw		x18, 52(x2)	# 923
	sw		x18, 4(x13)	# 923
	addi	x19, x3, 0	# 923
	addi	x3, x3, 8	# 923
	lui		x22, %hi(solver_rect.2658)	# 923
	ori		x22, %lo(solver_rect.2658)	# 923
	sw		x22, 0(x19)	# 932
	sw		x13, 4(x19)	# 932
	addi	x13, x3, 0	# 932
	addi	x3, x3, 8	# 932
	lui		x22, %hi(solver_surface.2664)	# 932
	ori		x22, %lo(solver_surface.2664)	# 932
	sw		x22, 0(x13)	# 983
	sw		x18, 4(x13)	# 983
	addi	x22, x3, 0	# 983
	addi	x3, x3, 8	# 983
	lui		x23, %hi(solver_second.2683)	# 983
	ori		x23, %lo(solver_second.2683)	# 983
	sw		x23, 0(x22)	# 1012
	sw		x18, 4(x22)	# 1012
	addi	x23, x3, 0	# 1012
	addi	x3, x3, 24	# 1012
	lui		x24, %hi(solver.2689)	# 1012
	ori		x24, %lo(solver.2689)	# 1012
	sw		x24, 0(x23)	# 1044
	sw		x13, 16(x23)	# 1044
	sw		x22, 12(x23)	# 1044
	sw		x19, 8(x23)	# 1044
	sw		x16, 4(x23)	# 1044
	addi	x13, x3, 0	# 1044
	addi	x3, x3, 8	# 1044
	lui		x19, %hi(solver_rect_fast.2693)	# 1044
	ori		x19, %lo(solver_rect_fast.2693)	# 1044
	sw		x19, 0(x13)	# 1077
	sw		x18, 4(x13)	# 1077
	addi	x19, x3, 0	# 1077
	addi	x3, x3, 8	# 1077
	lui		x22, %hi(solver_surface_fast.2700)	# 1077
	ori		x22, %lo(solver_surface_fast.2700)	# 1077
	sw		x22, 0(x19)	# 1086
	sw		x18, 4(x19)	# 1086
	addi	x22, x3, 0	# 1086
	addi	x3, x3, 8	# 1086
	lui		x24, %hi(solver_second_fast.2706)	# 1086
	ori		x24, %lo(solver_second_fast.2706)	# 1086
	sw		x24, 0(x22)	# 1106
	sw		x18, 4(x22)	# 1106
	addi	x24, x3, 0	# 1106
	addi	x3, x3, 24	# 1106
	lui		x25, %hi(solver_fast.2712)	# 1106
	ori		x25, %lo(solver_fast.2712)	# 1106
	sw		x25, 0(x24)	# 1126
	sw		x19, 16(x24)	# 1126
	sw		x22, 12(x24)	# 1126
	sw		x13, 8(x24)	# 1126
	sw		x16, 4(x24)	# 1126
	addi	x19, x3, 0	# 1126
	addi	x3, x3, 8	# 1126
	lui		x22, %hi(solver_surface_fast2.2716)	# 1126
	ori		x22, %lo(solver_surface_fast2.2716)	# 1126
	sw		x22, 0(x19)	# 1134
	sw		x18, 4(x19)	# 1134
	addi	x22, x3, 0	# 1134
	addi	x3, x3, 8	# 1134
	lui		x25, %hi(solver_second_fast2.2723)	# 1134
	ori		x25, %lo(solver_second_fast2.2723)	# 1134
	sw		x25, 0(x22)	# 1153
	sw		x18, 4(x22)	# 1153
	addi	x25, x3, 0	# 1153
	addi	x3, x3, 24	# 1153
	lui		x26, %hi(solver_fast2.2730)	# 1153
	ori		x26, %lo(solver_fast2.2730)	# 1153
	sw		x26, 0(x25)	# 1250
	sw		x19, 16(x25)	# 1250
	sw		x22, 12(x25)	# 1250
	sw		x13, 8(x25)	# 1250
	sw		x16, 4(x25)	# 1250
	addi	x13, x3, 0	# 1250
	addi	x3, x3, 8	# 1250
	lui		x19, %hi(iter_setup_dirvec_constants.2742)	# 1250
	ori		x19, %lo(iter_setup_dirvec_constants.2742)	# 1250
	sw		x19, 0(x13)	# 1267
	sw		x16, 4(x13)	# 1267
	addi	x19, x3, 0	# 1267
	addi	x3, x3, 16	# 1267
	lui		x22, %hi(setup_dirvec_constants.2745)	# 1267
	ori		x22, %lo(setup_dirvec_constants.2745)	# 1267
	sw		x22, 0(x19)	# 1275
	sw		x17, 8(x19)	# 1275
	sw		x13, 4(x19)	# 1275
	addi	x13, x3, 0	# 1275
	addi	x3, x3, 8	# 1275
	lui		x22, %hi(setup_startp_constants.2747)	# 1275
	ori		x22, %lo(setup_startp_constants.2747)	# 1275
	sw		x22, 0(x13)	# 1294
	sw		x16, 4(x13)	# 1294
	addi	x22, x3, 0	# 1294
	addi	x3, x3, 16	# 1294
	lui		x26, %hi(setup_startp.2750)	# 1294
	ori		x26, %lo(setup_startp.2750)	# 1294
	sw		x26, 0(x22)	# 1344
	lw		x26, 104(x2)	# 1344
	sw		x26, 12(x22)	# 1344
	sw		x13, 8(x22)	# 1344
	sw		x17, 4(x22)	# 1344
	addi	x13, x3, 0	# 1344
	addi	x3, x3, 8	# 1344
	lui		x27, %hi(check_all_inside.2772)	# 1344
	ori		x27, %lo(check_all_inside.2772)	# 1344
	sw		x27, 0(x13)	# 1364
	sw		x16, 4(x13)	# 1364
	addi	x27, x3, 0	# 1364
	addi	x3, x3, 32	# 1364
	lui		x31, %hi(shadow_check_and_group.2778)	# 1364
	ori		x31, %lo(shadow_check_and_group.2778)	# 1364
	sw		x31, 0(x27)	# 1394
	sw		x24, 28(x27)	# 1394
	sw		x18, 24(x27)	# 1394
	sw		x16, 20(x27)	# 1394
	lw		x31, 140(x2)	# 1394
	sw		x31, 16(x27)	# 1394
	sw		x14, 12(x27)	# 1394
	sw		x21, 152(x2)	# 1394
	lw		x21, 64(x2)	# 1394
	sw		x21, 8(x27)	# 1394
	sw		x13, 4(x27)	# 1394
	sw		x19, 156(x2)	# 1394
	addi	x19, x3, 0	# 1394
	addi	x3, x3, 16	# 1394
	lui		x17, %hi(shadow_check_one_or_group.2781)	# 1394
	ori		x17, %lo(shadow_check_one_or_group.2781)	# 1394
	sw		x17, 0(x19)	# 1409
	sw		x27, 8(x19)	# 1409
	sw		x20, 4(x19)	# 1409
	addi	x17, x3, 0	# 1409
	addi	x3, x3, 24	# 1409
	lui		x27, %hi(shadow_check_one_or_matrix.2784)	# 1409
	ori		x27, %lo(shadow_check_one_or_matrix.2784)	# 1409
	sw		x27, 0(x17)	# 1445
	sw		x24, 20(x17)	# 1445
	sw		x18, 16(x17)	# 1445
	sw		x19, 12(x17)	# 1445
	sw		x31, 8(x17)	# 1445
	sw		x21, 4(x17)	# 1445
	addi	x19, x3, 0	# 1445
	addi	x3, x3, 40	# 1445
	lui		x24, %hi(solve_each_element.2787)	# 1445
	ori		x24, %lo(solve_each_element.2787)	# 1445
	sw		x24, 0(x19)	# 1486
	lw		x24, 60(x2)	# 1486
	sw		x24, 36(x19)	# 1486
	lw		x27, 100(x2)	# 1486
	sw		x27, 32(x19)	# 1486
	sw		x18, 28(x19)	# 1486
	sw		x23, 24(x19)	# 1486
	sw		x16, 20(x19)	# 1486
	lw		x31, 56(x2)	# 1486
	sw		x31, 16(x19)	# 1486
	sw		x21, 12(x19)	# 1486
	lw		x9, 68(x2)	# 1486
	sw		x9, 8(x19)	# 1486
	sw		x13, 4(x19)	# 1486
	addi	x8, x3, 0	# 1486
	addi	x3, x3, 16	# 1486
	lui		x11, %hi(solve_one_or_network.2791)	# 1486
	ori		x11, %lo(solve_one_or_network.2791)	# 1486
	sw		x11, 0(x8)	# 1496
	sw		x19, 8(x8)	# 1496
	sw		x20, 4(x8)	# 1496
	addi	x11, x3, 0	# 1496
	addi	x3, x3, 24	# 1496
	lui		x19, %hi(trace_or_matrix.2795)	# 1496
	ori		x19, %lo(trace_or_matrix.2795)	# 1496
	sw		x19, 0(x11)	# 1523
	sw		x24, 20(x11)	# 1523
	sw		x27, 16(x11)	# 1523
	sw		x18, 12(x11)	# 1523
	sw		x23, 8(x11)	# 1523
	sw		x8, 4(x11)	# 1523
	addi	x8, x3, 0	# 1523
	addi	x3, x3, 16	# 1523
	lui		x19, %hi(judge_intersection.2799)	# 1523
	ori		x19, %lo(judge_intersection.2799)	# 1523
	sw		x19, 0(x8)	# 1538
	sw		x11, 12(x8)	# 1538
	sw		x24, 8(x8)	# 1538
	sw		x5, 4(x8)	# 1538
	addi	x11, x3, 0	# 1538
	addi	x3, x3, 40	# 1538
	lui		x19, %hi(solve_each_element_fast.2801)	# 1538
	ori		x19, %lo(solve_each_element_fast.2801)	# 1538
	sw		x19, 0(x11)	# 1579
	sw		x24, 36(x11)	# 1579
	sw		x26, 32(x11)	# 1579
	sw		x25, 28(x11)	# 1579
	sw		x18, 24(x11)	# 1579
	sw		x16, 20(x11)	# 1579
	sw		x31, 16(x11)	# 1579
	sw		x21, 12(x11)	# 1579
	sw		x9, 8(x11)	# 1579
	sw		x13, 4(x11)	# 1579
	addi	x13, x3, 0	# 1579
	addi	x3, x3, 16	# 1579
	lui		x19, %hi(solve_one_or_network_fast.2805)	# 1579
	ori		x19, %lo(solve_one_or_network_fast.2805)	# 1579
	sw		x19, 0(x13)	# 1589
	sw		x11, 8(x13)	# 1589
	sw		x20, 4(x13)	# 1589
	addi	x11, x3, 0	# 1589
	addi	x3, x3, 24	# 1589
	lui		x19, %hi(trace_or_matrix_fast.2809)	# 1589
	ori		x19, %lo(trace_or_matrix_fast.2809)	# 1589
	sw		x19, 0(x11)	# 1613
	sw		x24, 16(x11)	# 1613
	sw		x25, 12(x11)	# 1613
	sw		x18, 8(x11)	# 1613
	sw		x13, 4(x11)	# 1613
	addi	x13, x3, 0	# 1613
	addi	x3, x3, 16	# 1613
	lui		x18, %hi(judge_intersection_fast.2813)	# 1613
	ori		x18, %lo(judge_intersection_fast.2813)	# 1613
	sw		x18, 0(x13)	# 1634
	sw		x11, 12(x13)	# 1634
	sw		x24, 8(x13)	# 1634
	sw		x5, 4(x13)	# 1634
	addi	x11, x3, 0	# 1634
	addi	x3, x3, 16	# 1634
	lui		x18, %hi(get_nvector_rect.2815)	# 1634
	ori		x18, %lo(get_nvector_rect.2815)	# 1634
	sw		x18, 0(x11)	# 1642
	lw		x18, 72(x2)	# 1642
	sw		x18, 8(x11)	# 1642
	sw		x31, 4(x11)	# 1642
	addi	x19, x3, 0	# 1642
	addi	x3, x3, 8	# 1642
	lui		x20, %hi(get_nvector_plane.2817)	# 1642
	ori		x20, %lo(get_nvector_plane.2817)	# 1642
	sw		x20, 0(x19)	# 1650
	sw		x18, 4(x19)	# 1650
	addi	x20, x3, 0	# 1650
	addi	x3, x3, 16	# 1650
	lui		x23, %hi(get_nvector_second.2819)	# 1650
	ori		x23, %lo(get_nvector_second.2819)	# 1650
	sw		x23, 0(x20)	# 1672
	sw		x18, 8(x20)	# 1672
	sw		x21, 4(x20)	# 1672
	addi	x23, x3, 0	# 1672
	addi	x3, x3, 16	# 1672
	lui		x25, %hi(get_nvector.2821)	# 1672
	ori		x25, %lo(get_nvector.2821)	# 1672
	sw		x25, 0(x23)	# 1688
	sw		x20, 12(x23)	# 1688
	sw		x11, 8(x23)	# 1688
	sw		x19, 4(x23)	# 1688
	addi	x11, x3, 0	# 1688
	addi	x3, x3, 24	# 1688
	lui		x19, %hi(utexture.2824)	# 1688
	ori		x19, %lo(utexture.2824)	# 1688
	sw		x19, 0(x11)	# 1766
	lw		x19, 76(x2)	# 1766
	sw		x19, 16(x11)	# 1766
	sw		x7, 12(x11)	# 1766
	sw		x12, 8(x11)	# 1766
	lw		x20, 0(x2)	# 1766
	sw		x20, 4(x11)	# 1766
	addi	x25, x3, 0	# 1766
	addi	x3, x3, 16	# 1766
	lui		x26, %hi(add_light.2827)	# 1766
	ori		x26, %lo(add_light.2827)	# 1766
	sw		x26, 0(x25)	# 1783
	sw		x19, 8(x25)	# 1783
	lw		x26, 84(x2)	# 1783
	sw		x26, 4(x25)	# 1783
	addi	x20, x3, 0	# 1783
	addi	x3, x3, 40	# 1783
	lui		x12, %hi(trace_reflections.2831)	# 1783
	ori		x12, %lo(trace_reflections.2831)	# 1783
	sw		x12, 0(x20)	# 1812
	sw		x17, 32(x20)	# 1812
	lw		x12, 148(x2)	# 1812
	sw		x12, 28(x20)	# 1812
	sw		x5, 24(x20)	# 1812
	sw		x18, 20(x20)	# 1812
	sw		x13, 16(x20)	# 1812
	sw		x31, 12(x20)	# 1812
	sw		x9, 8(x20)	# 1812
	sw		x25, 4(x20)	# 1812
	addi	x12, x3, 0	# 1812
	addi	x3, x3, 88	# 1812
	lui		x7, %hi(trace_ray.2836)	# 1812
	ori		x7, %lo(trace_ray.2836)	# 1812
	sw		x7, 0(x12)	# 1905
	sw		x11, 80(x12)	# 1905
	sw		x20, 76(x12)	# 1905
	sw		x24, 72(x12)	# 1905
	sw		x19, 68(x12)	# 1905
	sw		x27, 64(x12)	# 1905
	sw		x17, 60(x12)	# 1905
	sw		x22, 56(x12)	# 1905
	sw		x26, 52(x12)	# 1905
	sw		x5, 48(x12)	# 1905
	sw		x16, 44(x12)	# 1905
	sw		x18, 40(x12)	# 1905
	sw		x4, 36(x12)	# 1905
	sw		x14, 32(x12)	# 1905
	sw		x8, 28(x12)	# 1905
	sw		x31, 24(x12)	# 1905
	sw		x21, 20(x12)	# 1905
	sw		x9, 16(x12)	# 1905
	sw		x23, 12(x12)	# 1905
	sw		x15, 8(x12)	# 1905
	sw		x25, 4(x12)	# 1905
	addi	x7, x3, 0	# 1905
	addi	x3, x3, 56	# 1905
	lui		x8, %hi(trace_diffuse_ray.2842)	# 1905
	ori		x8, %lo(trace_diffuse_ray.2842)	# 1905
	sw		x8, 0(x7)	# 1924
	sw		x11, 48(x7)	# 1924
	sw		x19, 44(x7)	# 1924
	sw		x17, 40(x7)	# 1924
	sw		x5, 36(x7)	# 1924
	sw		x16, 32(x7)	# 1924
	sw		x18, 28(x7)	# 1924
	sw		x14, 24(x7)	# 1924
	sw		x13, 20(x7)	# 1924
	sw		x21, 16(x7)	# 1924
	sw		x9, 12(x7)	# 1924
	sw		x23, 8(x7)	# 1924
	lw		x5, 80(x2)	# 1924
	sw		x5, 4(x7)	# 1924
	addi	x8, x3, 0	# 1924
	addi	x3, x3, 8	# 1924
	lui		x9, %hi(iter_trace_diffuse_rays.2845)	# 1924
	ori		x9, %lo(iter_trace_diffuse_rays.2845)	# 1924
	sw		x9, 0(x8)	# 1940
	sw		x7, 4(x8)	# 1940
	addi	x7, x3, 0	# 1940
	addi	x3, x3, 16	# 1940
	lui		x9, %hi(trace_diffuse_rays.2850)	# 1940
	ori		x9, %lo(trace_diffuse_rays.2850)	# 1940
	sw		x9, 0(x7)	# 1950
	sw		x22, 8(x7)	# 1950
	sw		x8, 4(x7)	# 1950
	addi	x8, x3, 0	# 1950
	addi	x3, x3, 16	# 1950
	lui		x9, %hi(trace_diffuse_ray_80percent.2854)	# 1950
	ori		x9, %lo(trace_diffuse_ray_80percent.2854)	# 1950
	sw		x9, 0(x8)	# 1976
	sw		x7, 8(x8)	# 1976
	lw		x9, 128(x2)	# 1976
	sw		x9, 4(x8)	# 1976
	addi	x11, x3, 0	# 1976
	addi	x3, x3, 16	# 1976
	lui		x13, %hi(calc_diffuse_using_1point.2858)	# 1976
	ori		x13, %lo(calc_diffuse_using_1point.2858)	# 1976
	sw		x13, 0(x11)	# 1995
	sw		x8, 12(x11)	# 1995
	sw		x26, 8(x11)	# 1995
	sw		x5, 4(x11)	# 1995
	addi	x8, x3, 0	# 1995
	addi	x3, x3, 16	# 1995
	lui		x13, %hi(calc_diffuse_using_5points.2861)	# 1995
	ori		x13, %lo(calc_diffuse_using_5points.2861)	# 1995
	sw		x13, 0(x8)	# 2015
	sw		x26, 8(x8)	# 2015
	sw		x5, 4(x8)	# 2015
	addi	x13, x3, 0	# 2015
	addi	x3, x3, 8	# 2015
	lui		x15, %hi(do_without_neighbors.2867)	# 2015
	ori		x15, %lo(do_without_neighbors.2867)	# 2015
	sw		x15, 0(x13)	# 2030
	sw		x11, 4(x13)	# 2030
	addi	x11, x3, 0	# 2030
	addi	x3, x3, 8	# 2030
	lui		x15, %hi(neighbors_exist.2870)	# 2030
	ori		x15, %lo(neighbors_exist.2870)	# 2030
	sw		x15, 0(x11)	# 2067
	lw		x15, 88(x2)	# 2067
	sw		x15, 4(x11)	# 2067
	addi	x17, x3, 0	# 2067
	addi	x3, x3, 16	# 2067
	lui		x18, %hi(try_exploit_neighbors.2883)	# 2067
	ori		x18, %lo(try_exploit_neighbors.2883)	# 2067
	sw		x18, 0(x17)	# 2094
	sw		x13, 8(x17)	# 2094
	sw		x8, 4(x17)	# 2094
	addi	x8, x3, 0	# 2094
	addi	x3, x3, 8	# 2094
	lui		x18, %hi(write_ppm_header.2890)	# 2094
	ori		x18, %lo(write_ppm_header.2890)	# 2094
	sw		x18, 0(x8)	# 2120
	sw		x15, 4(x8)	# 2120
	addi	x18, x3, 0	# 2120
	addi	x3, x3, 8	# 2120
	lui		x19, %hi(write_rgb.2896)	# 2120
	ori		x19, %lo(write_rgb.2896)	# 2120
	sw		x19, 0(x18)	# 2143
	sw		x26, 4(x18)	# 2143
	addi	x19, x3, 0	# 2143
	addi	x3, x3, 16	# 2143
	lui		x20, %hi(pretrace_diffuse_rays.2898)	# 2143
	ori		x20, %lo(pretrace_diffuse_rays.2898)	# 2143
	sw		x20, 0(x19)	# 2173
	sw		x7, 12(x19)	# 2173
	sw		x9, 8(x19)	# 2173
	sw		x5, 4(x19)	# 2173
	addi	x5, x3, 0	# 2173
	addi	x3, x3, 40	# 2173
	lui		x7, %hi(pretrace_pixels.2901)	# 2173
	ori		x7, %lo(pretrace_pixels.2901)	# 2173
	sw		x7, 0(x5)	# 2198
	sw		x6, 36(x5)	# 2198
	sw		x12, 32(x5)	# 2198
	sw		x27, 28(x5)	# 2198
	lw		x6, 108(x2)	# 2198
	sw		x6, 24(x5)	# 2198
	lw		x6, 96(x2)	# 2198
	sw		x6, 20(x5)	# 2198
	sw		x26, 16(x5)	# 2198
	lw		x7, 120(x2)	# 2198
	sw		x7, 12(x5)	# 2198
	sw		x19, 8(x5)	# 2198
	lw		x7, 92(x2)	# 2198
	sw		x7, 4(x5)	# 2198
	addi	x12, x3, 0	# 2198
	addi	x3, x3, 32	# 2198
	lui		x19, %hi(pretrace_line.2908)	# 2198
	ori		x19, %lo(pretrace_line.2908)	# 2198
	sw		x19, 0(x12)	# 2214
	lw		x19, 116(x2)	# 2214
	sw		x19, 24(x12)	# 2214
	lw		x19, 112(x2)	# 2214
	sw		x19, 20(x12)	# 2214
	sw		x6, 16(x12)	# 2214
	sw		x5, 12(x12)	# 2214
	sw		x15, 8(x12)	# 2214
	sw		x7, 4(x12)	# 2214
	addi	x5, x3, 0	# 2214
	addi	x3, x3, 32	# 2214
	lui		x19, %hi(scan_pixel.2912)	# 2214
	ori		x19, %lo(scan_pixel.2912)	# 2214
	sw		x19, 0(x5)	# 2234
	sw		x18, 24(x5)	# 2234
	sw		x17, 20(x5)	# 2234
	sw		x26, 16(x5)	# 2234
	sw		x11, 12(x5)	# 2234
	sw		x15, 8(x5)	# 2234
	sw		x13, 4(x5)	# 2234
	addi	x11, x3, 0	# 2234
	addi	x3, x3, 16	# 2234
	lui		x13, %hi(scan_line.2919)	# 2234
	ori		x13, %lo(scan_line.2919)	# 2234
	sw		x13, 0(x11)	# 2286
	sw		x5, 12(x11)	# 2286
	sw		x12, 8(x11)	# 2286
	sw		x15, 4(x11)	# 2286
	addi	x5, x3, 0	# 2286
	addi	x3, x3, 8	# 2286
	lui		x13, %hi(create_pixelline.2933)	# 2286
	ori		x13, %lo(create_pixelline.2933)	# 2286
	sw		x13, 0(x5)	# 2300
	sw		x15, 4(x5)	# 2300
	addi	x13, x3, 0	# 2300
	addi	x3, x3, 16	# 2300
	lui		x17, %hi(tan.2935)	# 2300
	ori		x17, %lo(tan.2935)	# 2300
	sw		x17, 0(x13)	# 2305
	lw		x17, 8(x2)	# 2305
	sw		x17, 8(x13)	# 2305
	lw		x17, 4(x2)	# 2305
	sw		x17, 4(x13)	# 2305
	addi	x17, x3, 0	# 2305
	addi	x3, x3, 16	# 2305
	lui		x18, %hi(adjust_position.2937)	# 2305
	ori		x18, %lo(adjust_position.2937)	# 2305
	sw		x18, 0(x17)	# 2314
	sw		x13, 8(x17)	# 2314
	lw		x13, 0(x2)	# 2314
	sw		x13, 4(x17)	# 2314
	addi	x13, x3, 0	# 2314
	addi	x3, x3, 16	# 2314
	lui		x18, %hi(calc_dirvec.2940)	# 2314
	ori		x18, %lo(calc_dirvec.2940)	# 2314
	sw		x18, 0(x13)	# 2335
	sw		x9, 8(x13)	# 2335
	sw		x17, 4(x13)	# 2335
	addi	x17, x3, 0	# 2335
	addi	x3, x3, 8	# 2335
	lui		x18, %hi(calc_dirvecs.2948)	# 2335
	ori		x18, %lo(calc_dirvecs.2948)	# 2335
	sw		x18, 0(x17)	# 2349
	sw		x13, 4(x17)	# 2349
	addi	x13, x3, 0	# 2349
	addi	x3, x3, 8	# 2349
	lui		x18, %hi(calc_dirvec_rows.2953)	# 2349
	ori		x18, %lo(calc_dirvec_rows.2953)	# 2349
	sw		x18, 0(x13)	# 2362
	sw		x17, 4(x13)	# 2362
	addi	x17, x3, 0	# 2362
	addi	x3, x3, 8	# 2362
	lui		x18, %hi(create_dirvec.2957)	# 2362
	ori		x18, %lo(create_dirvec.2957)	# 2362
	sw		x18, 0(x17)	# 2368
	lw		x18, 12(x2)	# 2368
	sw		x18, 4(x17)	# 2368
	addi	x19, x3, 0	# 2368
	addi	x3, x3, 8	# 2368
	lui		x20, %hi(create_dirvec_elements.2959)	# 2368
	ori		x20, %lo(create_dirvec_elements.2959)	# 2368
	sw		x20, 0(x19)	# 2375
	sw		x17, 4(x19)	# 2375
	addi	x20, x3, 0	# 2375
	addi	x3, x3, 16	# 2375
	lui		x21, %hi(create_dirvecs.2962)	# 2375
	ori		x21, %lo(create_dirvecs.2962)	# 2375
	sw		x21, 0(x20)	# 2387
	sw		x9, 12(x20)	# 2387
	sw		x19, 8(x20)	# 2387
	sw		x17, 4(x20)	# 2387
	addi	x19, x3, 0	# 2387
	addi	x3, x3, 8	# 2387
	lui		x21, %hi(init_dirvec_constants.2964)	# 2387
	ori		x21, %lo(init_dirvec_constants.2964)	# 2387
	sw		x21, 0(x19)	# 2394
	lw		x21, 156(x2)	# 2394
	sw		x21, 4(x19)	# 2394
	addi	x22, x3, 0	# 2394
	addi	x3, x3, 16	# 2394
	lui		x23, %hi(init_vecset_constants.2967)	# 2394
	ori		x23, %lo(init_vecset_constants.2967)	# 2394
	sw		x23, 0(x22)	# 2401
	sw		x19, 8(x22)	# 2401
	sw		x9, 4(x22)	# 2401
	addi	x9, x3, 0	# 2401
	addi	x3, x3, 16	# 2401
	lui		x19, %hi(init_dirvecs.2969)	# 2401
	ori		x19, %lo(init_dirvecs.2969)	# 2401
	sw		x19, 0(x9)	# 2412
	sw		x22, 12(x9)	# 2412
	sw		x20, 8(x9)	# 2412
	sw		x13, 4(x9)	# 2412
	addi	x13, x3, 0	# 2412
	addi	x3, x3, 16	# 2412
	lui		x19, %hi(add_reflection.2971)	# 2412
	ori		x19, %lo(add_reflection.2971)	# 2412
	sw		x19, 0(x13)	# 2421
	sw		x21, 12(x13)	# 2421
	lw		x19, 148(x2)	# 2421
	sw		x19, 8(x13)	# 2421
	sw		x17, 4(x13)	# 2421
	addi	x17, x3, 0	# 2421
	addi	x3, x3, 16	# 2421
	lui		x19, %hi(setup_rect_reflection.2978)	# 2421
	ori		x19, %lo(setup_rect_reflection.2978)	# 2421
	sw		x19, 0(x17)	# 2435
	sw		x4, 12(x17)	# 2435
	sw		x14, 8(x17)	# 2435
	sw		x13, 4(x17)	# 2435
	addi	x19, x3, 0	# 2435
	addi	x3, x3, 16	# 2435
	lui		x20, %hi(setup_surface_reflection.2981)	# 2435
	ori		x20, %lo(setup_surface_reflection.2981)	# 2435
	sw		x20, 0(x19)	# 2450
	sw		x4, 12(x19)	# 2450
	sw		x14, 8(x19)	# 2450
	sw		x13, 4(x19)	# 2450
	addi	x4, x3, 0	# 2450
	addi	x3, x3, 16	# 2450
	lui		x13, %hi(setup_reflections.2984)	# 2450
	ori		x13, %lo(setup_reflections.2984)	# 2450
	sw		x13, 0(x4)	# 2472
	sw		x19, 12(x4)	# 2472
	sw		x17, 8(x4)	# 2472
	sw		x16, 4(x4)	# 2472
	addi	x27, x3, 0	# 2472
	addi	x3, x3, 64	# 2472
	lui		x13, %hi(rt.2986)	# 2472
	ori		x13, %lo(rt.2986)	# 2472
	sw		x13, 0(x27)	# 2493
	sw		x8, 56(x27)	# 2493
	sw		x4, 52(x27)	# 2493
	sw		x21, 48(x27)	# 2493
	sw		x6, 44(x27)	# 2493
	sw		x11, 40(x27)	# 2493
	lw		x4, 152(x2)	# 2493
	sw		x4, 36(x27)	# 2493
	sw		x12, 32(x27)	# 2493
	sw		x18, 28(x27)	# 2493
	lw		x4, 140(x2)	# 2493
	sw		x4, 24(x27)	# 2493
	sw		x14, 20(x27)	# 2493
	sw		x9, 16(x27)	# 2493
	sw		x15, 12(x27)	# 2493
	sw		x7, 8(x27)	# 2493
	sw		x5, 4(x27)	# 2493
	lui		x4, 512	# 2493
	ori		x4, x0, 512	# 2493
	lui		x5, 512	# 2493
	ori		x5, x0, 512	# 2493
	lui		x6, 3	# 2493
	ori		x6, x0, 3	# 2493
	sw		x1, 164(x2)
	addi	x2, x2, 168
	lw		x31, 0(x27)
	jalr	x0, x31, 0
	addi	x2, x2, -168
	lw		x1, 164(x2)
	addi	x2, x2, 112
	EXIT	

