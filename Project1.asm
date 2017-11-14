#DUE NOVEMBER 15 BY MIDNIGHT!!!
.data
 prompt: .ascii "Enter your string"

.text
 #prompt users to enter string
 li $v0, 8
 la $a0, prompt
 syscall

 #get users input
 li $v0, 4
 syscall
