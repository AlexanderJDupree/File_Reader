/*
 * File: file_reader.c
 *
 * LICENSE: MIT
 *
 * Author: Alexander DuPree
 *
 * https://github.com/AlexanderJDupree/File_Reader
 */

#include <stdlib.h>
#include <sys/stat.h>
#include "file_reader.h"

size_t get_size(FILE* file)
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

#if (defined(__unix__) || defined(__unix) || (defined(__APPLE__) && defined(__MACH__)))

#include <unistd.h>

#if defined(_POSIX_MAPPED_FILES)

#include <fcntl.h>
#include <sys/mman.h>
#include <sys/types.h>

int is_file(const char* file_path)
{
	struct stat path_stat;
	return (lstat(file_path, &path_stat) == 0) ? S_ISREG(path_stat.st_mode) : 0;
}

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

#endif // POSIX Compliant
#endif // UNIX Based OS

#if defined( _WIN64) || defined(_WIN32)

int is_file(const char* file_path)
{
	struct _stat path_stat;
	return(_stat(file_path, &path_stat) == 0) ? (_S_IFREG & path_stat.st_mode) > 0 : 0;
}

static const char* load_file_contents(FILE* file, size_t size)
{
    char* contents = NULL;
    if(file && size > 0)
    {
        contents = (char*) malloc((size + 1) * sizeof(char));

        // grab character from stream, store it into contents. Ensure it isn't
        // EOF char and ensure we don't write past the buffer size
        size_t i = 0;
        while( i < size && (*(contents + i++) = (char) fgetc(file)) != EOF)

        *(contents + i) = '\0'; // Add null terminator to the end of string
    }
    return contents;
}

File_Reader open_file(const char* file_path)
{
    size_t size = 0;
    const char* contents = NULL;
	FILE* file = NULL;
    errno_t err = (is_file(file_path)) ? fopen_s(&file, file_path, "r") : 1;

    if(err == 0)  // if fopen was successfull, parse the file
    {
        size = get_size(file);

        contents = load_file_contents(file, size);

        fclose(file);
    }

	File_Reader reader;
	reader.contents = contents;
	reader.size = size;

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

#endif // _WIN64 || _WIN32

