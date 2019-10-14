.text

# int __v0 fact(int __a0 n)
fact:
	addi $sp, $sp, -8
	
	li $v0, 1
	beq $a0, 0, __fact_end
	beq $a0, 1, __fact_end

	sw $a0, 4($sp)
	sw $ra, ($sp)
	
	addi $a0, $a0, -1
	jal fact
	
	lw $ra, ($sp)
	lw $t1, 4($sp)
	
	mul $v0, $v0, $t1
__fact_end:
	addi $sp, $sp, 8
	jr $ra

main:
	move $t2, $ra

	li $a0, 7
	jal fact

	move $a0, $v0
	li $v0, 1
	syscall

	move $ra, $t2
	jr $ra
