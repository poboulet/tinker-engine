#pragma once

namespace core
{
    class EngineApp
    {
       public:
        void run();

       private:
        static void initVulkan();
        void mainLoop();
        void cleanup();
    };

}  // namespace core
