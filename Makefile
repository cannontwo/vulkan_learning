VULKAN_SDK_PATH = /home/cannon/Documents/vulkan-1.1.114.0/x86_64
CFLAGS = -std=c++17 -I$(VULKAN_SDK_PATH)/include -Wall -Wextra
LDFLAGS = -L$(VULKAN_SDK_PATH)/lib `pkg-config --static --libs glfw3` -lvulkan

.PHONY: test clean

HelloTriangle: main.cpp
	g++ $(CFLAGS) -o HelloTriangle main.cpp $(LDFLAGS)

test: HelloTriangle
	LD_LIBRARY_PATH=$(VULKAN_SDK_PATH)/lib VK_LAYER_PATH=$(VULKAN_SDK_PATH)/etc/vulkan/explicit_layer.d ./HelloTriangle

clean:
	rm -f HelloTriangle
