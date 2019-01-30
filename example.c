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

#define DEFAULT_FILE "test.txt"

int main()
{
    struct File_Reader* reader = open_file(DEFAULT_FILE);

    if(reader && reader->contents)
    {
        printf("File Size: %d bytes\n", reader->size);
        printf("%s", reader->contents);
    }
    else
    {
        printf("\nFile: '%s' was not found or was empty\n", DEFAULT_FILE);
    }
    close_reader(reader);

    return 0;
}
