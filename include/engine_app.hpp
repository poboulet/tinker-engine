#pragma once

#include "glfw_window.hpp"
namespace core
{
    class EngineApp
    {
       public:
        void run();

       private:
        void initVulkan();
        void mainLoop();
        void cleanup();
        Window window = GLFWWindowImpl();
    };

}  // namespace core
