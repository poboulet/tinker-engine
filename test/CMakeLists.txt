set(SOURCES 
    ./SampleTest.cpp
)

find_package(GTest REQUIRED)
include(GoogleTest)

add_executable(${PROJECT_NAME}.test ${SOURCES}) 

target_link_libraries(${PROJECT_NAME}.test GTest::GTest GTest::Main)

gtest_add_tests(TARGET ${PROJECT_NAME}.test)