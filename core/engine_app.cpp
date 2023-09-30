#include "engine_app.hpp"

#include <iostream>

using std::cout;

namespace core
{

    void EngineApp::run()
    {
        initVulkan();
        mainLoop();
        cleanup();
    }

    void EngineApp::initVulkan()
    {
        cout << "initVulkan"
             << "\n";
    }
    void EngineApp::mainLoop()
    {
    }

    void EngineApp::cleanup()
    {
    }

}  // namespace core
