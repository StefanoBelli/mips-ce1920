.data
str: .asciiz "osso"

.text
pal:
	addi $v0, $0, 1
	slti $t0, $a1, 2
	bne $t0, $0, __pal_exit 		# t0 = 1 => a1 < 2

	addi $v0, $0, 0

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	addi $t0, $0, 0
	lb $t0, 0($a0) 					# t0 = *(a0) <--
	
	addi $a1, $a1, -1
	add $t1, $a1, $a0 				# t1 = (a0 + a1 - 1)

	addi $t2, $0, 0
	lb $t2, 0($t1) 					# t2 = *(t1) <--

	bne $t0, $t2, __pal_clstk_exit 	# if t0 != t2

	addi $a1, $a1, -1
	addi $a0, $a0, 1
	jal pal

__pal_clstk_exit:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
__pal_exit:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, str
	addi $a1, $0, 4
	jal pal

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra