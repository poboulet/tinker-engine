#pragma once

#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <string>

namespace engine
{
    class Window
    {
    public:
        Window(int width, int height, std::string windowName);
        ~Window();

        Window(const Window &) = delete;
        Window &operator=(const Window &) = delete;

        bool shouldClose();
        void createWindowSurface(VkInstance instance, VkSurfaceKHR *surface);

    private:
        void initWindow();
        const int width;
        const int height;
        std::string windowName;
        GLFWwindow *window;
    };
}
