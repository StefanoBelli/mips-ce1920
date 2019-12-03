.data
arr: .word 300
arr1: .word 10
arr2: .word 5
arr3: .word 100

.text
max:
	add $v0, $0, $a0
	slt $t0, $a0, $a1
	beq $t0, $0, __max_end
	add $v0, $0, $a1
__max_end:
	jr $ra

max_array:
	lw $v0, 0($a0)
	slti $t0, $a1, 1
	bne $t0, $0, __max_array_continue
	addi $t1, $0, 1
	slt $t0, $t1, $a1
	beq $t0, $0, __max_array_finish

__max_array_continue:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	add $s0, $0, $v0

	addi $a0, $a0, 4
	addi $a1, $a1, -1
	jal max_array

	add $a0, $0, $v0
	add $a1, $0, $s0
	jal max
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addi $sp, $sp, 8
__max_array_finish:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, arr
	addi $a1, $0, 5
	jal max_array

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra