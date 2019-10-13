.data
remaining: .asciiz "ondo\n"
before: .asciiz "before strnncat: "
after: .asciiz "\nafter strnncat: "

.text

# char* __v0 strnncat(char* __a0 source, const char* __a1 append, int __a2 lensrc, int __a3 lenapp);
strnncat:
	li $v0, 0
	beq $a0, 0, __strnncat_fail_end
	beq $a1, 0, __strnncat_fail_end

	add $a0, $a0, $a2

__strnncat_loop:
	lb $t0, ($a1)
	sb $t0, ($a0)

	addi $a1, $a1, 1
	addi $a0, $a0, 1
	
	addi $a3, $a3, -1
	bne $a3, 0, __strnncat_loop

	move $v0, $a0
__strnncat_fail_end:
	jr $ra
	
main:
	move $t2, $ra
	
	addi $sp, $sp, -11
	
	li $t1, 99 # c
	sb $t1, ($sp)

	li $t1, 105 # i
	sb $t1, 1($sp)

	li $t1, 97 # a
	sb $t1, 2($sp)

	li $t1, 111 # o
	sb $t1, 3($sp)

	li $t1, 109 # m
	sb $t1, 4($sp)

	li $t1, 0
	sb $t1, 5($sp)

	li $v0, 4
	la $a0, before
	syscall

	li $v0, 4
	move $a0, $sp
	syscall

	move $a0, $sp
	la $a1, remaining
	li $a2, 5
	li $a3, 6
	jal strnncat

	li $v0, 4
	la $a0, after
	syscall

	li $v0, 4
	move $a0, $sp
	syscall

	addi $sp, $sp, 11

	move $ra, $t2
	jr $ra
	
