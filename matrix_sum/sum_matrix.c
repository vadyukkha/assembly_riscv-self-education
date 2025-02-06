#include <stdio.h>
#include <stdlib.h>

int sum_matrix(int *a, int row, int col);  // Declaration of the assembly function

int main() {
    int row = 2;
    int col = 2;
    int *a = (int *)malloc(row * col * sizeof(int));
    for (int i = 1; i <= row * col; i++) {
        a[i - 1] = i;
    }

    int sum_asm = sum_matrix(a, row, col);

    printf("[ASM] sum of matrix = %d\n", sum_asm);

    int sum = 0;
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            sum += a[i * col + j];
        }
    }

    printf("[C] sum of matrix = %d\n", sum);

    return 0;
}
