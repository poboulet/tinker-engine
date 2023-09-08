#include "file_reader.hpp"

#include <fstream>
#include <iostream>
#include <stdexcept>

namespace engine
{

    auto DefaultFileReader::open(const std::string &filepath) -> std::ifstream
    {
        std::ifstream file = std::ifstream();
        file.open(filepath, std::ios::ate | std::ios::binary);

        if (!file.is_open())
        {
            throw std::runtime_error("Failed to open file: " + filepath);
        }
        return file;
    }

    auto DefaultFileReader::getFileSize(std::ifstream &file) -> std::streamsize
    {
        std::streamsize const fileSize = file.tellg();

        // Note: If the file is extremely large, fileSize could potentially be negative
        // because the file's size exceeds the maximum value representable by streamsize.
        if (fileSize <= 0)
        {
            throw std::runtime_error("File size is invalid");
        }

        return fileSize;
    }

    auto DefaultFileReader::readAsBuffer(std::ifstream &file) -> std::vector<char>
    {
        std::streamsize const fileSize = getFileSize(file);
        std::vector<char> buffer(fileSize);

        file.seekg(0);
        file.read(buffer.data(), fileSize);
        return buffer;
    }

    auto DefaultFileReader::readFile(const std::string &filepath) -> std::vector<char>
    {
        auto file = open(filepath);
        auto buffer = readAsBuffer(file);
        file.close();

        return buffer;
    }

}  // namespace engine
