
#include "glfw_window.hpp"

#include "uint_to_int_converter.hpp"
namespace core
{
    GLFWWindowImpl::GLFWWindowImpl()
    {
        const int signedWidth = UIntToIntConverter<uint32_t>::Convert(WIDTH);
        const int signedHeight = UIntToIntConverter<uint32_t>::Convert(HEIGHT);

        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
        glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

        window = glfwCreateWindow(signedWidth, signedHeight, "Vulkan", nullptr, nullptr);
    }

}  // namespace core