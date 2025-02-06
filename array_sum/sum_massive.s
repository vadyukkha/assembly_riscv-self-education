# Compute sum_massive(...) using algorithm below
#
#   int sum_massive(int *a, int n) {
#       int sum = 0;
#       for (int i = 0; i < n; i++) {
#           sum += a[i];
#       }
#       return sum;
#   }

    .globl sum_massive
    .type sum_massive, @function
    .section .text
sum_massive:
    # a0 - array A
    # a1 - size 
    
    li t0, 0                    # sum = 0
    li t1, 0                    # cnt = 0
loop:
    beq t1, a1, done            # if counter == a1, exit
    lw t2, 0(a0)                # load value from array
    add t0, t0, t2              # sum += value
    addi a0, a0, 4              # move pointer to next element
    addi t1, t1, 1              # cnt++
    j loop                      # repeat
done:
    mv a0, t0                   # return sum
    ret
