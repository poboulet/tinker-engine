#include "engine_pipeline.hpp"

#include <fstream>
#include <stdexcept>
#include <iostream>

namespace engine
{
    EnginePipeline::EnginePipeline(const std::string vertFilePath, const std::string fragFilePath)
    {
        createGraphicsPipeline(vertFilePath, fragFilePath);
    }

    void EnginePipeline::createGraphicsPipeline(const std::string vertFilePath, const std::string fragFilePath)
    {
        auto vertShaderCode = FileReader::readFile(vertFilePath);
        auto fragShaderCode = FileReader::readFile(fragFilePath);

        std::cout << "Vertex shader size: " << vertShaderCode.size() << std::endl;
        std::cout << "Fragment shader size: " << fragShaderCode.size() << std::endl;
    }
}