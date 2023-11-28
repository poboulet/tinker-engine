#pragma once

#include <GLFW/glfw3.h>

#include <cstdint>

#include "window.hpp"

namespace editor
{
    class GLFWWindow : public Window
    {
       public:
        GLFWWindow();
        ~GLFWWindow();

        GLFWWindow(const GLFWWindow&) = delete;
        auto operator=(const GLFWWindow&) -> GLFWWindow& = delete;

        GLFWWindow(GLFWWindow&&) = delete;
        auto operator=(GLFWWindow&&) -> GLFWWindow& = delete;

        auto ShouldClose() -> bool override;
        auto PollEvents() -> void override;

       private:
        GLFWwindow* window;
    };
}  // namespace editor