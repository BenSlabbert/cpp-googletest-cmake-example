#include "spdlog/sinks/stdout_color_sinks.h" // or "../stdout_sinks.h" if no colors needed
#include "spdlog/spdlog.h"
#include <proxy/MyClass.h>

int main() {
    SPDLOG_INFO("Hello from spdlog!");

    auto *myClass = new MyClass{};
    int count = myClass->getCount();
    SPDLOG_INFO("Count value: {}", count);
    myClass->setCount(123);
    count = myClass->getCount();
    SPDLOG_INFO("Count value after setting: {}", count);

    delete myClass;
    return 0;
}
