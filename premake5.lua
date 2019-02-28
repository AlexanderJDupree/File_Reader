-- File: premake5.lua

-- Brief: Build script for the premake build system. Run 'premake5 gmake' to 
--        build GNU specific makefiles. 

-- Author: Alexander DuPree

-- WORKSPACE CONFIGURATION --
workspace "File_Reader"
    configurations { "Debug", "Release" }

    local project_action = "UNDEFINED"
    if _ACTION ~= nill then project_action = _ACTION end

    location (project_action)
    -- Remove -- to put gmake files at top directory
    -- filter "action:gmake*" 
     --   location "."

    -- PLATFORM CONFIGURATIONS --
    
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

project "File_Reader"
    kind "StaticLib"
    language "C"
    targetdir "bin/%{cfg.buildcfg}"
    targetname "File_Reader"

    local source = "src/"
    local include = "include/"

    files (source .. "file_reader.c")
    includedirs (include)

project "Tests"
    kind "ConsoleApp"
    language "C++"
    links "File_Reader"
    targetdir "bin/tests/"
    targetname "test_%{cfg.shortname}"
    buildoptions "-std=c++11"


    local include  = "include/"
    local test_src = "tests/"
    local test_inc = "third_party/"

    files (test_src .. "**.cpp")

    includedirs { test_inc, include }

    postbuildcommands ".././bin/%{cfg.architecture}/tests/test_%{cfg.shortname}"

project "Example"
    kind "ConsoleApp"
    language "C"
    links "File_Reader"
    targetdir "bin/example/"
    targetname "example"

    local source = "src/"
    local include = "include/"

    files (source .. "example.c")
    includedirs (include)

