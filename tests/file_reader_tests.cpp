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

#include <random>
#include <chrono>
#include <fstream>
#include <stdio.h>
#include <climits>
#include <string.h>
#include <catch.hpp>

extern "C" {
    #include "file_reader.h"
}

const char* TEST_FILE = "/home/chaos2022/CFile_Reader/tests/test.txt";
const char* EMPTY_FILE = "/home/chaos2022/CFile_Reader/tests/empty.txt";

long long get_seed()
{
    return std::chrono::high_resolution_clock::now().time_since_epoch().count();
}

char any_char()
{
    std::mt19937 generator(get_seed());
    std::uniform_int_distribution<char> u_dist(1, CHAR_MAX);
    return u_dist(generator);
}

const char* open_write_file(int bytes)
{
    // Opens file
    std::ofstream file_stream(TEST_FILE);
    REQUIRE(file_stream.is_open());

    // Generates random string
    char* string = new char[bytes + 1];
    for (int i = 0; i < bytes; ++i)
    {
        string[i] = any_char();
    }
    string[bytes + 1] = '\0';
    
    // Write and close
    file_stream << string;
    file_stream.close();
    return string;
}

void open_empty_file()
{
    std::fstream empty_file;
    empty_file.open(EMPTY_FILE, std::ios::out);
    REQUIRE(empty_file.is_open());
    empty_file.close();
}

TEST_CASE("Determining a file size in bytes")
{
    SECTION("test.txt size")
    {
        const char* file_contents = open_write_file(22);
        File_Reader reader = open_file(TEST_FILE);

        REQUIRE(reader.contents != NULL);
        REQUIRE(reader.size == 22);

        close_reader(&reader);
        delete [] file_contents;
    }
    SECTION("empty_file")
    {
        open_empty_file();

        File_Reader empty_file = open_file(EMPTY_FILE);

        REQUIRE(empty_file.size == 0);
        REQUIRE(empty_file.contents == NULL);
        close_reader(&empty_file);
    }
}

TEST_CASE("Reading a file into a char buffer")
{
    SECTION("Read a valid file")
    {
        const char* file_contents = open_write_file(22);
        File_Reader reader = open_file(TEST_FILE);

        std::string contents(reader.contents);

        REQUIRE(contents == file_contents);
        close_reader(&reader);
        delete [] file_contents;
    }
    SECTION("Read invalid file")
    {
        File_Reader invalid_file = open_file("not a file");
        REQUIRE(invalid_file.contents == NULL);
    }
    SECTION("Read empty file")
    {
        open_empty_file();
        File_Reader empty_reader = open_file(EMPTY_FILE);

        REQUIRE(empty_reader.contents == NULL);
        close_reader(&empty_reader);
    }
    SECTION("Directories do not open file reader")
    {
        File_Reader directory = open_file(".");
        REQUIRE(directory.contents == NULL);
    }
}

