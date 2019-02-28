/*
 * File: example.c
 *
 * Brief: Simple example demonstrating the usage of the File_Reader utility
 *
 * Author: Alexander DuPree
 *
 * Date: 1/30/2019
 *
 */
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <dirent.h>
#include "file_reader.h"

// Note: These defines are for premake to figure out where the test files are
#ifndef TEST_FILE
#define TEST_FILE "./tests/test.txt"
#endif //TEST_FILE

int main()
{
    File_Reader reader = open_file(TEST_FILE);

    if(reader.contents) 
    {
        printf("File Size: %ld bytes\n", reader.size);
        printf("%s", reader.contents);
    }
    else
    {
        printf("File: '%s' was not found or was empty\n", TEST_FILE);
    }
    
    close_reader(&reader);

    return 0;
}

