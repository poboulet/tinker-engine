#include "uint_to_int_converter.hpp"

#include <gtest/gtest.h>

using namespace core;

template<typename T>
class UIntToIntConverterTypedTest : public ::testing::Test
{
   protected:
    auto getMaxAllowedUnsignedValue() -> T
    {
        auto maxIntValue = std::numeric_limits<int>::max();
        if (sizeof(T) < sizeof(int) && maxIntValue > std::numeric_limits<T>::max())
        {
            return std::numeric_limits<T>::max() - 1;
        }
        return static_cast<T>(maxIntValue) - 1;
    }
};

TYPED_TEST_SUITE_P(UIntToIntConverterTypedTest);

TYPED_TEST_P(UIntToIntConverterTypedTest, GivenMinUnsignedValue_WhenConvert_ReturnsMinInt)
{
    using UIntType = TypeParam;
    auto minValue = static_cast<UIntType>(std::numeric_limits<UIntType>::min());

    const int result = UIntToIntConverter<TypeParam>::Convert(minValue);

    EXPECT_EQ(static_cast<int>(minValue), result);
}

TYPED_TEST_P(UIntToIntConverterTypedTest, GivenMaxAllowedUnsignedValue_WhenConverted_ThenReturnsEquivalentInt)
{
    auto maxAllowedUnsignedValue = this->getMaxAllowedUnsignedValue();

    const int result = UIntToIntConverter<TypeParam>::Convert(maxAllowedUnsignedValue);

    EXPECT_EQ(static_cast<int>(maxAllowedUnsignedValue), result);
}

TEST(UIntToIntConverterTest, GivenIntLimit_WhenConvert_Throws)
{
    auto outOfBoundsIntValue = static_cast<uint64_t>(std::numeric_limits<int>::max()) + 1;

    EXPECT_THROW(UIntToIntConverter<uint64_t>::Convert(outOfBoundsIntValue), std::runtime_error);
}

REGISTER_TYPED_TEST_SUITE_P(
    UIntToIntConverterTypedTest,
    GivenMinUnsignedValue_WhenConvert_ReturnsMinInt,
    GivenMaxAllowedUnsignedValue_WhenConverted_ThenReturnsEquivalentInt);

using UnsignedIntTypes = ::testing::Types<uint8_t, uint16_t, uint32_t, uint64_t>;
INSTANTIATE_TYPED_TEST_SUITE_P(UIntTestInstances, UIntToIntConverterTypedTest, UnsignedIntTypes);
