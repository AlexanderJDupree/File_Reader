/*
 * File: file_reader_tests.cpp
 *
 * Brief: Unit tests for File_Reader utility
 *
 * Author: Alexander DuPree
 *
 * Date: 30JAN2019
 *
 */

#define UNIT_TESTS 1

#include <string.h>
#include <catch.hpp>

#define TEST_FILE "tests/test.txt"
#define EMPTY_FILE "tests/empty.txt"

extern "C" {
    #include "file_reader.h"
}

TEST_CASE("Determining a file size in bytes")
{
    struct File_Reader* reader = open_file(TEST_FILE);
    struct File_Reader* empty_file = open_file(EMPTY_FILE);

    SECTION("test.txt size")
    {
        REQUIRE(file_size(reader->file) == 22);
    }
    SECTION("Invalid file")
    {
        REQUIRE(file_size(NULL) == -1);
    }
    SECTION("empty_file")
    {
        REQUIRE(file_size(empty_file->file) == 0);
    }
    close_reader(reader);
    close_reader(empty_file);
}

TEST_CASE("Reading a file into a char buffer")
{
    struct File_Reader* reader = open_file(TEST_FILE);
    struct File_Reader* invalid_file = open_file("not a file");

    SECTION("Read a valid file")
    {
        const char* test_contents = "Hello World\nI am Alex\n";

        REQUIRE(strcmp(reader->contents, test_contents)== 0);
    }
    SECTION("Read invalid file")
    {
        REQUIRE(read_file(invalid_file) == NULL);
    }
    close_reader(reader);
    // Pointer for invalid_file never gets allocated. thus close_reader isn't needed
}

