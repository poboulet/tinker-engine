#pragma once

#include "window.hpp"
#include "engine_pipeline.hpp"

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
        EnginePipeline EnginePipeline{"shaders/simple_shader.vert.spv", "shaders/simple_shader.frag.spv"};
    };

}
