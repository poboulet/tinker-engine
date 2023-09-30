#pragma once

namespace core
{
    class Window
    {
       public:
        Window() = default;
        virtual ~Window() = default;

       protected:
        const uint32_t WIDTH = 800;
        const uint32_t HEIGHT = 600;
    };
}  // namespace core