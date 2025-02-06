#include <stdio.h>
#include <stdlib.h>

#define SIZE 200

void generate_sum_prod_arr(int *a, int *b, int *sum_arr, int *prod_arr,
                           int size);  // Declaration of the assembly function

int main() {
    int *a = (int *)malloc(SIZE * sizeof(int));
    int *b = (int *)malloc(SIZE * sizeof(int));

    for (int i = 0; i < SIZE; ++i) {
        a[i] = i * i;
        b[i] = SIZE - i - 1;
    }

    int *sum_arr = (int *)malloc(SIZE * sizeof(int));
    int *prod_arr = (int *)malloc(SIZE * sizeof(int));

    generate_sum_prod_arr(a, b, sum_arr, prod_arr, SIZE);
    for (int i = 0; i < SIZE; ++i) {
        if (sum_arr[i] != a[i] + b[i] || prod_arr[i] != a[i] * b[i]) {
            printf("Test failed\n");
            return 1;
        }
    }
    printf("Test passed\n");
    return 0;
}
