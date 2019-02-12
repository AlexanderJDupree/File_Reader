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

#include "file_reader.h"

const char* DEFAULT_FILE = "tests/test.txt";

int main()
{
    File_Reader reader = open_file(DEFAULT_FILE);

    if(reader.contents) 
    {
        printf("File Size: %ld bytes\n", reader.size);
        printf("%s", reader.contents);
    }
    else
    {
        printf("File: '%s' was not found or was empty\n", DEFAULT_FILE);
    }
    
    close_reader(&reader);

    return 0;
}

