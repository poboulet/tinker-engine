project(TinkerEngine.Rendering)

add_library(TinkerEngine.Rendering 
    STATIC ./glfw_window.cpp
)

find_package(glfw3 CONFIG REQUIRED)

if(COVERAGE)
    target_compile_options(TinkerEngine.Rendering PRIVATE -fprofile-instr-generate -fcoverage-mapping)
    target_link_libraries(TinkerEngine.Rendering PRIVATE -fprofile-instr-generate)
endif()

target_link_libraries(TinkerEngine.Rendering PUBLIC project_libs PUBLIC glfw) 

target_include_directories(TinkerEngine.Rendering
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

install(TARGETS TinkerEngine.Rendering
        ARCHIVE DESTINATION rendering/lib)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/
        DESTINATION rendering/include)
