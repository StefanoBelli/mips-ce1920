.data
arr: .word 0
arr1: .word 4
arr2: .word 5
arr3: .word 9

.text
array_through:
	addi $t0, $0, 0
	add $t1, $0, $a0
__array_through_loop:
	lw $a0, 0($t1)
	addi $v0, $0, 1
	syscall

	addi $t0, $t0, 1
	addi $t1, $t1, 4
	slt $t2, $t0, $a1
	bne $t2, $0, __array_through_loop
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, arr
	addi $a1, $0, 4
	jal array_through

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra