#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "klee/klee.h"

void fuzzMe(int a , int b , char * c) {
    printf("%d,%d,%s", a, b, c) ;
    if (a >= 20000) {
        if (b >= 10000000) {
            if (b - a < 200) {
                free(c) ;
                char *s = (char *) malloc(strlen( "some random text") + 1);
                strcpy(s, "some random text");
                printf("%s", s);
            } else {
                if (strlen(c) < 7) {
                    char *s = (char *) malloc(1) ;
                    strcpy(s, "some random text");
                    printf("%s" , s);
                }
            }
        }
    }
}

#define SIZE 100

int main() {
    int a, b;
    char c[SIZE];

    klee_make_symbolic(&a, sizeof(a), "a");
    klee_make_symbolic(&b, sizeof(b), "b");
    klee_make_symbolic(&c, sizeof(c), "c");
    c[SIZE - 1] = '\0';

    fuzzMe(a, b, c);

    return 0;
}
