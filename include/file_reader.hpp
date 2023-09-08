#pragma once

#include <fstream>
#include <string>
#include <vector>

namespace engine
{

    class FileReader
    {
       public:
        virtual std::ifstream open(const std::string& filepath) = 0;
        virtual std::vector<char> readFile(const std::string& filepath) = 0;
        virtual ~FileReader() = default;

        FileReader(const FileReader& other) = delete;
        FileReader& operator=(const FileReader& other) = delete;

        FileReader(FileReader&& other) = delete;
        FileReader& operator=(FileReader&& other) = delete;
    };

    class DefaultFileReader : public FileReader
    {
       public:
        std::ifstream open(const std::string& filepath) override;
        std::vector<char> readFile(const std::string& filepath) override;

       private:
        static std::vector<char> readAsBuffer(std::ifstream& file);
        static std::streamsize getFileSize(std::ifstream& file);
    };

}  // namespace engine
