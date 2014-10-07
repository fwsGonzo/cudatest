CC = g++ -std=c++11 -march=native
CFLAGS = -Wall -pedantic -Ofast
LDFLAGS = -lcuda -lcudart_static -lpthread -ldl -lrt `pkg-config --libs-only-L cudart-6.5`

NVCC = /usr/local/cuda/bin/nvcc
NVCFLAGS = -cudart=static `pkg-config --cflags cudart-6.5`

all: test

%.o: %.c
	$(CC) -c $< $(CFLAGS) -o $@

%.o: %.cu
	$(NVCC) -c $< $(NVCFLAGS) -o $@

test: main.o
	$(CC) $^ $(LDFLAGS) -o $@

clean:
	rm -f *.o test
