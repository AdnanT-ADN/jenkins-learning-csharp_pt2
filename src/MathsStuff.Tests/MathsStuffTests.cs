using Xunit;
using MathsStuff;

namespace MathsStuff.Tests;

public class MathsStuffTests
{
    [Fact]
    public void Add_TwoPositiveIntegers()
    {
        int result = MathsStuff.MathsOperations.add(4, 5);
        Assert.Equal(9, result);
    }

    [Fact]
    public void Add_TwoNegativeIntegers()
    {
        int result = MathsStuff.MathsOperations.add(-4, -7);
        Assert.Equal(-11, result);
    }

    [Fact]
    public void Add_PositiveAndNegativeIntegers()
    {
        int result1 = MathsStuff.MathsOperations.add(-6, 3);
        int result2 = MathsStuff.MathsOperations.add(5, -8);

        Assert.Equal(-3, result1);
        Assert.Equal(-3, result2);
    }

    [Fact]
    public void Add_Zeros()
    {
        int result = MathsStuff.MathsOperations.add(0, 0);
        Assert.Equal(0, result);
    }
    
}