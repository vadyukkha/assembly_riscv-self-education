# Compute generate_sum_prod_arr(...) using algorithm below
#
#   void generate_sum_prod_arr(int *a, int *b, int *sum_arr, int *prod_arr, int size) {
#       for (int i = 0; i < size; i++) {
#           sum_arr[i] = a[i] + b[i];
#           prod_arr[i] = a[i] * b[i];
#       }
#   }

    .globl generate_sum_prod_arr
    .type generate_sum_prod_arr, @function
    .section .text
generate_sum_prod_arr:
    # a0 - a
    # a1 - b
    # a2 - sum_arr
    # a3 - prod_ar
    # a4 - size

    li t0, 4                    # word size
    mv t3, a4                   # t1 = size
    vsetvli t1, a4, e32         

loop:
    beqz t3, done               # if size == 0, exit

    vle32.v v0, (a0)            # load el from A
    vle32.v v1, (a1)            # load el from B

    vadd.vv v2, v0, v1          # v2 = v0 + v1
    vmul.vv v3, v0, v1          # v3 = v0 * v1

    vse32.v v2, (a2)            # store sum_arr
    vse32.v v3, (a3)            # store prod_arr

    sub t3, t3, t1              # size -= vl
    slli t2, t1, 2              # t2 = t1 * 4
    add a0, a0, t2              # move to next element A
    add a1, a1, t2              # move to next element B
    add a2, a2, t2              # move to next element sum_arr
    add a3, a3, t2              # move to next element prod_arr

    j loop                      # repeat

done:
    ret
