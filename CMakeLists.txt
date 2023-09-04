cmake_minimum_required(VERSION 3.10)

project(TinkerEngine)

# Use C++20 standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(Vulkan REQUIRED)
find_package(glfw3 3.3 REQUIRED)

add_library(project_libs INTERFACE)
target_link_libraries(project_libs INTERFACE Vulkan::Vulkan glfw)

include(CTest)
enable_testing()

# Add the main app and the tests directories
add_subdirectory(src)

# option(BUILD_TESTS "Build the tests" ON)
if(BUILD_TESTS)
    add_subdirectory(test)
endif()


