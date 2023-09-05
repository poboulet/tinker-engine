#pragma once

#include <string>
#include <vector>

#include "engine_device.hpp"
#include "file_reader.hpp"

namespace engine {
struct PipelineConfigInfo
{
};

class EnginePipeline
{
  public:
    EnginePipeline(EngineDevice &device,
      const std::string vertFilePath,
      const std::string fragFilePath,
      const PipelineConfigInfo &configInfo);
    ~EnginePipeline();

    EnginePipeline(const EnginePipeline &) = delete;
    void operator=(const EnginePipeline &) = delete;

    static PipelineConfigInfo defaultPipelineConfigInfo(uint32_t width, uint32_t height);

  private:
    void createGraphicsPipeline(const std::string vertFilePath,
      const std::string fragFilePath,
      const PipelineConfigInfo &configInfo);

    void createShaderModule(const std::vector<char> &code, VkShaderModule *shaderModule);


    EngineDevice &engineDevice;
    VkPipeline graphicsPipeline;
    VkShaderModule vertShaderModule;
    VkShaderModule fragShaderModule;
};

}// namespace engine
