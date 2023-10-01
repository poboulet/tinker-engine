set(SOURCES 
    ./render/glfw_window.test.cpp
)

find_package(GTest REQUIRED)
include(GoogleTest)
add_executable(${PROJECT_NAME}.test ${SOURCES}) 

target_link_libraries(${PROJECT_NAME}.test PRIVATE project_libs GTest::GTest GTest::Main GTest::gmock_main)
target_include_directories(${PROJECT_NAME}.test
    PRIVATE 
        ${CMAKE_SOURCE_DIR}/include
        ${CMAKE_SOURCE_DIR}/include/render
)

gtest_discover_tests(${PROJECT_NAME}.test)
