CC = gcc
QUIET = @
CFLAGS = -Wall -g3 -O0
OFLAGS = -Wall -c
LIB = -lm

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
INCLUDES = -I $(SRC_DIR)
DIRS = $(BIN_DIR) $(OBJ_DIR)
OBJ = $(OBJ_DIR)/main.o $(OBJ_DIR)/extralib.o

.PHONY: all bins objs clean
all: $(DIRS) bins

$(DIRS):
	mkdir $(DIRS)

bins: objs
	$(CC) $(OBJ) $(CFLAGS) -o $(BIN_DIR)/cmpl $(LIB)

objs:
	$(CC) $(OFLAGS) $(SRC_DIR)/extralib.c -o $(OBJ_DIR)/extralib.o $(INCLUDES)
	$(CC) $(OFLAGS) $(SRC_DIR)/main.c -o $(OBJ_DIR)/main.o $(INCLUDES)

clean:
	$(QUIET)rm -rfv $(DIRS)
