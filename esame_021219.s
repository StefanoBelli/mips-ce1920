.data
arr0: .word 3
arr1: .word 4
arr2: .word 3
arr3: .word 2
arr4: .word 9
arr5: .word 8
arr6: .word 1
arr7: .word 0
arr8: .word 80
arr9: .word 21

.text
sost_conta:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	addi $t0, $0, 1
	bne $t0, $a1, __skip
							# IF*(m == 1)
	lw $s0, 0($a0)
	addi $v0, $0, 0
	bne $s0, $a2, __finish 
							# IF**(A[0] == k)
	sw $a3, 0($a0)
	addi $v0, $0, 1
	j __finish

__skip:						# ELSE*
	add $s1, $0, $a1
	add $s0, $0, $a0
	
	srl $a1, $a1, 1
	jal sost_conta 			# CALL* = sost_conta(A, m/2, k, h)

	add $a1, $0, $s1
	add $s1, $0, $v0

	srl $a1, $a1, 1
	sll $a0, $a1, 2
	add $a0, $a0, $s0
	jal sost_conta 			# CALL** = sost_conta(A+m/2, m/2, k, h)

	add $v0, $v0, $s1

__finish:
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, arr0
	addi $a1, $0, 50
	addi $a2, $0, 3
	addi $a3, $0, 69
	jal sost_conta

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
