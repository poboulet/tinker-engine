#pragma once

#include <string>
#include <vector>

namespace engine
{

    class FileReader
    {
    public:
        static std::vector<char> readFile(const std::string &filepath);
    };

}
