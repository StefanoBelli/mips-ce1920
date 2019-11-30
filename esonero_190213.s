.text
T:
	addi $v0, $0, 1
	slti $t0, $a0, 3
	bne $t0, $0, __T_finish # a0 < 3

	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $a0, 12($sp)
	sw $s0, 16($sp)

	add $v0, $0, $0
	add $t0, $0, $0

__T_loop:
	sw $t0, 4($sp)
	sw $v0, 8($sp)
	add $a0, $0, $t0
	jal T
	lw $t0, 4($sp)
	lw $s0, 8($sp)
	mult $v0, $t0
	mflo $v0
	add $v0, $v0, $s0
	
	lw $a0, 12($sp)

	addi $t0, $t0, 1
	slt $t1, $t0, $a0
	bne $t1, $0, __T_loop

	lw $ra, 0($sp)
	lw $s0, 16($sp)
	addi $sp, $sp, 20

__T_finish:
	jr $ra


main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	addi $a0, $0, 10
	jal T

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra 
