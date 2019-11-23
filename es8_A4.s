.text
getOp:
	lw $t0, ($a0)
	lui $t1, 0xFC00
	and $t0, $t0, $t1
	srl $v0, $t0, 26
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, ($sp)

	la $a0, main
	jal getOp

	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall

	lw $ra, ($sp)
	addi $sp, $sp, 4

	jr $ra
