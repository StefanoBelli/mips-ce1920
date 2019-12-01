.text
max:
	add $v0, $0, $a0
	slt $t0, $a0, $a1
	beq $t0, $0, __max_end
	add $v0, $0, $a1
__max_end:
	jr $ra

T:
	addi $v0, $0, 1
	slti $t0, $a0, 0
	bne $t0, $0, __T_end
	slt $t0, $0, $a0
	beq $t0, $0, __T_end

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	add $s0, $0, $a0
	addi $a0, $a0, -1
	jal T
	add $s1, $0, $v0

	add $a0, $0, $s0
	addi $a0, $a0, -2
	jal T

	add $a0, $0, $v0
	addi $a1, $0, 5
	jal max

	add $v0, $v0, $s1

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
__T_end:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	addi $a0, $0, 15
	jal T

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra

