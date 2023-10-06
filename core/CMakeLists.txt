set(TINKERENGINE_CORE_SOURCES 
    engine_app.cpp
)

add_library(TinkerEngine STATIC ${TINKERENGINE_CORE_SOURCES})

if(COVERAGE)
    target_compile_options(TinkerEngine PRIVATE -fprofile-instr-generate -fcoverage-mapping)
    target_link_libraries(TinkerEngine PRIVATE -fprofile-instr-generate)
endif()

target_link_libraries(TinkerEngine PUBLIC project_libs) 
target_include_directories(TinkerEngine
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
)

install(TARGETS TinkerEngine
        ARCHIVE DESTINATION lib)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/include/
        DESTINATION include)