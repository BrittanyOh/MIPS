.data
prompt: .asciiz "Enter your string:"
invalid_string: .asciiz "NaN"
string:   .space 9


.globl  main

.text
li $t2, 0 # ending results

main:
  sub $sp, $sp, 60


 #read users input
 li $v0, 8
 la $a0, string #load byte space into address
 li $a1, 9
 syscall

 li $t1, 0 # initialize length counter
 la $s0, string # load address of string to s0
 lb $t0, 0($s0) # start at 0th index of string
 jal subprogram_2 # call subprogram_1 function to count sum

subprogram_2:
  jal loop #call loop to check strings length
  add $t5, $zero, $t1 # store length in t5
  jal subprogram_1
  j subprogram_2


loop:
 #beq $t0, 0, exit  exit if index value is null
 #beq $t0, 10, exit  exit if index value is new line
 beq $t0, 44, exit #exit once you reach comma
 addi $s0, $s0, 1 # increment index
 addi $t1, $t1, 1 # increment length count
 j loop

exit:
la $s0, string
jr $ra

subprogram_1:
 lb $t0, 0($s0)
 addi $s0, $s0, 1
 beq $t0, 0, results
 beq $t0, 10, results
 # check if char is invalid or num 0-9
 blt $t0, 48, invalid
 blt $t0, 58, is_num
 # check if char is invalid or uppercase A-F
 blt $t0, 65, invalid
 blt $t0, 71, is_upper
 # check if char is invalid or lowercase a-f
 blt $t0, 97, invalid
 blt $t0, 103, is_lower
 j subprogram_1

results:
slti $t4,$t5, 8 #check is string is greater than length of 7
bne $t1, 1, large_string # if true call large_string function

# else print results
li $v0, 1
move $a0, $t2
syscall

li $v0, 10
syscall

large_string:
li $t6, 10000 # place 10000 in t6
divu $t2, $t6 # divide strings sum by 10000
mflo $t6
mfhi $t3

# print results
li $v0, 1
move $a0, $t6
syscall

li $v0, 1
move $a0, $t3
syscall

li $v0, 10
syscall

invalid:
 li $v0, 4
 la $a0, invalid_string # print out invalid string
 syscall

 li $v0, 10
 syscall

is_upper:
addiu $t1,$t0,-0x37 # subtract 55 from hex char ('A'- 'F')
sllv $t2, $t2, 4 # left shift over 4 bits
add $t2,$t2,$t1 # next char to sum
 j subprogram_1

is_num:
addiu $t1, $t0, -0x30     # Subtract 48 from hex char ('0'-'9')
sllv $t2, $t2, 4 # left shift over 4 bits
add $t2,$t2,$t1 # next char to sum
 j subprogram_1

is_lower:
addiu $t1, $t0, -0x57     #  subtract 87 from hex char ('a'- 'f')
sllv $t2, $t2, 4 # left shift over 4 bits
add $t2,$t2,$t1 # next char to sum
 j subprogram_1
