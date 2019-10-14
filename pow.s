.text

# int __v0 pow(int __a0 base, int __a1 exp)
pow:
	li $v0, 1
	beq $a1, 0, __pow_end

	move $v0, $a0
	beq $a1, 1, __pow_end

	move $t0, $a0

__pow_loop:
	mul $t0, $t0, $a0
	addi $a1, $a1, -1
	bgt $a1, 1, __pow_loop

	move $v0, $t0
__pow_end:
	jr $ra
	
main:
	move $t2, $ra

	li $a1, 4
	li $a0, 2
	jal pow

	move $a0, $v0
	li $v0, 1
	syscall

	move $ra, $t2
	jr $ra
