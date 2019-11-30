.text
max3:
	slt $t0, $a1, $a0
	beq $t0, $0, __max_first
	add $v0, $0, $a0
	j __max_next

__max_first:
	add $v0, $0, $a1

__max_next:
	slt $t0, $v0, $a2
	beq $t0, $0, __max_end
	add $v0, $0, $a2

__max_end:
	jr $ra

f:
	addi $v0, $0, 2
	slti $t0, $a0, 2
	bne $t0, $0, __f_end

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	srl $a0, $a0, 2
	jal g

	sw $v0, 8($sp)
	lw $a0, 4($sp)

	addi $a0, $a0, -1
	jal f

	lw $a0, 8($sp)
	lw $a1, 4($sp)
	add $a2, $0, $v0
	jal max3

	lw $ra, 0($sp)
	addi $sp, $sp, 12
__f_end:
	jr $ra

g:
	addi $v0, $0, 3
	slti $t0, $a0, 3
	bne $t0, $0, __g_end

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	addi $a0, $a0, -1
	jal g

	addi $t0, $0, 5
	mult $t0, $v0
	mflo $t0

	sw $t0, 8($sp)
	lw $a0, 4($sp)

	addi $a0, $a0, -2
	jal f

	sll $v0, $v0, 1
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	
	add $v0, $v0, $t0
	add $v0, $v0, $t1
	addi $v0, $v0, 2

	lw $ra, 0($sp)
	addi $sp, $sp, 12
__g_end:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	addi $a0, $0, 4
	jal g

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
