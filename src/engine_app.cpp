#include "engine_app.hpp"
namespace engine
{

    void EngineApp::run()
    {
        initVulkan();
        mainLoop();
        cleanup();
    }

    void EngineApp::initVulkan()
    {
    }
    void EngineApp::mainLoop()
    {
    }

    void EngineApp::cleanup()
    {
    }

}  // namespace engine
