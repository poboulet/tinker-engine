#include "engine_app.hpp"

namespace engine {
void EngineApp::run()
{
    while (!Window.shouldClose()) { glfwPollEvents(); }
}
}// namespace engine
