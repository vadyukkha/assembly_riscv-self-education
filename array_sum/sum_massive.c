#include <stdio.h>
#include <stdlib.h>

int sum_massive(int *a, int n);  // Declaration of the assembly function

int main() {
    int n = 100;
    int *a = (int *)malloc(n * sizeof(int));
    for (int i = 1; i <= n; i++) {
        a[i - 1] = i;
    }

    int sum_asm = sum_massive(a, n);
    printf("[ASM] sum of array = %d\n", sum_asm);

    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += a[i];
    }
    printf("[C] sum of array = %d\n", sum);

    return 0;
}
