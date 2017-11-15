
#DUE NOVEMBER 15 BY MIDNIGHT!!!

.data
prompt: .asciiz "Enter your string:"
results:   .asciiz "Your string is:"
invalid_string: .asciiz "Invalid hexadecimal number."
string:   .space 9


.globl  main

.text

main:
 li $v0, 4 # prompt users to enter string
 la $a0, prompt
 syscall

 #read users input
 li $v0, 8
 la $a0, string #load byte space into address
 li $a1, 9
 syscall

 li $t1, 0 # initialize counter
la $s0, string
 jal loop
 jal validation

loop:
 lb $t0, 0($s0)
 beq $t0, 0, exit
 beq $t0, 10, exit
 addi $s0, $s0, 1
 addi $t1, $t1, 1
 j loop

exit:
la $s0, string

validation:
 lb $t0, 0($s0)
 # check if char is invalid or num 0-9
 blt $t0, 48, invalid
 blt $t0, 58, is_num
 # check if char is invalid or uppercase A-F
 blt $t0, 65, invalid
 blt $t0, 71, is_upper
 # check if char is invalid or lowercase a-f
 blt $t0, 97, invalid
 blt $t0, 103, is_lower
 addi $s0, $s0, 1
 j validation

invalid:
 li $v0, 4
 la $a0, invalid_string
 syscall

is_num:
is_lower:
is_upper:
