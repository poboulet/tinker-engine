#include "glfw_window.hpp"

#include <GLFW/glfw3.h>

#include <stdexcept>

namespace editor
{
    GLFWWindow::GLFWWindow()
    {
        if (glfwInit() == GLFW_FALSE)
        {
            throw std::runtime_error("Failed to initialize GLFW");
        }

        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
        glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

        window = glfwCreateWindow(WIDTH, HEIGHT, "Tinker", nullptr, nullptr);

        if (window == nullptr)
        {
            glfwTerminate();
            throw std::runtime_error("Failed to create GLFW window");
        }
    }

    GLFWWindow::~GLFWWindow()
    {
        if (window != nullptr)
        {
            glfwDestroyWindow(window);
        }
        glfwTerminate();
    }

    auto GLFWWindow::ShouldClose() -> bool
    {
        return glfwWindowShouldClose(window) == GLFW_TRUE;
    }

    auto GLFWWindow::PollEvents() -> void
    {
        glfwPollEvents();
    }
}  // namespace editor