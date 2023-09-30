#include <cstdint>
#include <limits>
#include <stdexcept>
#include <type_traits>

namespace core
{

    template<typename UNSIGNED_INT>
    class UIntToIntConverter
    {
        static_assert(std::is_unsigned<UNSIGNED_INT>::value, "Type T must be an unsigned integer type");

       public:
        static auto Convert(UNSIGNED_INT value) -> int
        {
            if (!IsWithinBounds(value))
            {
                throw std::runtime_error("Value is out of bounds for 'int'.");
            }
            return static_cast<int>(value);
        }

        static auto MaxIntValue() -> UNSIGNED_INT
        {
            return static_cast<UNSIGNED_INT>(std::numeric_limits<int>::max());
        }

        static auto IsWithinBounds(UNSIGNED_INT value) -> bool
        {
            return value <= MaxIntValue();
        }
    };

}  // namespace core
