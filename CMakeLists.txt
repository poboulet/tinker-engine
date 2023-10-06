cmake_minimum_required(VERSION 3.10)
cmake_policy(SET CMP0091 NEW)

# Avoid custom variables in the arguments of project commands
project(TinkerEngine)

# Compiler settings
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Define project properties globally, instead of using CMAKE_CXX_FLAGS directly
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall") # for instance, to enable all warnings


# Find Vulkan libraries
if(DEFINED VULKAN_SDK_PATH)
    set(Vulkan_INCLUDE_DIRS "${VULKAN_SDK_PATH}/Include") 
    set(Vulkan_LIBRARIES "${VULKAN_SDK_PATH}/Lib")
    set(Vulkan_FOUND TRUE)
else()
    find_package(Vulkan REQUIRED)
    message(STATUS "Found Vulkan: $ENV{VULKAN_SDK}")
endif()

if(NOT Vulkan_FOUND)
    message(FATAL_ERROR "Could not find Vulkan library!")
else()
    message(STATUS "Using Vulkan lib at: ${Vulkan_LIBRARIES}")
endif()

find_package(glfw3 REQUIRED)

# Link libraries
add_library(project_libs INTERFACE)
target_link_libraries(project_libs INTERFACE Vulkan::Vulkan glfw)

# Lint target
add_custom_target(lint
    COMMAND ./scripts/lint.sh -p ${CMAKE_BINARY_DIR}
    COMMENT "Running lint script..."
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

# Tests
enable_testing()

if(COVERAGE)
    # Define where the raw and processed coverage data will be stored
    set(COVERAGE_DATA_RAW "${CMAKE_BINARY_DIR}/coverage/default.profraw")
    set(COVERAGE_DATA_PROCESSED "${CMAKE_BINARY_DIR}/coverage/default.profdata")

    # Define a custom target to generate the coverage report
    add_custom_target(coverage_report
        COMMAND llvm-profdata merge -sparse ${COVERAGE_DATA_RAW} -o ${COVERAGE_DATA_PROCESSED}
        COMMAND llvm-cov show ${PROJECT_NAME} -instr-profile=${COVERAGE_DATA_PROCESSED} -show-line-counts-or-regions -output-dir=${CMAKE_BINARY_DIR}/coverage/
        DEPENDS test # Assuming 'test' is the target that runs your tests. Adjust if needed.
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating coverage report..."
    )
endif()


add_subdirectory(core)
add_subdirectory(editor)

# Run cmake with -DBUILD_TESTS=ON to build tests
if(BUILD_TESTS)
    include(CTest)
    add_subdirectory(test)
endif()
