#pragma once

#include "engine_device.hpp"
#include "engine_pipeline.hpp"

#include "window.hpp"
namespace engine {
class EngineApp
{
  public:
    static constexpr int WIDTH = 800;
    static constexpr int HEIGHT = 600;
    void run();

  private:
    Window Window{ WIDTH, HEIGHT, "Hello Vulkan!" };
    EngineDevice engineDevice{ Window };
    EnginePipeline EnginePipeline{ engineDevice,
        "shaders/simple_shader.vert.spv",
        "shaders/simple_shader.frag.spv",
        EnginePipeline::defaultPipelineConfigInfo(WIDTH, HEIGHT) };
};

}// namespace engine
