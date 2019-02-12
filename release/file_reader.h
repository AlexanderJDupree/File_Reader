/*
 * File: file_reader.h
 *
 * Brief: Simple file reader utility that provides an easy and intuitive way to 
 *        load a file's contents into memory. 
 *
 * Author: Alexander DuPree
 *
 * https://github.com/AlexanderJDupree/File_Reader
 *
 * Version: v0.1.0-alpha
 */

#ifndef FILE_READER_H
#define FILE_READER_H

#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>

typedef struct
{
    FILE* file;
    size_t size;
    const char* contents;
} File_Reader;

File_Reader open_file(const char* file_name);

void close_reader(File_Reader* reader);

const char* read_file(File_Reader* reader);

size_t file_size(FILE* file);

/*
 * File: file_reader.c
 *
 * Author: Alexander DuPree
 *
 * https://github.com/AlexanderJDupree/File_Reader
 */

File_Reader open_file(const char* file_name)
{
    FILE* file = fopen(file_name, "r");
    File_Reader reader = { .file = file, .size = 0, .contents = NULL };

    if(file)  // if fopen was successfull, parse the file
    {
        reader.size = file_size(file);

        reader.contents = read_file(&reader);
    }
    return reader;
}

void close_reader(File_Reader* reader)
{
    if(reader)
    {
        free((char*)reader->contents);
        reader->contents = NULL;
        if(reader->file)
        {
            fclose(reader->file);
            reader->file = NULL;
        }
        reader->size = 0;
    }
    return;
}

const char* read_file(File_Reader* reader)
{
    char* contents = NULL;
    if(reader && reader->size != 0)
    {
        contents = (char*) malloc((reader->size + 1) * sizeof(char));

        // grab character from stream, store it into contents. Ensure it isn't
        // EOF char and ensure we don't write past the buffer size
        size_t i = 0;
        while( i < reader->size && (*(contents + i++) = fgetc(reader->file)) != EOF)

        *(contents + i) = '\0'; // Add null terminator to the end of string
    }
    return contents;
}

size_t file_size(FILE* file)
{
    size_t size = 0;

    if(file)
    {
        fseek(file, 0L, SEEK_END);

        size = ftell(file);

        fseek(file, 0L, SEEK_SET);
    }
    return size;
}

#endif

