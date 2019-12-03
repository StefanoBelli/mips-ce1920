.data
a0: .word 1
a1: .word 2
a3: .word 3

b0: .word 3
b1: .word 2
b2: .word 1

.text
scalar_sum:
	addi $v0, $0, 0
	addi $t0, $0, 0
__scalar_sum_loop:
	lw $t1, 0($a0)
	lw $t2, 0($a1)
	add $v0, $v0, $t1
	add $v0, $v0, $t2

	addi $t0, $t0, 1
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	slt $t1, $t0, $a2
	bne $t1, $0, __scalar_sum_loop

	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, a0
	la $a1, b0
	addi $a2, $0, 3
	jal scalar_sum

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
