.data
arr: .word 1
arr1: .word 2
arr2: .word 3
arr3: .word 10

.text
radiceq:
	add $v0, $0, $a0
	jr $ra

compute_sqrt:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 16($sp)

	addi $t0, $0, 0
	add $s0, $0, $a0
	add $s1, $0, $a1
	add $s2, $0, $0
__loop:
	sw $t0, 12($sp)
	lw $a0, 0($a0)
	jal radiceq
	add $s2, $s2, $v0
	add $a0, $0, $s0
	addi $a0, $a0, 4
	add $s0, $0, $a0
	lw $t0, 12($sp)
	addi $t0, $t0, 1
	slt $t1, $t0, $s1
	bne $t1, $0, __loop

	add $v0, $0, $s2
	lw $s2, 16($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, arr
	addi $a1, $0, 4
	jal compute_sqrt

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
