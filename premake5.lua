-- File: premake5.lua

-- Brief: Build script for the premake build system. Run 'premake5 gmake' to 
--        build GNU specific makefiles. 

-- Author: Alexander DuPree

-- WORKSPACE CONFIGURATION --
workspace "File_Reader"
    configurations { "Debug", "Release" }
    platforms { "POSIX_x64", "Win64" }

    local project_action = "UNDEFINED"
    if _ACTION ~= nill then project_action = _ACTION end

    location (project_action)
    -- Remove -- to put gmake files at top directory
    -- filter "action:gmake*" 
     --   location "."

    -- PLATFORM CONFIGURATIONS --
    
    filter { "platforms:Win64" }
        system "Windows"
        architecture "x64"

    -- COMPILER/LINKER CONFIG --
    flags "FatalWarnings"
    warnings "Extra"

    filter "configurations:Debug*" defines   { "DEBUG" } symbols "On"
    filter "configurations:Release*" defines { "NDEBUG" } optimize "On"

    filter "toolset:gcc"
        buildoptions { 
            "-Wall", "-Wextra", "-Werror"
        }

    filter {} -- close filter

project "FileReader"
    kind "StaticLib"
    language "C"
    targetdir "bin/%{cfg.buildcfg}/%{cfg.platform}"
    targetname "FileReader"

    local source = "src/"
    local include = "include/"

    files { source .. "file_reader.c" }

    includedirs (include)

project "Tests"
    kind "ConsoleApp"
    links "FileReader"
    language "C++"
    targetdir "bin/tests/"
    targetname "test_%{cfg.shortname}"

    local include  = "include/"
    local test_src = "tests/"
    local test_inc = "third_party/"

    files { 
        test_src .. "**.cpp",
    }

    includedirs { test_inc, include }

    filter { "action:gmake or action:gmake2" }
        buildoptions "-std=c++11"
        postbuildcommands ".././bin/tests/test_%{cfg.shortname}"

    filter {}

project "Example"
    kind "ConsoleApp"
    links "FileReader"
    language "C++"
    targetdir "bin/exampleApp/"
    targetname "example"

    local source = "src/"
    local include = "include/"

    files (source .. "example.cpp")
    includedirs (include)

