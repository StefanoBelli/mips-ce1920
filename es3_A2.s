.text
.globl main

fib:
	add $v0, $zero, $a0
	slti $t0, $a0, 2
	bne $t0, $zero, __fib_end

	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)

	addi $a0, $a0, -1
	jal fib

	sw $v0, 8($sp)

	lw $a0, 4($sp)
	addi $a0, $a0, -2
	jal fib

	lw $t1, 8($sp)

	add $v0, $v0, $t1

	lw $ra, ($sp)
	addi $sp, $sp, 12
__fib_end:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	addi $a0, $zero, 23
	jal fib

	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall

	lw $ra, ($sp)
	addi $sp, $sp, 4

	jr $ra

