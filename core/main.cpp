#include <iostream>
#include <stdexcept>

#include "engine_app.hpp"

auto main() -> int
{
    core::EngineApp app;
    try
    {
        app.run();
    }
    catch (const std::exception& e)
    {
        std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
