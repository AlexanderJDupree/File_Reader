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

extern "C" {
    #include "file_reader.h"
}

const char* TEST_FILE = "../tests/test.txt";
const char* EMPTY_FILE = "../tests/empty.txt";

TEST_CASE("Determining a file size in bytes")
{
    File_Reader reader = open_file(TEST_FILE);
    File_Reader empty_file = open_file(EMPTY_FILE);

    REQUIRE(reader.contents != NULL);
    REQUIRE(empty_file.contents == NULL);

    SECTION("test.txt size")
    {
        REQUIRE(file_size(reader.file) == 22);
    }
    SECTION("NULL passed in as parameter returns 0")
    {
        REQUIRE(file_size(NULL) == 0);
    }
    SECTION("empty_file")
    {
        REQUIRE(file_size(empty_file.file) == 0);
    }
    close_reader(&reader);
    close_reader(&empty_file);
}

TEST_CASE("Reading a file into a char buffer")
{
    File_Reader reader = open_file(TEST_FILE);
    File_Reader invalid_file = open_file("not a file");
    File_Reader empty_reader = open_file(EMPTY_FILE);
    File_Reader directory = open_file(".");

    SECTION("Read a valid file")
    {
        const char* test_contents = "Hello World\nI am Alex\n";

        REQUIRE(strcmp(reader.contents, test_contents)== 0);
    }
    SECTION("Read invalid file")
    {
        REQUIRE(read_file(&invalid_file) == NULL);
    }
    SECTION("Read empty file")
    {
        REQUIRE(empty_reader.contents == NULL);
    }
    SECTION("Directories do not open file reader")
    {
        REQUIRE(directory.contents == NULL);
        REQUIRE(directory.file == NULL);
    }
    close_reader(&reader);
    close_reader(&empty_reader);
    // Pointer for invalid_file never gets allocated. thus close_reader isn't needed
}

