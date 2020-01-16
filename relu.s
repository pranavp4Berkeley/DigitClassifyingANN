.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -20
    sw s3, 12(sp)
    sw s2, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)
    sw ra, 16(sp)

    addi s0 x0 0
    addi s1 x0 0
    addi s2 x0 0
    addi s3 x0 0


loop_start:
    bge s0 a1 loop_end
    lw s2 0(a0)
    blt s2 x0 loop_continue 
    bge s2 x0 loop_next
    
    

loop_next:
    addi a0 a0 4
    addi s0 s0 1
    j loop_start
    
loop_continue:
    sw x0 0(a0)
    addi a0 a0 4
    addi s0 s0 1
    j loop_start
    

loop_end:


    # Epilogue
    lw s0 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
	
    ret