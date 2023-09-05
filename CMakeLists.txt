cmake_minimum_required(VERSION 3.10)

project(TinkerEngine)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Use C++20 standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if (DEFINED VULKAN_SDK_PATH)
  set(Vulkan_INCLUDE_DIRS "${VULKAN_SDK_PATH}/Include") # 1.1 Make sure this include path is correct
  set(Vulkan_LIBRARIES "${VULKAN_SDK_PATH}/Lib") # 1.2 Make sure lib path is correct
  set(Vulkan_FOUND "True")
else()
  find_package(Vulkan REQUIRED) # throws error if could not find Vulkan
  message(STATUS "Found Vulkan: $ENV{VULKAN_SDK}")
endif()
if (NOT Vulkan_FOUND)
	message(FATAL_ERROR "Could not find Vulkan library!")
else()
	message(STATUS "Using vulkan lib at: ${Vulkan_LIBRARIES}")
endif()

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


