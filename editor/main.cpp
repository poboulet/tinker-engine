#include <iostream>

#include "glfw_window.hpp"

auto main() -> int
{
    editor::GLFWWindow window;

    while (!window.ShouldClose())
    {
        window.PollEvents();
    }

    return 0;
}
