CC = gcc
CFLAGS = -g3 -O0 -Wall
LIB = -lm
INCLUDES = -I src/
dirs = ./bin ./obj
main_obj = ./obj/main.o ./obj/lib.o ./obj/extralib.o

all: ./bin/main

./bin/main: $(dirs) $(main_obj)
	$(CC) $(CFLAGS) $(main_obj) -o ./bin/cmpl $(LIB)

$(dirs):
	mkdir obj
	mkdir bin

./obj/main.o: ./src/main.c
	$(CC) -c ./src/main.c -Wall -o ./obj/main.o $(INCLUDES)

./obj/lib.o: ./src/lib.c
	$(CC) -c ./src/lib.c -Wall -o ./obj/lib.o $(INCLUDES)

./obj/extralib.o: ./src/extralib.c
	$(CC) -c ./src/extralib.c -Wall -o ./obj/extralib.o $(INCLUDES)

.PHONY: clean exec
clean:
	rm -rf bin/
	rm -rf obj/

exec:
	make
	./bin/cmpl
