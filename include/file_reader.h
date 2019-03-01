/*
 * File: file_reader.h
 *
 * Brief: Simple file reader utility that provides an easy and intuitive way to 
 *        load a file's contents into memory. 
 *
 * LICENSE: MIT
 *
 * Author: Alexander DuPree
 *
 * https://github.com/AlexanderJDupree/File_Reader
 */

#ifndef FILE_READER_H
#define FILE_READER_H

#include <stdio.h>
#include <stddef.h>

typedef struct File_Reader
{
    const char* contents;
    size_t size;
} File_Reader;

int is_file(const char* file_path);

File_Reader open_file(const char* file_path);

int close_reader(File_Reader* reader);

// Uses file stream and fseek to determine file size
size_t get_size(FILE* file);

#endif

