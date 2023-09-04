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
        bool shouldClose();

        Window(const Window &) = delete;
        Window &operator=(const Window &) = delete;

    private:
        void
        initWindow();
        const int width;
        const int height;
        std::string windowName;
        GLFWwindow *window;
    };
}
