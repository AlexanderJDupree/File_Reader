/*
 * File: file_reader_mmap.c
 *
 * Author: Alexander DuPree
 *
 * https://github.com/AlexanderJDupree/File_Reader
 */


#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/types.h>
#include "file_reader.h"

extern size_t get_size(FILE* file);
extern int is_file(const char* file_path);

File_Reader open_file(const char* file_path)
{
    struct stat st;
    char* buffer = NULL;
    int fd = open(file_path, O_RDONLY);

    if(fd != -1 && fstat(fd, &st) == 0 && S_ISREG(st.st_mode))
    {
        buffer = (st.st_size > 0) ? 
            (char*) mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0) : NULL;
        close(fd);
    }

    File_Reader reader = { 
        .contents = (buffer != (void*)-1) ? buffer : NULL, 
        .size = (buffer != NULL) ? (size_t) st.st_size : 0
    };
    return reader;
}

int close_reader(File_Reader* reader)
{
    if(reader && reader->contents)
    {
        void* mapped_memory = (void*) reader->contents;

        reader->contents = NULL;

        return munmap(mapped_memory, reader->size);
    }
    return 0;
}

