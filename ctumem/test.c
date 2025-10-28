#include <stdio.h>
#include "ctumem.h"

int main (void)
{
    ctu_Mem *cmem = ctu_mem_init(3);
    
    ctu_mem_add(cmem, "Hello");
    ctu_mem_add(cmem, "world");
    ctu_mem_add(cmem, NULL);

    printf("%s %s\n", ctu_mem_get(cmem, 0), ctu_mem_get(cmem, 1));
    if (ctu_mem_get(cmem, 2) == NULL) {
        printf("Null element found\n");
    }

    ctu_mem_free(cmem);

    return 0;
}
