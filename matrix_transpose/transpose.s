# Compute transpose(...) using algorithm below
#
# for (size_t i = 0; i < col_a; i++) {
#     for (size_t j = 0; j < col_b; j++) {
#         transpose[j * col_a + i] = original[i * col_b + j];
#     }
# }

    .globl transpose
    .type transpose, @function
    .section .text
transpose:
    # a0 - original matrix
    # a1 - transposed matrix
    # a2 - row
    # a3 - col

    li t0, 4                    # word(int) size
    li t1, 0                    # i = 0
    li t2, 0                    # j = 0
loop_i:
    beq t1, a2, loop_i_end      # if i == row, exit
    li t2, 0                    # j = 0
loop_j:
    beq t2, a3, loop_j_end      # if j == col, exit
    
    # calc offset
    mul t3, t1, a3              # i * col
    add t3, t3, t2              # i * col + j
    slli t3, t3, 2              # (i * col + j) * 4
    add t3, a0, t3              # a + (i * col + j) * 4

    mul t4, t2, a2              # j * row
    add t4, t4, t1              # j * row + i
    slli t4, t4, 2              # (j * row + i) * 4
    add t4, a1, t4              # b + (j * row + i) * 4

    # swap
    lw t5, 0(t3)                # t5 = a[i][j]
    sw t5, 0(t4)                # b[j][i] = a[i][j]

    addi t2, t2, 1              # j++
    j loop_j                    # repeat

loop_j_end:
    addi t1, t1, 1              # i++
    j loop_i
loop_i_end:
    ret
