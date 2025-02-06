    .globl sum_matrix
    .type sum_matrix, @function
    .section .text
sum_matrix:
    # a0 - a
    # a1 - row
    # a2 - col
    
    li t0, 0                    # sum = 0
    li t1, 0                    # i = 0
    li t2, 0                    # j = 0
loop_i:
    beq t1, a1, loop_i_end      # if i == a1 (row), exit
    mv t2, zero                 # j = 0
loop_j:
    beq t2, a2, loop_j_end      # if j == a2 (col)
    lw t3, 0(a0)                # t3 = a[i][j]
    add t0, t0, t3              # sum += a[i][j]
    addi a0, a0, 4              # move to next element
    addi t2, t2, 1              # j++
    j loop_j                    # repeat
loop_j_end:
    addi t1, t1, 1              # i++
    j loop_i
loop_i_end:
    mv a0, t0                   # return sum
    ret
