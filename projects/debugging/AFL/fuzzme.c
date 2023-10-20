#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }

    int a, b;
    char c[100];

    if (fscanf(input_file, "%d %d %[^\n]", &a, &b, c) != 3) {
        fprintf(stderr, "Error reading input from file\n");
        fclose(input_file);
        return 1;
    }

    fclose(input_file);

    fuzzMe(a, b, c);

    return 0;
}
