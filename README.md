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

This repo utilizes [Premake5](https://github.com/premake/premake-core) to build the necessary project files. Once premake5 is installed just run:

```
premake5 gmake
```

This will generate the GNU makefiles for this project. If you need specific project files run 'premake5 --help' for a list of supported actions. See the [Premake5](https://github.com/premake/premake-core) documentaion for further usage instructions.

If the GNU makefiles suffice, then you can generate a File_Reader static library and unit tests by running:

```
cd gmake && make
```

I've included a postbuild command in premake5.lua that will run the unit tests automatically, however if you want to rerun the tests they are located in bin/tests/.

## Built With

* [Catch2](https://github.com/catchorg/Catch2) - Unit Testing framework used
* [Premake5](https://github.com/premake/premake-core) - Build system

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://raw.githubusercontent.com/AlexanderJDupree/File_Reader/master/LICENSE) file for details

