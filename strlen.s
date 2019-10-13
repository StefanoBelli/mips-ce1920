.data
test: .asciiz "test"

.text

strlen:
	beq $a0, 0, __strlen_end

	li $v0, 0 #v0: return value

__strlen_loop:
	lb $t0, ($a0)
	beq $t0, 0, __strlen_end
	addi $v0, $v0, 1
	addi $a0, $a0, 1
	j __strlen_loop

__strlen_end:
	jr $ra

main:
	sw $ra, ($sp)
	la $a0, test
	jal strlen
	lw $ra, ($sp)

	move $t0, $v0

	li $v0, 1
	move $a0, $t0
	syscall

	jr $ra
