.data
text: .asciiz "test   this  o ut"

.text

# char* __v0 strtoke(const char* __a0 start, const char __a1 sym, char** __a2 next_begin)
strtoke:
	li $v0, 0
	beq $a0, 0, __strtoke_end
	beq $a2, 0, __strtoke_end

__strtoke_loop0:
	lb $t0, ($a0)
	addi $a0, $a0, 1
	beq $t0, 0, __strtoke_end
	bne $t0, $a1, __strtoke_loop0

	move $v0, $a0
	addi $v0, $v0, -1

__strtoke_loop1:
	lb $t0, ($a0)
	addi $a0, $a0, 1
	beq $t0, 0, __strtoke_end
	beq $t0, $a1, __strtoke_loop1

	addi $a0, $a0, -1

	sw $a0, ($a2)

__strtoke_end:
	jr $ra
	
main:
	move $t2, $ra

	addi $sp, $sp, -4

	la $a3, text #later usage

	move $a0, $a3
	li $a1, 32
	move $a2, $sp
	jal strtoke

	lw $a0, ($sp)
	li $v0, 4
	syscall
	
	addi $sp, $sp, 4

	move $ra, $t2

	jr $ra
