.data
BASE: .word 2
BASE1: .word 3
LEN: .word 2

.text
.globl main

sorted:
	lw $a1, ($a1)
	addi $t2, $zero, 0
	addi $v0, $zero, 0
__sorted_loop:
	lw $t0, ($a0)
	slt $t1, $a1, $t0 # a1 < t0
	bne $t1, $zero, __sorted_exit # t0 >= a1
	addi $t2, $t2, 1
	slt $t3, $t2, $a1
	beq $t3, $zero, __sorted_exit_ok
	sll $t3, $t2, 2
	add $a0, $a0, $t3
	j __sorted_loop 
__sorted_exit_ok:
	addi $v0, $zero, 1
__sorted_exit:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	la $a0, BASE
	la $a1, LEN
	jal sorted

	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall

	lw $ra, ($sp)
	addi $sp, $sp, 4
	
	jr $ra