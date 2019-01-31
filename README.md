# File_Reader

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7ecd9d77bad545f6b10e0dc37a7132c9)](https://app.codacy.com/app/AlexanderJDupree/File_Reader?utm_source=github.com&utm_medium=referral&utm_content=AlexanderJDupree/File_Reader&utm_campaign=Badge_Grade_Dashboard)

## Introduction

**File_Reader** is a simple file utility written in C. The idea behind File_Reader is to provide a simple/intuitive way to load the contents of a file into memory. As such, the File_Reader utility does not provide much in the way of features at this moment. More features can and will likely be added to this utility as I experience the need for them.

## Getting Started

All releases are header only, meaning all you need to do is download the latest [release here](https://github.com/AlexanderJDupree/File_Reader/releases), place the header into a visible include path, then include the file in your project. 

### Usage 

```c++
#include "file_reader.h"

const char* DEFAULT_FILE "path_to_file.txt"

int main()
{
    struct File_Reader* reader = open_file(DEFAULT_FILE);

    if(reader && reader->contents)
    {
        printf("File Size: %ld bytes\n", reader->size);
        printf("%s", reader->contents);
    }
    close_reader(reader);

    return 0;
}
```

*Note*: The conditional **'if(reader && reader->contents)'** must be checked before using the reader. The ordering of the conditional is important as well. **'open_file()'** will return a *NULL* reader if the file open operation failed, and the **'reader->contents'** attribute will be *NULL* if the file was empty. It is also important to close the reader before the program exits, otherwise there will be a memory leak. 

## What's in this Repo?

This repo contains the source files for the file_reader utility, its unit tests, and an example program. To build the example run:

```
make
./example
```
To build and run unit tests:

```
make tests
./tests/obj/debug/run_tests
```
*Note*: running 'make tests' for the first time will take some time as it has to compile the unit testing framework used. 

To remove object files run:

```
make clean
```

## Built With

* [Catch2](https://github.com/catchorg/Catch2) - Unit Testing framework used

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://raw.githubusercontent.com/AlexanderJDupree/File_Reader/master/LICENSE) file for details

