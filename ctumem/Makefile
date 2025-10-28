CFLAGS=-std=c11 -D_POSIX_C_SOURCE=200809L -Wall

lib:
	gcc -o ctumem.so $(CFLAGS) -shared -fPIC ctumem.c

test: lib
	gcc -o ctumemTest $(CFLAGS) -g ctumem.so test.c

