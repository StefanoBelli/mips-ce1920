.text

fib:
	addi $sp, $sp, -12

	move $v0, $a0
	blt $a0, 2, __fib_end

	sw $ra, ($sp)
	sw $a0, 4($sp)

	addi $a0, $a0, -1
	jal fib

	sw $v0, 8($sp)

	lw $a0, 4($sp)

	addi $a0, $a0, -2
	jal fib

	lw $t0, 8($sp)
	add $v0, $v0, $t0

	lw $ra, ($sp)

__fib_end:
	addi $sp, $sp, 12
	jr $ra
	
main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	li $a0, 7
	jal fib

	move $a0, $v0
	li $v0, 1
	syscall

	lw $ra, ($sp)
	addi $sp, $sp, 4

	jr $ra
