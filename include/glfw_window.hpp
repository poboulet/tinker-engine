#pragma once
#include <glfw/glfw3.h>

#include <cstdint>
#include <limits>
#include <stdexcept>

#include "window.hpp"

namespace core
{
    class GLFWWindowImpl : public Window
    {
       public:
        GLFWWindowImpl();
        ~GLFWWindowImpl() override = default;

       private:
        GLFWwindow* window;
    };
}  // namespace core
