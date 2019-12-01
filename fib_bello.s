.text
fib:
	add $v0, $0, $a0
	slti $t0, $a0, 2
	bne $t0, $0, __fib_exit

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	add $s0, $0, $a0
	addi $a0, $a0, -1
	jal fib

	add $s1, $0, $v0
	add $a0, $0, $s0
	addi $a0, $a0, -2
	jal fib

	add $v0, $v0, $s1

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
__fib_exit:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	addi $a0, $0, 20
	jal fib

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra