#include "engine_pipeline.hpp"
#include "engine_device.hpp"

#include <fstream>
#include <iostream>
#include <stdexcept>

namespace engine {

EnginePipeline::EnginePipeline(EngineDevice &device,
  const std::string vertFilePath,
  const std::string fragFilePath,
  const PipelineConfigInfo &configInfo)
  : engineDevice{ device }
{
    createGraphicsPipeline(vertFilePath, fragFilePath, configInfo);
}

EnginePipeline::~EnginePipeline()
{
    vkDestroyShaderModule(engineDevice.device(), vertShaderModule, nullptr);
    vkDestroyShaderModule(engineDevice.device(), fragShaderModule, nullptr);
    vkDestroyPipeline(engineDevice.device(), graphicsPipeline, nullptr);
}

void EnginePipeline::createGraphicsPipeline(const std::string vertFilePath,
  const std::string fragFilePath,
  const PipelineConfigInfo &configInfo)
{
    auto vertShaderCode = FileReader::readFile(vertFilePath);
    auto fragShaderCode = FileReader::readFile(fragFilePath);

    std::cout << "Vertex shader size: " << vertShaderCode.size() << std::endl;
    std::cout << "Fragment shader size: " << fragShaderCode.size() << std::endl;
}


void EnginePipeline::createShaderModule(const std::vector<char> &code, VkShaderModule *shaderModule)
{
    VkShaderModuleCreateInfo createInfo{};
    createInfo.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
    createInfo.codeSize = code.size();

    // The data is uint32_t, so we need to cast it to char
    createInfo.pCode = reinterpret_cast<const uint32_t *>(code.data());

    if (vkCreateShaderModule(engineDevice.device(), &createInfo, nullptr, shaderModule) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create shader module.");
    }
}

PipelineConfigInfo EnginePipeline::defaultPipelineConfigInfo(uint32_t width, uint32_t height)
{
    PipelineConfigInfo configInfo{};
    return configInfo;
}
}// namespace engine
