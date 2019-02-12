# File_Reader
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/52406353f564468e9e301645f02127a3)](https://www.codacy.com/app/AlexanderJDupree/File_Reader?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=AlexanderJDupree/File_Reader&amp;utm_campaign=Badge_Grade)

## Introduction

**File_Reader** is a simple file utility written in C. The idea behind File_Reader is to provide a simple/intuitive way to load the contents of a file into memory. As such, the File_Reader utility does not provide much in the way of features at this moment. More features can and will likely be added to this utility as I experience the need for them.

## Getting Started

All releases are header only, meaning all you need to do is download the latest [release here](https://github.com/AlexanderJDupree/File_Reader/releases), place the header into a visible include path, then include the file in your project. 

### Usage 

```c++
#include "file_reader.h"

const char* DEFAULT_FILE = "test.txt";

int main()
{
    File_Reader reader = open_file(DEFAULT_FILE);

    if(reader.contents) 
    {
        printf("File Size: %ld bytes\n", reader.size);
        printf("%s", reader.contents);
    }
    
    close_reader(&reader);

    return 0;
}

```

*Note*: The conditional **'if(reader.contents)'** must be checked before using the reader. If **'open_file()'** fails the reader returned will have its contents pointed to *NULL* and the size attribute set to 0. The **'reader.contents'** attribute will also be *NULL* if the file was empty. It is important to close the reader before the program exits, otherwise there will be a memory leak.

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

