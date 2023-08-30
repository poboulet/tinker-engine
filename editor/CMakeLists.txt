project(TinkerEngine.Editor)

add_executable(TinkerEngine.Editor main.cpp) 

if(COVERAGE)
    target_compile_options(TinkerEngine.Editor PRIVATE -fprofile-instr-generate -fcoverage-mapping)
    target_link_libraries(TinkerEngine.Editor PRIVATE -fprofile-instr-generate)
endif()

target_link_libraries(TinkerEngine.Editor PRIVATE project_libs PRIVATE TinkerEngine.Rendering) 

target_include_directories(TinkerEngine.Editor
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

install(TARGETS TinkerEngine.Editor
        RUNTIME DESTINATION editor/bin)
