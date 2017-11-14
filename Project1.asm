
#DUE NOVEMBER 15 BY MIDNIGHT!!!

.data
prompt: .asciiz "Enter your string: "
results:   .asciiz "Your string is: "
invalid: .asciiz "Invalid hexadecimal number."


.globl  main

.text

main:
li $t4, 8 # initialize the length to 8

 #prompt users to enter string
 li $v0, 4
 la $a0, prompt
 syscall

 #read users input
 li $v0, 8
 move $a0, $v0
 syscall

jal strlen
slt $t1,$t4,$v1
beq $t1, $zero, end

 li $v0, 10
 syscall

 strlen:
 addi $t2, $zero, 1 #initialize count to start with 1 for first character
 j strlen.test

strlen.loop:
 addi $a1, $a1, 1 #load increment string pointer
 addi $t2, $t2, 1 #increment count
strlen.test:
 lb $t3, 0($a0)   #load the next character to t0
 bnez $t3, strlen.loop #end loop if null character is reached
 move $v1, $t0

 jr $ra

end:
 li $v0, 4
 la $a0, invalid
 syscall
 j EXIT
