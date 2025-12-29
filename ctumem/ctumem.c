#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "ctumem.h"


extern ctu_Mem *ctu_mem_init (int size)
{
    ctu_Mem *cmem = malloc(sizeof(ctu_Mem));

    if (!cmem) {
        return NULL;
    }

    cmem->strs = malloc(sizeof(char*) * size);
    if (!cmem->strs) {
        return NULL;
    }
    
    cmem->size = size;
    cmem->offset = 0;

    return cmem;
}

/**
 * NULL is also accepted
 */
extern int ctu_mem_add (ctu_Mem *cmem, char *newstr)
{
    // add NULL element
    if (newstr == NULL) {
        cmem->strs[cmem->offset] = NULL;
        cmem->offset++;
        return CTU_MEM_RESULT_SUCCESS;
    }

    // add non NULL element
    size_t newstr_len = strnlen(newstr, CTU_MEM_MAX_STR_LEN) + 1;
    char *str = malloc(sizeof(char) * newstr_len);
    if (!str) {
        ctu_mem_free(cmem);
        return CTU_MEM_RESULT_ERROR;
    }

    strncpy(str, newstr, newstr_len);
    cmem->strs[cmem->offset] = str;
    cmem->offset++;

    return CTU_MEM_RESULT_SUCCESS;
}

extern char **ctu_mem_getArray (ctu_Mem *cmem) 
{
    return cmem->strs;
}

/**
 * Checks if all elements are in the array. (full capacity)
 * .
 * At the end ctu_mem_free is to be called, either on success or 
 * on error.
 */
extern int ctu_mem_check (ctu_Mem *cmem)
{
   if (cmem->offset != cmem->size) return CTU_MEM_RESULT_ERROR_CAPACITY;

   return CTU_MEM_RESULT_SUCCESS;
}

extern char *ctu_mem_get (ctu_Mem *cmem, int index)
{
   return cmem->strs[index];
}

extern void ctu_mem_free (ctu_Mem *cmem)
{
    for (int i = 0; i < cmem->offset; i++) {
        if (cmem->strs[i]) {
          free(cmem->strs[i]);
        }
    }

    free(cmem->strs);
    free(cmem);
}

extern int ctu_mem_getSize (ctu_Mem *cmem)
{
    return cmem->size;
}

extern int ctu_mem_getOffset (ctu_Mem *cmem)
{
    return cmem->offset;
}
