.data
str: .asciiz "Corso  di Calcolatori"

.text
delchr:
	addi $t0, $0, 0
	add $a0, $a0, $a1
	addi $a2, $a2, -1
__delchr_loop:
	add $t2, $0, $a0
	addi $a0, $a0, 1
	
	lb $t1, 0($a0)
	sb $t1, 0($t2)

	addi $t0, $t0, 1
	slt $t1, $t0, $a2
	bne $t1, $0, __delchr_loop

	jr $ra

delspc:
	addi $t3, $0, 32

	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $t3, 16($sp)
	sw $a1, 8($sp)

	addi $t0, $0, 0
__delspc_loop:
	addi $t1, $0, 0
	lb $t1, 0($a0)

	slt $t2, $t1, $t3
	bne $t2, $0, __delspc_loop_condcheck
	slt $t2, $t3, $t1
	bne $t2, $0, __delspc_loop_condcheck

	sw $a0, 4($sp)
	sw $t0, 12($sp)

	add $a2, $0, $a1
	addi $a1, $0, 0
	jal delchr
	
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $t0, 12($sp)
	lw $t3, 16($sp)
	
	addi $a0, $a0, -1

__delspc_loop_condcheck:
	addi $t0, $t0, 1
	addi $a0, $a0, 1
	slt $t1, $t0, $a1
	bne $t1, $0, __delspc_loop

	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, str
	addi $a1, $0, 21
	jal delspc

	la $a0, str
	addi $v0, $0, 4
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

