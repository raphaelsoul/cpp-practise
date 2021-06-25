cmake_minimum_required (VERSION 2.8) #最低要求的CMake版本
project(cpp) # 项目名称
file(GLOB SRC_FILE src/*.c src/*.cpp) # 建立变量SRC_FILE为目录下.c文件列表