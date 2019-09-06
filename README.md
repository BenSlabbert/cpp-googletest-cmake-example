# CPP Googletest + spdlog cmake example

This is an example of including 2 external CMake projects ([googletest](https://github.com/google/googletest.git) and [spdlog](https://github.com/gabime/spdlog.git)).

CMake will clone these repos and checkout the specified tags.

Additionally this also shows how to create your own static library to be used in the project.

See the [proxy](./proxy) `dir`, this is where we set up all the code to be used as a library in the [main](./cmd/main.cpp) program where we can now `#include <proxy/MyClass.h>` our classes.

We also have a example of using `gcov` as a custom target to run after all our tests.

As always (as there should be) check out the [Dockerfile](./Dockerfile) to see how to build this project.

## Requirements

Must have cmake > 3.15

## Build

Run `cmake .` which will clone all the dependencies and build the project.

Subsequently you can run `make`.

## Output

In the `cmd/bin` dir there will be 2 binaries: `main` and `main_test`
