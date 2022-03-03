.data
prompt_for_input: .asciiz "Please enter your numbers, pressing enter after each, (0 to terminate):\n"
prompt_for_output: .asciiz "Your quantity of interest is equal to: "

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall


li $t0, 0 #sum
LOOP: 
    li  $v0, 5
    syscall 
    beq $v0, $zero, exit  #exits loop when reaches end of list(i.e reaching 0)

    andi $t3, $v0, 0x07 #and mask of 7

    beq $t3, 0, add_sum #number is divisble by 8
    j SKIP  #skips when number is not divisble  by 8

    add_sum:
        add $t0, $t0, $v0  #add entry to sum
SKIP:
j LOOP

exit:

# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the output
addiu  $v0, $zero, 1
addu $a0, $zero, $t0
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit


