# Compute fib(n) using recursion algorithm
#
#   int fib(int n) {
#       return fib(n-1) + fib(n-2) ? n > 1 : 1;
#   }

    .globl fib
    .type fib, @function
    .section .text
fib:
    li      a1, 1                   # if a0 <= 1
    bgt     a0, a1, ELSE            # .
    ret                             # return
ELSE:
    addi    sp, sp, -24             # Allocate stack frame
    sd      s1, 0(sp)               # Save s1, s2, ra
    sd      s2, 8(sp)               # .
    sd      ra, 16(sp)              # .
    addi    s2, a0, -2              # s2 = n-2
    addi    a0, a0, -1              # a1 = n-1
    call    fib                     # a0 = fib(a0)
    mv      s1, a0                  # s1 = a0
    mv      a0, s2                  # a0 = n-2
    call    fib                     # a0 = fib(a0)
    add     a0, a0, s1              # a0 = a0, s1
    ld      s1, 0(sp)               # Restore s1, s2, ra
    ld      s2, 8(sp)               # .
    ld      ra, 16(sp)              # .
    addi    sp, sp, 24              # Pop stack frame
    ret                             # return a0
