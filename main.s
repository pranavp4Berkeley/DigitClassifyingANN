.import read_matrix.s
.import write_matrix.s
.import matmul.s
.import dot.s
.import relu.s
.import argmax.s
.import utils.s
.globl main
.text
main:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0: int argc
    #   a1: char** argv
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    # Exit if incorrect number of command line args
    li t0, 5
    bne a0, t0, wrong_num_args



	# =====================================
    # LOAD MATRICES
    # =====================================
    mv s1 a1      
    mv s2 s1 

    # Load pretrained m0
    li a0, 4
    jal ra malloc
    mv s3, a0

    li a0, 4
    jal ra malloc
    mv s4, a0

    lw a0 4(s1)
    mv a1 s3
    mv a2 s4

    jal ra read_matrix
    lw t0 0(s3)           
    lw s11 0(s4)           
    mv s4 t0
    mv s3 a0              

    # Load pretrained m1
    li a0, 4
    jal ra malloc
    mv s5, a0

    li a0, 4
    jal ra malloc
    mv s6, a0

    lw a0, 8(s1)
    mv a1, s5
    mv a2, s6

    jal ra read_matrix
    lw t0 0(s5)           
    lw s7 0(s6)           
    mv s6 t0
    mv s5 a0              



    # Load input matrix
    li a0, 4
    jal ra malloc
    mv s8, a0

    li a0, 4
    jal ra malloc
    mv s9, a0

    lw a0, 12(s1)
    mv a1, s8
    mv a2, s9

    jal ra read_matrix
    lw t0 0(s8)           
    lw s10 0(s9)           
    mv s9 t0
    mv s8 a0              



    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)

    mul a0 s4 s10         
    li t0 4
    mul a0 a0 t0
    jal ra malloc
    mv s1 a0              
    mv a6 s1
    mv a4 s9
    mv a3 s8
    mv a0 s3
    mv a1 s4
    mv a5 s10               
    mv a2 s11     
    jal matmul            
    mv a0 s1
    mul a1 s4 s10
    jal relu
    mv s3 s1              
    mul a0 s6 s10          
    li t0 4
    mul a0 a0 t0
    jal malloc
    mv s1 a0              
    mv a1 s6 
    mv a6 s1            
    mv a2 s7
    mv a3 s3
    mv a4 s4
    mv a0 s5
    mv a5 s10              
    jal matmul            


    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0 16(s2) 
    mv a1 s1
    mv a2 s6
    mv a3 s10
    jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    mv a0 s1
    mul a1 s6 s10
    jal argmax
    # Print classification
    mv a1, a0
    jal ra print_int
    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    jal exit

wrong_num_args:
    li a1, 3
    jal exit2