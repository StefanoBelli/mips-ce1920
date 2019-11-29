.data
arr: .word 0
brr: .word 1
crr: .word 3
drr: .word 4
xrr: .word 5

srr: .word 5
grr: .word 5
frr: .word 5
ahr: .word 4
bri: .word 5

.text
occour:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	addi $t0, $0, 0
	
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	
__occour_loop:
	sw $t0, 16($sp)

	lw $a0, 0($a0)	
	jal count

	slt $t1, $v0, $a3
	addi $v0, $0, 1
	beq $t1, $0, __occour_finish
	addi $v0, $0, 0

	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $t0, 16($sp)

	addi $t0, $t0, 1
	slt $t1, $t0, $a2
	sll $t2, $t0, 2
	add $a0, $a0, $t2
	bne $t1, $0, __occour_loop

__occour_finish:
	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra

count:
	add $t3, $0, $a1

	addi $t0, $0, 0
	addi $v0, $0, 0
__count_loop:
	lw $t1, 0($a1)
	bne $t1, $a0, __count_loop_skipinc
	addi $v0, $v0, 1
__count_loop_skipinc:
	addi $t0, $t0, 1
	slt $t1, $t0, $a2
	sll $t2, $t0, 2

	add $a1, $0, $t3
	add $a1, $a1, $t2
	bne $t1, $0, __count_loop

	jr $ra
	
main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, arr
	la $a1, srr
	addi $a2, $0, 4
	addi $a3, $0, 2
	jal occour

	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
