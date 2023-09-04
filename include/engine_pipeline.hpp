#pragma once

#include "file_reader.hpp"
#include <string>
#include <vector>

namespace engine
{
    class EnginePipeline
    {
    public:
        EnginePipeline(const std::string vertFilePath, const std::string fragFilePath);

    private:
        void createGraphicsPipeline(const std::string vertFilePath, const std::string fragFilePath);
    };

}