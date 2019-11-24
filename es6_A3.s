.data
A00: .word 1
A01: .word 0
A02: .word 1
A10: .word 1

B00: .word 0xFFFFFFFF
B01: .word 0xFFFFffff
B10: .word 0xFFFFffff
B11: .word 0xFFFFffff


.text
transpose:
	addi $t0, $zero, 0
	add $t2, $zero, $a0		# t2 = A
	add $t3, $zero, $a1		# t3 = B
							# a2 = m
							# a3 = n
__transpose_loop:
	addi $t1, $zero, 0
__transpose_inner_loop:
	mult $t0, $a3
	mfhi $t4
	mflo $t4
	add $t4, $t4, $t1
	sll $t4, $t4, 2
	add $a0, $t4, $t2 # <--- a0

	mult $t1, $a2
	mfhi $t4
	mflo $t4
	add $t4, $t4, $t0
	sll $t4, $t4, 2
	add $a1, $t4, $t3 # <--- a1

	lw $t4, ($a0)
	sw $t4, ($a1)

	addi $t1, $t1, 1
	slt $t4, $t1, $a3
	bne $t4, $zero, __transpose_inner_loop
#__transpose_inner_loop
	addi $t0, $t0, 1
	slt $t4, $t0, $a2
	bne $t4, $zero, __transpose_loop
#__transpose_loop

	jr $ra

# a0	: a
# a1 	: b
# a2 	: Am
# a3 	: An
# $sp 	: Bm
# $sp+4 : Bn
mateq:
	addi $t0, $zero, 0
	addi $v0, $zero, 0
	add $t2, $zero, $a0
	add $t3, $zero, $a1
	lw $t4, ($sp)
	lw $t5, 4($sp)

	slt $t6, $t4, $a2
	bne $t6, $zero, __mateq_exit
	slt $t6, $a2, $t4
	bne $t6, $zero, __mateq_exit
	
	slt $t6, $t5, $a3
	bne $t6, $zero, __mateq_exit
	slt $t6, $a3, $t5
	bne $t6, $zero, __mateq_exit

__mateq_loop:
	addi $t1, $zero, 0
__mateq_inner_loop:
	mult $t0, $a3
	mfhi $t6
	mflo $t6
	add $t6, $t6, $t1
	sll $t6, $t6, 2

	add $a0, $t6, $t2
	add $a1, $t6, $t3
	lw $t6, ($a0)
	lw $t7, ($a1)

	slt $t5, $t6, $t7
	bne $t5, $zero, __mateq_exit
	slt $t5, $t7, $t6
	bne $t5, $zero, __mateq_exit

	addi $t1, $t1, 1
	slt $t5, $t1, $a3
	bne $t5, $zero, __mateq_inner_loop
#__mateq_inner_loop
	addi $t0, $t0, 1
	slt $t5, $t0, $a2
	bne $t5, $zero, __mateq_loop
#__mateq_loop
	addi $v0, $zero, 1 #ok
__mateq_exit:
	jr $ra

matcpy:
	addi $t0, $zero, 0
	add $t2, $zero, $a0
	add $t3, $zero, $a1

__matcpy_loop:
	addi $t1, $zero, 0
__matcpy_inner_loop:
	mult $t0, $a3
	mfhi $t4
	mflo $t4
	add $t4, $t4, $t1
	sll $t4, $t4, 2

	add $a0, $t4, $t2
	add $a1, $t4, $t3
	lw $t5, ($a0)
	sw $t5, ($a1)

	addi $t1, $t1, 1
	slt $t5, $t1, $a3
	bne $t5, $zero, __matcpy_inner_loop

	addi $t0, $t0, 1
	slt $t5, $t0, $a2
	bne $t5, $zero, __matcpy_loop

	jr $ra

symmetric:
	addi $sp, $sp, -12 		# (1)stackalloc
	sw $s0, ($sp)
	sw $ra, 4($sp)
	sw $s1, 8($sp)
	
	add $s1, $zero, $a1

	mult $a2, $a3
	mfhi $s0
	mflo $s0
	sll $s0, $s0, 2

	addi $sp, $sp, -8		# (2)stackalloc
	sw $a0, ($sp)
	sw $a1, 4($sp)

	sub $sp, $sp, $s0		# (3)stackalloc
	add $a1, $zero, $sp
	jal transpose

	add $a1, $zero, $sp
	add $t0, $s0, $sp
	lw $a0, ($t0)
	
	addi $sp, $sp, -8		# (4)stackalloc
	sw $a2, ($sp)
	sw $a3, 4($sp)
	jal mateq

	slti $t0, $v0, 1
	beq $t0, $zero, __symmetric_finish #v0 = 0

	add $t1, $zero, $sp
	addi $a0, $t1, 8
	add $a1, $zero, $s1
	jal matcpy

__symmetric_finish:
	addi $sp, $sp, 16
	add $sp, $sp, $s0

	lw $s1, 8($sp)
	lw $ra, 4($sp)
	lw $s0, ($sp)
	addi $sp, $sp, 12

	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	la $a0, A00
	la $a1, B00
	addi $a2, $zero, 2
	addi $a3, $zero, 2
	jal symmetric
	
	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall

	lw $ra, ($sp)
	addi $sp, $sp, 4

	jr $ra
