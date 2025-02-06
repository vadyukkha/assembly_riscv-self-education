#include <stdio.h>
#include <stdlib.h>

void transpose(int *a, int *b, int row, int col);  // Declaration of the assembly function

void print_matrix(int *matrix, int row, int col) {
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            printf("%d ", matrix[i * col + j]);
        }
        printf("\n");
    }
}

int main() {
    int row = 3;
    int col = 3;
    int *a = (int *)malloc(row * col * sizeof(int));
    int *b = (int *)malloc(row * col * sizeof(int));

    for (int i = 1; i <= row * col; i++) {
        a[i - 1] = i;
    }

    transpose(a, b, row, col);

    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            if (a[i * col + j] != b[j * row + i]) {
                printf("Test failed\n");
                printf("a[%d][%d] = %d, b[%d][%d] = %d\n", i, j, a[i * col + j], j, i,
                       b[j * row + i]);
                printf("Matrix A:\n");
                print_matrix(a, row, col);
                printf("Matrix B:\n");
                print_matrix(b, col, row);
                return 1;
            }
        }
    }

    printf("Test passed\n");

    return 0;
}
