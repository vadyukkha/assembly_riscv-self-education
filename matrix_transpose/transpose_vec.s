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

    li   t0, 0                      # j = 0
column_loop:
    bge  t0, a3, done               # if j >= col, exit
    li   t1, 0                      # i = 0
row_loop:
    bge  t1, a2, next_column         # if i >= row, move to next column

    sub  t2, a2, t1                  # t2 = row - i
    vsetvli t3, t2, e32, m1          # VL = min(t2, VLEN)

    # index-vector for gather
    vid.v v4                         # v4 = [0, 1, 2, ..., VL-1]
    slli t4, a3, 2                   # t4 = col * 4 (offset in bytes)
    vmul.vx v4, v4, t4               # v4 = v4 * (col * 4)

    # calc offset
    mul  t5, t1, a3                  # t5 = i * col (line start pos)
    add  t5, t5, t0                  # t5 = i * col + j (offset)
    slli t5, t5, 2                   # t5 *= 4 (offset in bytes)
    add  t6, a0, t5                  # t6 = &A[i][j]
    
    # load column j from A 
    vluxei32.v v0, (t6), v4          # load {A[i][j], A[i+1][j], ...}

    # calc offset
    mul  t5, t0, a2                  # t5 = j * row (line start pos)
    add  t5, t5, t1                  # t5 = j * row + i (offset)
    slli t5, t5, 2                   # t5 *= 4 (offset in bytes)
    add  t6, a1, t5                  # t6 = &B[j][i]

    # store
    vse32.v v0, (t6)                 

    add  t1, t1, t3                  # i += VL
    j    row_loop                    # repeat

next_column:
    addi t0, t0, 1                   # j++
    j column_loop                    # move to next column

done:
    ret
