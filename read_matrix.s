.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 is the pointer to the matrix in memory
# ==============================================================================
read_matrix:

    # Prologue
    addi sp, sp, -40
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw s8, 32(sp)
    sw ra, 36(sp)

    mv s0, a0
    mv s1, a1
    mv s2, a2

    mv a1, s0
    li a2, 0
    jal ra fopen
    li t0, -1
    beq t0, a0, eof_or_error
    mv s3, a0 # s3 is file descriptor

    li a0, 8
    jal ra malloc
    mv s4, a0 # s4 is the pointer to the buffer to the space for fread

    mv a1, s3
    mv a2, s4
    li a3, 8
    jal ra fread
    li t0, 8
    bne a0, t0, eof_or_error
    lw s5, 0(s4) # s5 is the number of rows
    lw s6, 4(s4) # s6 is the number of columns
    li t0, 0

    sw s5, 0(s1)
    sw s6, 0(s2)

    beq t0, s5, if_zero_dim
    beq t0, s6, if_zero_dim

    li t0, 4
    mul t1, s5, s6
    mul t1, t1, t0
    mv a0, t1
    mv s7, t1 # s7 is the number of bytes for the matrix
    jal ra malloc
    mv s4, a0 # s4 is the buffer to the space for fread

    mv a1, s3
    mv a2, s4
    mv a3, s7
    jal ra fread
    bne a0, s7, eof_or_error
    mv s8, a2 # makes s8 point to the matrix that was read

if_zero_dim:

    mv a1, s3
    jal ra fclose
    li t0, -1
    beq t0, a0, eof_or_error

    # Epilogue
    mv a0, s8

    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw s8, 32(sp)
    lw ra, 36(sp)
    addi sp, sp, 40

    ret

eof_or_error:
    li a1 1
    jal exit2