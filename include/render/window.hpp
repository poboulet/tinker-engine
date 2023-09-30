#pragma once

namespace Engine
{
    class Window
    {
       public:
        virtual ~Window() = default;

        Window(const Window&) = delete;
        auto operator=(const Window&) -> Window& = delete;

        Window(Window&&) = delete;
        auto operator=(Window&&) -> Window& = delete;

       protected:
        Window() = default;
    };
}  // namespace Engine