#pragma once

namespace engine
{
    class EngineApp
    {
       public:
        void run();

       private:
        void initVulkan();
        void mainLoop();
        void cleanup();
    };

}  // namespace engine
