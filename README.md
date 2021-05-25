# put-CAwLLP-asm
3rd project for the Computer Architecture with Low-Level Programming at the Poznań University of Technology - writing small programs using x86 assembly

# Project specification

## 3.0
- write your own version of `strcpy` function
- it should be equivalent to:
```c
#include <stdio.h>

int main() {
    char input[1024];
    char output[1024];

    scanf("%s", input);

    char *src = input;
    char *dst = output;
    while ((*dst = *src) != '\0') {
        src++;
        dst++;
    }

    printf("%s\n", output);
    return 0;
}
```

## 3.5
- implement bubble sort in assembly
- it should be equivalent to:
```c
#include <stdio.h>

int main() {
    int array[100];
    int n = 0;

    while (scanf("%d", &array[n]) == 1) {
        n++;
    }

    for (int i = 0; i < n; i++) {
        for (int j = n - 1; j > i; j--) {
            if (array[j] < array[j - 1]) {
                int tmp = array[j];
                array[j] = array[j - 1];
                array[j - 1] = tmp;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        printf("%d ", array[i]);
    }

    return 0;
}
```

## 4.0
- write a program which will calculate the square root of a sequence of numbers with step 0.125
- it should be equivalent to (but without `sqrt()` function):
```c
#include <math.h>
#include <stdio.h>

int main() {
    double end;
    scanf("%lf", &end);

    for (double d = 0.0; d < end; d += 0.125) {
        printf("sqrt(%f) = %f\n", d, sqrt(d));
    }
    return 0;
}
```

## 4.5
- write a program which will approximate e<sup>x</sup> using the Maclaurin series with first k components
- it should be equivalent to:
```c
#include <stdio.h>

int main() {
    int k;
    double x;
    scanf("%i %lf", &k, &x);

    double series = 1;
    double numerator = 1;
    double denominator = 1;

    for (int i = 1; i <= k; i++) {
        numerator *= x;
        denominator *= i;
        series += numerator / denominator;
    }

    printf("e^x = %f\n", series);
    return 0;
}
```

## 5.0
- create the same variant as for 4.5, but make use of SIMD (Single Instruction Multiple Data) capabilities of SSE instructions
- you can do it in one of two ways:
 - compute several steps of the loop at once
 - compute several, separate values at once (e.g. e<sup>x</sup> and e<sup>x+1</sup> simultaneously)
