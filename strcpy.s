.data
test: .asciiz "testa\n"

.text

# char* __v0 strcpy(const char* __a0 source, char* __a1 dst)
strcpy:
	li $v0, 0
	beq $a0, 0, __strcpy_fail_end
	beq $a0, 0, __strcpy_fail_end

__strcpy_loop:
	lb $t0, ($a0)
	sb $t0, ($a1)
	addi $a0, $a0, 1
	addi $a1, $a1, 1

	beq $t0, 0, __strcpy_end
	
	j __strcpy_loop

__strcpy_end:
	move $v0, $a1
__strcpy_fail_end:
	jr $ra
	
main:
	move $t2, $ra

	addi $sp, $sp, -7
	la $a0, test
	move $a1, $sp
	jal strcpy

	move $ra, $t2
	
	li $v0, 4
	move $a0, $sp
	syscall

	addi $sp, $sp, 7
	jr $ra
