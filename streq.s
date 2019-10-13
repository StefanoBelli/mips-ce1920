.data
s1: .asciiz "culo"
s2: .asciiz "culo"

.text

# int __v0 streq(const char* __a0 s1, const char* __a1 s2)
streq:
	li $v0, 0
	beq $a0, 0, __streq_end
	beq $a1, 0, __streq_end

__streq_loop:
	lb $t0, ($a0)
	lb $t1, ($a1)

	beq $t0, 0, __streq_loopexit
	bne $t0, $t1, __streq_end
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1

	j __streq_loop

__streq_loopexit:
	bne $t1, 0, __streq_end
	li $v0, 1

__streq_end:
	jr $ra
	
main:
	sw $ra, ($sp)

	la $a0, s1
	la $a1, s2
	jal streq

	move $a0, $v0
	li $v0, 1
	syscall

	lw $ra, ($sp)

	jr $ra
