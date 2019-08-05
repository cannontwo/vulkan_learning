cmake_minimum_required(VERSION 3.5)
project(vulkan_learning)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ./bin)
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

add_executable(HelloTriangle main.cpp)

find_package(Vulkan REQUIRED)
target_include_directories(HelloTriangle PUBLIC ${VULKAN_INCLUDE_DIRS})
target_link_libraries(HelloTriangle Vulkan::Vulkan)

find_package(GLM REQUIRED)
include_directories(${GLM_INCLUDE_DIRS})
target_link_libraries(HelloTriangle ${GLM_LIBRARY_DIRS})

find_package(glfw3 3.2 REQUIRED)
include_directories(${GLFW_INCLUDE_DIRS})
target_link_libraries(HelloTriangle glfw)
