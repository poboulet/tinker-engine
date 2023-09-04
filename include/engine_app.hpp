#pragma once

#include "window.hpp"

namespace engine
{
    class EngineApp
    {
    public:
        static constexpr int WIDTH = 800;
        static constexpr int HEIGHT = 600;
        void run();

    private:
        Window Window{WIDTH, HEIGHT, "Hello Vulkan!"};
    };

}
