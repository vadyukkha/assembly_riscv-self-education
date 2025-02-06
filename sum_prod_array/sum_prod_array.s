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
    # a3 - prod_arr
    # a4 - size
    li t5, 0                    # cnt = 0
loop:
    beq t5, a4, done            # if cnt == size, exit
    lw t0, 0(a0)                # a[i]
    lw t1, 0(a1)                # b[i]
    add t2, t0, t1              # a[i] + b[i]
    mul t3, t0, t1              # a[i] * b[i]
    
    sw t2, 0(a2)                # store sum_arr[i]
    sw t3, 0(a3)                # store prod_arr[i]

    addi a0, a0, 4              # move point to next element
    addi a1, a1, 4              # move point to next element
    addi a2, a2, 4              # move point to next element
    addi a3, a3, 4              # move point to next element
    addi t5, t5, 1              # cnt++
    j loop
done:
    ret
