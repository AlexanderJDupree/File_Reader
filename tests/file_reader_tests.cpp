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

// TODO write a script to generate files of different sizes and have premake 
// build those files before running tests
const char* TEST_FILE = "/home/chaos2022/CFile_Reader/tests/test.txt";
const char* EMPTY_FILE = "/home/chaos2022/CFile_Reader/tests/empty.txt";

long long get_seed()
{
    return std::chrono::high_resolution_clock::now().time_since_epoch().count();
}

template <typename T>
T any_val(long min, long max)
{
    std::mt19937 generator(get_seed());
    std::uniform_int_distribution<T> u_dist(min, max);
    return u_dist(generator);
}

char* any_string(int length)
{
    // Generates random string
    char* string = new char[length + 1];
    for (int i = 0; i < length; ++i)
    {
        string[i] = any_val<char>(1, CHAR_MAX);
    }
    string[length] = '\0';
    return string;
}

const char* open_write_file(const char* file, int bytes)
{
    std::ofstream file_stream(file);
    REQUIRE(file_stream.is_open());

    if(bytes > 0)
    {
        const char* string = any_string(bytes);
        file_stream << string;
        file_stream.close();
        return string;
    }
    return NULL;
}

TEST_CASE("Determining a file size in bytes")
{
    SECTION("test.txt size")
    {
        unsigned int bytes = any_val<unsigned int>(1, 1024);
        const char* file_contents = open_write_file(TEST_FILE, bytes);
        File_Reader reader = open_file(TEST_FILE);

        REQUIRE(reader.contents != NULL);
        REQUIRE(reader.size == bytes);

        close_reader(&reader);
        delete [] file_contents;
    }
    SECTION("empty_file")
    {
        open_write_file(EMPTY_FILE, 0);

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
        unsigned int bytes = any_val<unsigned int>(1, 1024);
        const char* file_contents = open_write_file(TEST_FILE, bytes);
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
        open_write_file(EMPTY_FILE, 0);
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

