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

    mv t3, a1                   # t3 = size
    vmv.v.i v1, 0
loop:
    blez t3, done               # if size <= 0, exit
    vsetvli t1, t3, e32

    vle32.v v0, (a0)            # load el from A
    vadd.vv v1, v1, v0          # v1 = v0 + v1

    slli t2, t1, 2              # t2 = t1 * 4
    add a0, a0, t2              # move to next element A
    sub t3, t3, t1              # size -= vl

    j loop                      # repeat
done:
    vsetvli t1, a1, e32
    # reduction
    vmv.v.i v3, 0
    vredsum.vs v3, v1, v3
    vmv.x.s t0, v3
    
    mv a0, t0                   # return sum
    ret
