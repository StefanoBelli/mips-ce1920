.text
min:
	add $v0, $a0, $0
	slt $t0, $a0, $a1
	bne $t0, $0, __min_next # a0 < a1
	add $v0, $a1, $0
__min_next:
	slt $t0, $v0, $a2
	bne $t0, $0, __min_finish # v0 < a2
	add $v0, $0, $a2
__min_finish:
	jr $ra

f:
	addi $v0, $0, 3
	slti $t0, $a0, 2
	bne $t0, $0, __f_finish

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	add $s0, $0, $a0
	
	srl $a0, $a0, 1
	jal g
	sll $v0, $v0, 2
	add $s1, $0, $v0

	add $a0, $0, $s0
	addi $a0, $a0, -1
	jal f

	addi $t0, $0, 3
	mult $v0, $t0
	mflo $v0

	sub $v0, $s1, $v0 # 4g(i / 2) - 3f(i - 1)
	add $v0, $v0, $s0 # 4g(i / 2) - 3f(i - 1) + i
	addi $v0, $v0, 5  # 4g(i / 2) - 3f(i - 1) + i + 5

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
__f_finish:
	jr $ra

g:
	addi $v0, $0, 5
	slti $t0, $a0, 3
	bne $t0, $0, __g_finish
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	add $s0, $0, $a0
	
	addi $a0, $a0, -2
	jal f

	add $s1, $0, $v0

	add $a0, $0, $s0
	srl $a0, $a0, 2
	jal g

	add $a2, $0, $s0
	addi $a2, $a2, -1
	add $a1, $0, $v0
	add $a0, $0, $s1
	jal min

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
__g_finish:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	addi $a0, $0, 10
	jal f

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
