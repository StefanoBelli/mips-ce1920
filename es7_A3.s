# 0x0040D000 <-- determinare campi imm di beq, bne, j, jal

.text
min: # 0x40D000
	slt $t0, $a0, $a1
	bne $t0, $zero, __min_first			# __min_first = 2
	add $t1, $zero, $a1
	j __min_next						# 0x40D000 + (5 * 4)

__min_first:
	add $t1, $zero, $a0

__min_next:
	slt $t0, $t1, $a2
	bne $t0, $zero, __min_second # t1 < a2 # __min_second = 2
	add $v0, $zero, $a2
	jr $ra

__min_second:
	add $v0, $zero, $t1
	jr $ra
	
g: # 0x40D044
	addi $t0, $zero, 3
	addi $v0, $zero, 4
	slt $t1, $a0, $t0
	bne $t1, $zero, __g_end

	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	
	srl $a0, $a0, 1
	jal f
	sw $v0, 8($sp) # PUSH(v0) <--

	lw $a0, 4($sp)
	addi $a0, $a0, -1
	jal g

	lw $a2, 4($sp) # a2 = i
	add $a1, $zero, $v0 # a1 = v0 = g(a0 - 1)
	lw $a0, 8($sp) # a0 = f(i/2)
	jal min

	lw $ra, ($sp)
	addi $sp, $sp, 12

__g_end:
	jr $ra

f:
	addi $t0, $zero, 2
	addi $v0, $zero, 1
	slt $t1, $a0, $t0
	bne $t1, $zero, __f_end

	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)

	addi $a0, $a0, -2
	jal f
	sll $v0, $v0, 1

	sw $v0, 8($sp)
	lw $a0, 4($sp)
	addi $a0, $a0, -1
	jal g

	addi $t0, $zero, 5
	mult $v0, $t0
	mfhi $v0
	mflo $v0	   # 5g(i - 1)
	lw $t0, 8($sp) # 2f(i - 2)
	lw $a0, 4($sp) # i

	add $a0, $a0, $t0 # i + 2f(i - 2)
	add $v0, $v0, $a0 # 5g(i - 1) + i + 2f(i - 2)
	addi $v0, $v0, -3 # 5g(i - 1) + 2f(i - 2) + i - 3

	lw $ra, ($sp)
	addi $sp, $sp, 12
__f_end:
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	# f
	addi $a0, $zero, 10
	jal f

	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall

	lw $ra, ($sp)
	addi $sp, $sp, 4

	jr $ra
