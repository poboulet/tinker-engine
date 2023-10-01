#pragma once

#include "window.hpp"

namespace Engine
{
    struct WindowDimensions
    {
        int width;
        int height;
    };

    class GLFWWindow : public Window
    {
       public:
        GLFWWindow(WindowDimensions dimensions, const char* title);
        ~GLFWWindow() override;

       private:
        WindowDimensions dimensions_;
        const char* title_;
    };

}  // namespace Engine