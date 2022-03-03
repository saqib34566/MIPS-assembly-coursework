.data
prompt_for_input: .asciiz "Please enter your numbers, pressing enter after each, (0 to terminate):\n"
prompt_for_output: .asciiz "Your quantity of interest is equal to: "

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall


li $t1, 0 #entry counter
LOOP: 
    li  $v0, 5
    syscall 
    beq $v0, $zero, exit  #exits loop when reaches end of list(i.e reaching 0)

    andi $t3, $v0, 0x01 #and mask of 1

    bne $t3, 0, add_odd_counter #number is odd
    j SKIP  #skips when number is not odd 

    add_odd_counter:
        addi $t1, $t1, 1 #increment counter by 1
SKIP:
j LOOP

exit:

# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the output
addiu  $v0, $zero, 1
addu $a0, $zero, $t1
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit


