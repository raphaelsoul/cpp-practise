find_package(Protobuf REQUIRED)
find_program(PROTOBUF_PROTOC_EXECUTABLE protoc)

find_package(grpc REQUIRED)
find_program(GRPC_CPP_PLUGIN_EXECUTABLE grpc_cpp_plugin)

file(GLOB_RECURSE PROTO_DEF ${CMAKE_SOURCE_DIR}/proto/*.proto)
set(PROTO_SRCS "")
set(PROTO_HDRS "")

set(GRPC_SRCS "")
set(GRPC_HDRS "")

foreach (msg ${PROTO_DEF})
    get_filename_component(FILE_WE ${msg} NAME_WE)

    list(APPEND PROTO_SRCS "${CMAKE_BINARY_DIR}/proto/${FILE_WE}.pb.cc")
    list(APPEND PROTO_HDRS "${CMAKE_BINARY_DIR}/proto/${FILE_WE}.pb.h")
    list(APPEND GRPC_SRCS "${CMAKE_BINARY_DIR}/proto/${FILE_WE}.grpc.pb.cc")
    list(APPEND GRPC_HDRS "${CMAKE_BINARY_DIR}/proto/${FILE_WE}.grpc.pb.h")
endforeach ()

add_custom_command(
        OUTPUT ${PROTO_SRCS} ${PROTO_HDRS} ${GRPC_SRCS} ${GRPC_HDRS}
        COMMAND ${PROTOBUF_PROTOC_EXECUTABLE}
        ARGS
        --grpc_out ${CMAKE_BINARY_DIR}/proto
        --cpp_out ${CMAKE_BINARY_DIR}/proto
        --plugin=protoc-gen-grpc=${GRPC_CPP_PLUGIN_EXECUTABLE}
        -I ${CMAKE_SOURCE_DIR}/proto
        ${PROTO_DEF}
        DEPENDS ${PROTO_DEF}
        COMMENT "Running protoc on ${PROTO_DEF}"
        VERBATIM
        USES_TERMINAL
)
include_directories(${CMAKE_BINARY_DIR}/proto)