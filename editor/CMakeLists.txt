set(TINKERENGINE_EDITOR_SOURCES 
    main.cpp
)

add_executable(${PROJECT_NAME}.Editor ${TINKERENGINE_EDITOR_SOURCES}) 

if(COVERAGE)
    target_compile_options(TinkerEngine.Editor PRIVATE -fprofile-instr-generate -fcoverage-mapping)
    target_link_libraries(TinkerEngine.Editor PRIVATE -fprofile-instr-generate)
endif()

target_link_libraries(TinkerEngine.Editor PUBLIC project_libs) 
target_include_directories(TinkerEngine.Editor
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
)

install(TARGETS TinkerEngine.Editor
        RUNTIME DESTINATION editor/bin)
