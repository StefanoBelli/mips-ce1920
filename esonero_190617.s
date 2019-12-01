.text
T:
	addi $v0, $0, 1
	slti $t0, $a0, 3
	bne $t0, $0, __T_finish
	slti $t0, $a1, 3
	bne $t0, $0, __T_finish

	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)

	addi $a0, $a0, -1
	addi $a1, $a1, -2
	jal T

	sw $v0, 12($sp)

	lw $a0, 4($sp)
	lw $a1, 8($sp)

	srl $a0, $a0, 1
	addi $a1, $a1, -2
	jal T

	lw $t0, 12($sp)

	lw $a0, 4($sp)
	lw $a1, 8($sp)
	add $v0, $v0, $t0
	sll $a0, $a0, 1
	add $v0, $v0, $a0
	add $v0, $v0, $a1

	lw $ra, 0($sp)
	addi $sp, $sp, 16
__T_finish:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	addi $a0, $0, 40
	addi $a1, $0, 41
	jal T

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra