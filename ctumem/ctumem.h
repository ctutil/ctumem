#ifndef CTU_MEM_H
#define CTU_MEM_H

// Changes value only on init
#define CTU_MEM_INIT_ONLY

#define CTU_MEM_MAX_STR_LEN       2000

#define CTU_MEM_RESULT_SUCCESS           0
#define CTU_MEM_RESULT_ERROR            -2
#define CTU_MEM_RESULT_ERROR_CAPACITY   -3

#define CTU_MEM_OFFSET_DONT_FREE_STRS   -1

typedef struct {
    int size CTU_MEM_INIT_ONLY;
    // = CTU_MEM_OFFSET_DONT_FREE_STRS if:
    //   not initialized with the _init fn
    int offset;  
    char **strs;
} ctu_Mem;

extern ctu_Mem *ctu_mem_init (int size);
extern ctu_Mem *ctu_mem_initWithEmptyArray (void);
extern int ctu_mem_add (ctu_Mem *cmem, char *newstr);
extern char **ctu_mem_getArray (ctu_Mem *cmem);
extern int ctu_mem_check (ctu_Mem *cmem);
extern void ctu_mem_free (ctu_Mem *cmem);
extern char *ctu_mem_get (ctu_Mem *cmem, int index);
extern int ctu_mem_getSize (ctu_Mem *cmem);
extern int ctu_mem_getOffset (ctu_Mem *cmem);

#endif
