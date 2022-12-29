cmake_minimum_required(VERSION 3.24)
project(streaming)

set(CMAKE_CXX_STANDARD 23)
set(FETCHCONTENT_QUIET FALSE)

include(cmake/message.cmake)

add_executable(server src/server.cpp ${PROTO_SRCS} ${PROTO_HDRS} ${GRPC_SRCS} ${GRPC_HDRS})
find_package(gRPC CONFIG REQUIRED)
target_link_libraries(server PRIVATE gRPC::gpr gRPC::grpc gRPC::grpc++ gRPC::grpc++_alts gRPC::grpc++_reflection)

add_executable(client src/client.cpp ${PROTO_SRCS} ${PROTO_HDRS} ${GRPC_SRCS} ${GRPC_HDRS})
find_package(gRPC CONFIG REQUIRED)
target_link_libraries(client PRIVATE gRPC::gpr gRPC::grpc gRPC::grpc++ gRPC::grpc++_alts gRPC::grpc++_reflection)

add_executable(video_convert src/convert.cpp)
find_package(FFMPEG REQUIRED)
target_include_directories(video_convert PRIVATE ${FFMPEG_INCLUDE_DIRS})
target_link_libraries(video_convert PRIVATE ${FFMPEG_LIBRARIES})