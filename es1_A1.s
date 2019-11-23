.data
X: .word 15
Y: .word 5

.text
.globl main

min:
	slt $t0, $a0, $a1
	bne $t0, $zero, __min_a0
	add $v0, $zero, $a1
	jr $ra
__min_a0:
	add $v0, $zero, $a0
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	la $a0, X
	la $a1, Y
	lw $a0, ($a0)
	lw $a1, ($a1)
	jal min

	addi $a0, $a0, 1
	sub $a0, $a0, $v0
	addi $v0, $zero, 1
	syscall

	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra