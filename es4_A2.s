.data
base: .word 1
base1: .word 2
base2: .word 5
base3: .word 5
case: .word 0
case1: .word 0
case2: .word 0
case3: .word 0

.text
arrsum:
	addi $t0, $zero, 0
	add $t2, $zero, $a0
	add $t5, $zero, $a1

__arrsum_loop:
	slt $t3, $t0, $a2
	beq $t3, $zero, __arrsum_finish # to = a2

	addi $t1, $zero, 0
	addi $t4, $zero, 0
____arrsum_inner_loop:
	lw $t3, ($a0)
	add $t4, $t4, $t3

	add $a0, $zero, $t2

	slt $t3, $t1, $t0
	beq $t3, $zero, __arrsum_back # t1 >= t0

	addi $t1, $t1, 1
	sll $t7, $t1, 2
	add $a0, $a0, $t7

	j ____arrsum_inner_loop

__arrsum_back:
 	lw $t3, ($a1)
	add $t3, $t3, $t4
	sw $t3, ($a1)

	add $a1, $zero, $t5

	addi $t0, $t0, 1
	sll $t7, $t0, 2
	add $a1, $a1, $t7

	j __arrsum_loop

__arrsum_finish:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	la $a0, base
	la $a1, case
	addi $a2, $zero, 4
	jal arrsum

	lw $ra, ($sp)
	addi $sp, $sp, 4

	jr $ra
