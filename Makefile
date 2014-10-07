# `pkg-config --cflags cudart-6.5`
INCLUDES = -I/usr/local/cuda-6.5/include
# `pkg-config --libs-only-L cudart-6.5`
LIBS = -L/usr/local/cuda-6.5/lib64 -lcudart

CC = g++ -std=c++11 -march=native
CFLAGS = -Wall -pedantic -Ofast
LDFLAGS = -lcuda -lcudart_static -lpthread -ldl -lrt $(LIBS)

NVCC = /usr/local/cuda/bin/nvcc
NVCFLAGS = -cudart=static $(INCLUDES)

all: test

%.o: %.c
	$(CC) -c $< $(CFLAGS) -o $@

%.o: %.cu
	$(NVCC) -c $< $(NVCFLAGS) -o $@

test: main.o
	$(CC) $^ $(LDFLAGS) -o $@

clean:
	rm -f *.o test
