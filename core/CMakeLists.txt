# core/CMakeLists.txt

# Using a more explicit name for the list of core sources
set(TINKERENGINE_CORE_SOURCES 
    glfw_window.cpp
    engine_app.cpp
    # Add any other classes you want to include in the core library here
)

# Create a static library with core sources
add_library(core_lib STATIC ${TINKERENGINE_CORE_SOURCES})


if(COVERAGE)
    target_compile_options(core_lib PRIVATE -fprofile-instr-generate -fcoverage-mapping)
    target_link_libraries(core_lib PRIVATE -fprofile-instr-generate)
endif()

# Linking against other libraries and adding include directories to the core_lib target
# With PUBLIC specifier, anything that links to core_lib will also link to project_libs 
# and inherit the include directories
target_link_libraries(core_lib PUBLIC project_libs) # Link against Vulkan, GLFW, etc.

# Specify the include directories for core_lib
# The PUBLIC specifier indicates that these include directories will also be used by 
# any targets that link to core_lib
target_include_directories(core_lib
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include> # Include directories for the build tree
)

# Create the main application executable and link against the core_lib library
add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE core_lib)
