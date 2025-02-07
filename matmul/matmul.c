#include <stdio.h>
#include <stdlib.h>

void matmul(const int *a, const int *b, int *c, int row_a, int col_a,
            int col_b);  // Declaration of the assembly function

void matmul_naive(const int *a, const int *b, int *c, int row_a, int col_a, int col_b) {
    for (int i = 0; i < row_a; i++) {
        for (int j = 0; j < col_b; j++) {
            for (int k = 0; k < col_a; k++) {
                c[i * col_b + j] += a[i * col_a + k] * b[k * col_b + j];
            }
        }
    }
}

void print_matrix(int *matrix, int row, int col) {
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            printf("%d ", matrix[i * col + j]);
        }
        printf("\n");
    }
}

void testing_fully() {
    for (int ROW_A = 1; ROW_A <= 15; ROW_A++) {
        for (int COL_A = 1; COL_A <= 15; COL_A++) {
            for (int COL_B = 1; COL_B <= 15; COL_B++) {
                int *a = (int *)malloc(ROW_A * COL_A * sizeof(int));
                int *b = (int *)malloc(COL_A * COL_B * sizeof(int));
                int *c = (int *)calloc(ROW_A * COL_B, sizeof(int));
                int *ans = (int *)calloc(ROW_A * COL_B, sizeof(int));

                for (int i = 0; i < ROW_A * COL_A; i++) {
                    a[i] = i + 1;
                }

                for (int i = 0; i < COL_A * COL_B; i++) {
                    b[i] = i + 1;
                }

                matmul_naive(a, b, ans, ROW_A, COL_A, COL_B);
                matmul(a, b, c, ROW_A, COL_A, COL_B);

                for (int i = 0; i < ROW_A * COL_B; i++) {
                    if (c[i] != ans[i]) {
                        printf("Test failed with params: ROW_A = %d, COL_A = %d, COL_B = %d\n",
                               ROW_A, COL_A, COL_B);
                        printf("Matrix A:\n");
                        print_matrix(a, ROW_A, COL_A);

                        printf("Matrix B:\n");
                        print_matrix(b, COL_A, COL_B);

                        printf("c[%d] = %d, ans[%d] = %d\n", i, c[i], i, ans[i]);
                        printf("Matrix C:\n");
                        print_matrix(c, ROW_A, COL_B);
                        printf("Matrix Ans:\n");
                        print_matrix(ans, ROW_A, COL_B);
                        return;
                    }
                }

                printf("Test passed with params: ROW_A = %d, COL_A = %d, COL_B = %d\n", ROW_A,
                       COL_A, COL_B);
            }
        }
    }
}

void testing_once(int rows_a, int cols_a, int cols_b) {
    int *a = (int *)malloc(rows_a * cols_a * sizeof(int));
    int *b = (int *)malloc(cols_a * cols_b * sizeof(int));
    int *c = (int *)calloc(rows_a * cols_b, sizeof(int));
    int *ans = (int *)calloc(rows_a * cols_b, sizeof(int));

    for (int i = 0; i < rows_a * cols_a; i++) {
        a[i] = i + 1;
    }

    for (int i = 0; i < cols_a * cols_b; i++) {
        b[i] = i + 1;
    }

    printf("Matrix A:\n");
    print_matrix(a, rows_a, cols_a);

    printf("Matrix B:\n");
    print_matrix(b, cols_a, cols_b);

    matmul_naive(a, b, ans, rows_a, cols_a, cols_b);

    matmul(a, b, c, rows_a, cols_a, cols_b);

    printf("Matrix C:\n");
    print_matrix(c, rows_a, cols_b);

    printf("Matrix Ans:\n");
    print_matrix(ans, rows_a, cols_b);

    for (int i = 0; i < rows_a * cols_b; i++) {
        if (c[i] != ans[i]) {
            printf("Test failed\n");
            printf("Matrix A:\n");
            print_matrix(a, rows_a, cols_a);

            printf("Matrix B:\n");
            print_matrix(b, cols_a, cols_b);

            printf("c[%d] = %d, ans[%d] = %d\n", i, c[i], i, ans[i]);
            printf("Matrix C:\n");
            print_matrix(c, rows_a, cols_b);
            printf("Matrix Ans:\n");
            print_matrix(ans, rows_a, cols_b);
            return;
        }
    }

    printf("Test passed\n");
}

int main() {
    // testing_fully();

    testing_once(100, 20, 123);

    return 0;
}
