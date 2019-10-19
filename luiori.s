main:
	lui $a0, 0x7FFF
	ori $a0, 0xFFFF

	addi $v0, $zero, 1
	syscall

	jr $ra
