/*
 * File: file_reader_streams.c
 *
 * Author: Alexander DuPree
 *
 * https://github.com/AlexanderJDupree/File_Reader
 */

#include <stdlib.h>
#include <sys/stat.h>
#include "file_reader.h"

extern size_t get_size(FILE* file);
extern int is_file(const char* file_path);

static const char* load_file_contents(FILE* file, size_t size)
{
    char* contents = NULL;
    if(file && size > 0)
    {
        contents = (char*) malloc((size + 1) * sizeof(char));

        // grab character from stream, store it into contents. Ensure it isn't
        // EOF char and ensure we don't write past the buffer size
        size_t i = 0;
        while( i < size && (*(contents + i++) = fgetc(file)) != EOF)

        *(contents + i) = '\0'; // Add null terminator to the end of string
    }
    return contents;
}

File_Reader open_file(const char* file_path)
{
    size_t size = 0;
    const char* contents = NULL;
    FILE* file = (is_file(file_path)) ? fopen(file_path, "r") : NULL;

    if(file)  // if fopen was successfull, parse the file
    {
        size = get_size(file);

        contents = load_file_contents(file, size);

        fclose(file);
    }
    File_Reader reader = { .size = size, .contents = contents };
    return reader;
}

int close_reader(File_Reader* reader)
{
    if(reader)
    {
        free((char*)reader->contents);
        reader->contents = NULL;
        reader->size = 0;
    }
    return 0;
}

