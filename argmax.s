.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
# element. If there are multiple, return the one
# with the smallest index.
# Arguments:
# a0 is the pointer to the start of the vector
# a1 is the # of elements in the vector
# Returns:
# a0 is the first index of the largest element
# =================================================================
argmax:
    addi sp sp -20
    sw s3 12(sp)
    sw s2 8(sp)
    sw s1 4(sp)
    sw s0 0(sp)
    sw ra 16(sp)

    add s3 x0 x0
    add s2 x0 x0
    add s0 x0 x0

    bge x0 a1 loop_end
    lw s1 0(a0)

loop_start:
    bge s0 a1 loop_end
    lw s2 0(a0)
    bge s1 s2 loop_continue
    add s1 s2 x0
    add s3 s0 x0
    j loop_continue


loop_continue:
    addi a0 a0 4
    addi s0 s0 1
    j loop_start

loop_end:
    add a0 x0 s3
    lw s3 12(sp)
    lw s2 8(sp)
    lw s1 4(sp)
    lw s0 0(sp)
    lw ra 16(sp)
    addi sp sp 20

    ret