# File: makefile
# Description: Basic makefile for automated builds
# Author: Alexander DuPree

CC := gcc
CFLAGS := -Wall -g
INCLUDE := -I include/

SRC_DIR := src
OBJ_DIR := obj
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

TEST_CC := g++
TEST_FLAGS := $(CFLAGS) -D UNIT_TESTS
TEST_INCLUDE := $(INCLUDE) -I tests/third_party

TEST_DIR := tests
TEST_OBJ_DIR := tests/obj
TEST_OBJ_DIR_C := tests/obj
TEST_SRCS := $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJS := $(patsubst $(TEST_DIR)/%.cpp,$(TEST_OBJ_DIR)/%.o,$(TEST_SRCS))
TEST_OBJS_C := $(patsubst $(SRC_DIR)/%.c,$(TEST_OBJ_DIR)/%.o,$(SRC_FILES))
tests := tests/obj/debug/run_tests

TESTS_MAIN := tests/third_party/tests_main.o
THIRD_PARTY := tests/third_party/tests_main.cpp

tests: $(TESTS_MAIN) $(TEST_OBJS) $(TEST_OBJS_C)
	$(TEST_CC) $(TEST_FLAGS) $(TEST_INCLUDE) -o $(tests) $^

TESTS_MAIN: $(THIRD_PARTY)
	$(CC) $(TEST_FLAGS) $(TEST_INCLUDE) -o $(TESTS_MAIN) -c $(THIRD_PARTY)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $(INCLUDE) -c -o $@ $<

$(TEST_OBJ_DIR)/%.o: $(TEST_DIR)/%.cpp
	$(TEST_CC) $(TEST_FLAGS) $(TEST_INCLUDE) -c -o $@ $<

$(TEST_OBJ_DIR_C)/%.o: $(SRC_DIR)/%.c
	$(CC) $(TEST_FLAGS) $(TEST_INCLUDE) -c -o $@ $<

.PHONEY: clean
.PHONEY: help

clean:
	rm -f  $(TARGET)
	rm -f $(OBJ_DIR)/*.o
	rm -f $(TEST_OBJ_DIR)/*.o
	rm -f $(TESTS_MAIN)

help:
	@echo "Usage:\n\tBuild Unit tests:  make tests\n\tClean obj files:   make clean"
