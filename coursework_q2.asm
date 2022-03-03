.data
buffer_for_input_string: .space 100
buffer_for_processed_string: .space 100
prompt_for_input: .asciiz "Please enter your string:\n"
prompt_for_output: .asciiz "Your processed string is as follows:\n"

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

# reading the input string and putting it in the memory:
# the starting address of the string is accessible as buffer_for_input_string
# 100 is the hard-coded maximum length of the null-terminated string that is
# going to be read from the input. So effectively, up to 99 ascii characters.
li $v0, 8
la $a0, buffer_for_input_string
li $a1, 100
syscall

# >>>> MAKE YOUR CHANGES BELOW HERE:

# Looping over characters of the string:
la      $t0, buffer_for_input_string
la      $t1, buffer_for_processed_string
Loop:
lb      $t2, 0($t0) 
# potentially do some processing on the character loaded in t2

li $t3, 0
check_space:
    beq $t2, ' ', counter_increment
j check_punctuation

counter_increment:
    addi $t0, $t0, 1
    lb $t2, 0($t0)
    addi $t3, $t3, 1 #increment counter by 1
j check_space

check_punctuation:
    beq $t2, '.', end
    beq $t2, ',', end
    beq $t2, '!', end
    beq $t2, '?', end
    beq $t2, ';', end
    beq $t2, ':', end
j non_punctiation

non_punctiation:
    sub $t0, $t0, $t3
    lb $t2, 0($t0)
    
end:
sb      $t2, 0($t1)
addi    $t0, $t0, 1
addi    $t1, $t1, 1
bne     $t2, $zero, Loop # keep going until you reach the end of the string,
                         # which is demarcated by the null character.

# <<<< MAKE YOUR CHANGES ABOVE HERE

# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the processed output
# note that v0 already holds 4, the syscall code for printing a string.
la $a0, buffer_for_processed_string
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit