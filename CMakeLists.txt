set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

cmake_minimum_required(VERSION 3.14)
project(cpp_googletest_cmake_example)

set(CMAKE_CXX_STANDARD 17)

########################################################################################################################
# Dependencies
########################################################################################################################

# googletest
# Download and unpack googletest at configure time
configure_file(extern/CMakeLists.txt.googletest extern/googletest-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/extern/googletest-download)
if (result)
    message(FATAL_ERROR "CMake step for googletest failed: ${result}")
endif ()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/extern/googletest-download)
if (result)
    message(FATAL_ERROR "Build step for googletest failed: ${result}")
endif ()

# Prevent overriding the parent project's compiler/linker
# settings on Windows
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Add googletest directly to our build. This defines
# the gtest and gtest_main targets.
add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/extern/googletest-src
        ${CMAKE_CURRENT_BINARY_DIR}/extern/googletest-build
        EXCLUDE_FROM_ALL)

# The gtest/gtest_main targets carry header search path
# dependencies automatically when using CMake 2.8.11 or
# later. Otherwise we have to add them here ourselves.
if (CMAKE_VERSION VERSION_LESS 2.8.11)
    include_directories("${gtest_SOURCE_DIR}/include")
endif ()

########################################################################################################################

configure_file(extern/CMakeLists.txt.spdlog extern/spdlog-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/extern/spdlog-download)
if (result)
    message(FATAL_ERROR "CMake step for spdlog failed: ${result}")
endif ()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/extern/spdlog-download)
if (result)
    message(FATAL_ERROR "Build step for spdlog failed: ${result}")
endif ()

add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/extern/spdlog-src
        ${CMAKE_CURRENT_BINARY_DIR}/extern/spdlog-build
        EXCLUDE_FROM_ALL)

########################################################################################################################
# Link Tests
########################################################################################################################
add_executable(main_test src/main_test.cpp)
target_link_libraries(main_test gtest_main)
add_test(NAME main_test COMMAND main_test)

########################################################################################################################
# Main exec
########################################################################################################################
add_executable(main src/main.cpp)
target_link_libraries(main spdlog)
