.data
mat00: .word 1
mat01: .word 2
mat02: .word 3
mat10: .word 4
mat11: .word 50
mat12: .word 6
mat20: .word 7
mat21: .word 8
mat22: .word 91

loop: .asciiz "loop\n"

.text
diag_sum:
	addi $t0, $zero, 0
	addi $v0, $zero, 0

__diag_sum_loop:
	addi $t1, $zero, 0
__diag_sum_inner_loop:
	slt $t3, $t0, $t1
	bne $t3, $zero, __diag_sum_inner_skip
	slt $t2, $t1, $t0
	beq $t2, $zero, __diag_sum_eqij
__diag_sum_inner_skip:
	addi $t1, $t1, 1
	slt $t3, $t1, $a1
	bne $t3, $zero, __diag_sum_inner_loop

__diag_sum_eqij:
	mult $t0, $a1
	mfhi $t2
	mflo $t2
	add $t2, $t2, $t1 		# c = (row * theta) + col
	sll $t2, $t2, 2 		# 4c
	add $t3, $a0, $t2		# a0 + 4c = t3
	lw $t3, ($t3)
	add $v0, $v0, $t3

	addi $t0, $t0, 1
	slt $t3, $t0, $a1
	bne $t3, $zero, __diag_sum_loop

	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	la $a0, mat00
	addi $a1, $zero, 3
	jal diag_sum

	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall

	lw $ra, ($sp)
	addi $sp, $sp, 4

	jr $ra
