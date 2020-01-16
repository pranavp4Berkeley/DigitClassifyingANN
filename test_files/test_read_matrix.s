.import ../read_matrix.s
.import ../utils.s

.data
file_path: .asciiz "./test_input.bin"

.text
main:

    # Read matrix into memory
    li a0 4
    jal ra malloc
    mv s0 a0

    li a0 4
    jal ra malloc
    mv s1 a0

    la a0 file_path
    mv a1 s0
    mv a2 a1

    jal ra read_matrix

    # Print out elements of matrix
    
    # a0 is already set by read_matrix
    li a1 3     # rows
    li a2 4     # columns
    jal ra print_int_array


    # Terminate the program
    addi a0, x0, 10
    ecall