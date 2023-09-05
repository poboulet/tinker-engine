#include "window.hpp"
#include "stdexcept"

namespace engine
{
Window::Window(int width, int height, std::string windowName) : width(width), height(height), windowName(windowName)
{
    initWindow();
}

Window::~Window()
{
    glfwDestroyWindow(window);
    glfwTerminate();
}

void Window::initWindow()
{
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);  // Don't create an OpenGL context since we're using Vulkan
    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);    // Disable window resizing

    window = glfwCreateWindow(width, height, windowName.c_str(), nullptr, nullptr);
}

bool Window::shouldClose() { return glfwWindowShouldClose(window); }

void Window::createWindowSurface(VkInstance instance, VkSurfaceKHR *surface)
{
    if (glfwCreateWindowSurface(instance, window, nullptr, surface) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create window surface.");
    }
}
};  // namespace engine
