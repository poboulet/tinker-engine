cmake_minimum_required(VERSION 3.10)

project(VulkanApp)

# Use C++20 standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Find the Vulkan library and headers
find_package(Vulkan REQUIRED)

# Find GLFW library
find_package(glfw3 3.3 REQUIRED)

# Add your source files here
set(SOURCES 
    ./src/main.cpp
)

add_executable(${PROJECT_NAME} ${SOURCES})

# Link Vulkan and GLFW libraries
target_link_libraries(${PROJECT_NAME} Vulkan::Vulkan glfw)
