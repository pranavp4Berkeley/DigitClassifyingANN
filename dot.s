.globl dot


.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:
    # Prologue
    addi sp sp -32
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw s6 24(sp)
    sw ra 28(sp)

    addi s0 x0 0
    add s1 a0 x0 
    add s2 a1 x0 
    addi s6 x0 4
    mul a3 a3 s6 
    mul a4 a4 s6 

loop_start:
    bge x0 a2 loop_end

loop_continue:
    lw s3 0(s1) 
    lw s4 0(s2) 
    mul s5 s3 s4 
    add s0 s0 s5 
    addi a2 a2 -1 
    add s1 s1 a3 
    add s2 s2 a4 
    j loop_start

loop_end:
    # Epilogue
    addi a0 s0 0
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw s6 24(sp)
    lw ra 28(sp)
    addi sp sp 32
    ret