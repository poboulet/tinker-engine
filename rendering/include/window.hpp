#pragma once

#include <cstdint>

namespace editor
{
    class Window
    {
       public:
        virtual auto ShouldClose() -> bool = 0;
        virtual auto PollEvents() -> void = 0;

       protected:
        const int WIDTH = 800;
        const int HEIGHT = 600;
    };
};  // namespace editor
