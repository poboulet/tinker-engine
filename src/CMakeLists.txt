# For an application

set(SOURCES 
    ./window.cpp
    ./engine_app.cpp
    ./main.cpp
)
add_executable(${PROJECT_NAME} ${SOURCES})  # List other source files as needed

target_link_libraries(${PROJECT_NAME} project_libs)
target_include_directories(${PROJECT_NAME}
    PRIVATE 
        ${CMAKE_SOURCE_DIR}/include
)
