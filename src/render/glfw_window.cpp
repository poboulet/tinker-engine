#include "glfw_window.hpp"

using Engine::GLFWWindow;

GLFWWindow::GLFWWindow(WindowDimensions dimensions, const char* title)
    : dimensions_(dimensions),
      title_(title),
      window_(nullptr)
{
}

GLFWWindow::GLFWWindow::~GLFWWindow()
{
}
