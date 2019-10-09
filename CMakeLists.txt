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

# Compile shaders
set(GLSL_VALIDATOR "/usr/bin/glslangValidator")

file(GLOB_RECURSE GLSL_SOURCE_FILES
  "shaders/*.frag"
  "shaders/*.vert"
  )

foreach(GLSL ${GLSL_SOURCE_FILES})
  get_filename_component(FILE_NAME ${GLSL} NAME)
  set(SPIRV "${PROJECT_BINARY_DIR}/shaders/${FILE_NAME}.spv")
  add_custom_command(
    OUTPUT ${SPIRV}
    COMMAND ${CMAKE_COMMAND} -E make_directory "${PROJECT_BINARY_DIR}/shaders/"
    COMMAND ${GLSL_VALIDATOR} -V ${GLSL} -o ${SPIRV}
    DEPENDS ${GLSL})
  list(APPEND SPIRV_BINARY_FILES ${SPIRV})
endforeach(GLSL)

add_custom_target(
  Shaders
  DEPENDS ${SPIRV_BINARY_FILES}
  )

add_dependencies(HelloTriangle Shaders)

add_custom_command(TARGET HelloTriangle POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E make_directory "$<TARGET_FILE_DIR:HelloTriangle>/shaders/"
  COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${PROJECT_BINARY_DIR}/shaders"
    "$<TARGET_FILE_DIR:HelloTriangle>/shaders"
    )
