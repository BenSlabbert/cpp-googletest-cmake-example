########################################################################################################################
# Link Tests
########################################################################################################################
add_executable(main_test main_test.cpp)
target_link_libraries(main_test gtest_main)

# Create OBJECT_DIR variable
set(OBJECT_DIR ${CMAKE_BINARY_DIR}/cmd/CMakeFiles/main_test.dir)
message("-- Object files will be output to: ${OBJECT_DIR}")

# Create the gcov target. Run coverage tests with 'make gcov'
add_custom_target(gcov
        COMMAND mkdir -p coverage
        COMMAND ${CMAKE_MAKE_PROGRAM} test
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
add_custom_command(TARGET gcov
        COMMAND echo "=================== GCOV ===================="
        COMMAND gcov -b ${CMAKE_SOURCE_DIR}/cmd/*.cpp -o ${OBJECT_DIR}
        | grep -A 5 "main_test.cpp" > CoverageSummary.tmp
        COMMAND cat CoverageSummary.tmp
        COMMAND echo "-- Coverage files have been output to ${CMAKE_BINARY_DIR}/coverage"
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/coverage  # Need separate command for this line
        )

# add tests to gcov here
add_dependencies(gcov main_test)
# Make sure to clean up the coverage folder
set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_MAKE_CLEAN_FILES coverage)

# Create the gcov-clean target. This cleans the build as well as generated
# .gcda and .gcno files.
add_custom_target(scrub
        COMMAND ${CMAKE_MAKE_PROGRAM} clean
        COMMAND rm -f ${OBJECT_DIR}/*.gcno
        COMMAND rm -f ${OBJECT_DIR}/*.gcda
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )

# Testing
enable_testing()
add_test(NAME main_test COMMAND main_test)

########################################################################################################################
# Main exec
########################################################################################################################
add_executable(main main.cpp)
target_link_libraries(main PRIVATE proxy spdlog)
