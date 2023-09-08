cmake_minimum_required(VERSION 3.10)

project(TinkerEngine)

# Compiler settings
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

MESSAGE(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")

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

# Find GLFW
find_package(glfw3 3.3 REQUIRED)

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

add_subdirectory(src)

# Run cmake with -DBUILD_TESTS=ON to build tests
if(BUILD_TESTS)
    include (CTest)
    add_subdirectory(test)
endif()
