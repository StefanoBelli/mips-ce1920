.data
separate: .asciiz "***************\n"

.text

main:
	addi $a0, $zero, 10
	addi $a1, $zero, 50

	mult $a0, $a1

	mflo $a0
	addi $v0, $zero, 1
	syscall

	la $a0, separate
	addi $v0, $zero, 4
	syscall

	addi $a0, $zero, 5
	addi $a1, $zero, 2

	div $a0, $a1

	mfhi $a0
	addi $v0, $zero, 1
	syscall
	
	mflo $a0
	addi $v0, $zero, 1
	syscall


	jr $ra
