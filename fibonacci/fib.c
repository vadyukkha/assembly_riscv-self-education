#include "fib.h"

#include <stdio.h>

int main() {
    int n = 10;
    int result = fib(n);  // Предположим, что fib возвращает значение
    printf("Fibonacci(%d) = %d\n", n, result);
    return 0;
}
