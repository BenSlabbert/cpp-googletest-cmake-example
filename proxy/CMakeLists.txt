file(GLOB PROXY_LIB_SRC
        "src/proxy/*.cpp"
        "src/proxy/*.h"
        )

add_library(
        proxy STATIC
        ${PROXY_LIB_SRC}
)

target_include_directories(proxy PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src")

# can set PUBLIC to PRIVATE to not expose this to anyone who links to this lib
# can set INTERFACE to be available to anyone consuming this, not available internal (opposite to PRIVATE)
target_compile_definitions(proxy PUBLIC MY_LIBRARY_VERSION=1)
