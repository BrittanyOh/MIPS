.data
 prompt: .ascii "Enter your string"
 message: .ascii "Your string is "
 
.text
 #prompt users to enter string
 li $v0, 4
 la $a0, prompt
 syscall