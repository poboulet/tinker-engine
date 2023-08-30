cmake_minimum_required(VERSION 3.10)
cmake_policy(SET CMP0091 NEW)

project(TinkerEngine)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
find_package(VulkanHeaders CONFIG REQUIRED)

add_library(project_libs INTERFACE)
target_link_libraries(project_libs INTERFACE Vulkan::Headers)
enable_testing()

if(COVERAGE)
    set(COVERAGE_DATA_RAW "${CMAKE_BINARY_DIR}/coverage/default.profraw")
    set(COVERAGE_DATA_PROCESSED "${CMAKE_BINARY_DIR}/coverage/default.profdata")

    add_custom_target(coverage_report
        COMMAND llvm-profdata merge -sparse ${COVERAGE_DATA_RAW} -o ${COVERAGE_DATA_PROCESSED}
        COMMAND llvm-cov show ${PROJECT_NAME} -instr-profile=${COVERAGE_DATA_PROCESSED} -show-line-counts-or-regions -output-dir=${CMAKE_BINARY_DIR}/coverage/
        DEPENDS test
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating coverage report..."
    )
endif()


add_subdirectory(rendering)
add_subdirectory(editor)

if(BUILD_TESTS)
    include(CTest)
    add_subdirectory(test)
endif()
