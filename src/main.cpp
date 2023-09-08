#include <iostream>
#include <stdexcept>

#include "engine_app.hpp"

auto main() -> int
{
    engine::EngineApp app{};
    try
    {
        app.run();
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
