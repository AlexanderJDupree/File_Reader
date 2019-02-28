/*
 * File: example.cpp
 *
 * Brief: Simple example demonstrating the usage of the File_Reader utility
 *
 * Author: Alexander DuPree
 *
 * Date: 1/30/2019
 *
 */

#include <fstream>
#include <iostream>

extern "C" {
    #include "file_reader.h"
}

const char* TEST_FILE = "/home/chaos2022/CFile_Reader/tests/test.txt";

void open_write_file()
{
    std::ofstream file_stream(TEST_FILE);
    file_stream << "Hello World!" << std::endl;
    file_stream.close();
    return;
}

int main()
{
    open_write_file();

    File_Reader reader = open_file(TEST_FILE);

    if(reader.contents) 
    {
        std::cout << "File Size: " << reader.size << " bytes\n" << reader.contents;
    }
    else
    {
        std::cout << "File: '"  << TEST_FILE << "was not found or was empty\n";
    }
    
    return close_reader(&reader);
}

