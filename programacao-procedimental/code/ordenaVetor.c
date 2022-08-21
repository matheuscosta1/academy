#include <stdio.h>
#include <stdlib.h>

#define TAM 10

int main()
{
    int dados[TAM] = {984, 800, 416, 98, 415, 97, 909, 568, 2, 539, 691, 2, 385, 570, 399, 341, 945, 103, 437, 874,
    866, 260, 205, 393, 315, 364, 220, 942, 933, 600, 899, 104, 253, 22, 207, 144, 255, 579, 419, 168,
    570, 42, 187, 231, 239, 667, 604, 183, 485, 503, 234, 837, 889, 368, 550, 813, 118, 507, 948, 1,
    806, 656, 904, 18, 941, 821, 173, 401, 270, 532, 152, 130, 307, 121, 21, 427, 709, 676, 897, 214,
    330, 346, 104, 61, 385, 338, 855, 898, 458, 64, 153, 274, 884, 79, 321, 93, 535, 867, 537, 340};
    int i, aux, i1;

    // primeiro for = analisando posição por posição e trocar quando um valor for menor
    for (i = 0; i <= TAM - 1; i++) {
        for (i1 = i+1; i1 < TAM; i1++) {
            //troca
            if (dados[i] > dados[i1]) {
                aux = dados[i];
                dados[i] = dados[i1];
                dados[i1] = aux;
            }
        }
        printf("%d ", dados[i]);

    }

    return 0;
}