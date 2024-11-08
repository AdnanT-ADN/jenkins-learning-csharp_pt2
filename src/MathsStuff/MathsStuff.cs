namespace MathsStuff;

public class MathsOperations
{
    public static int add(int x, int y) {
        return x + y;
    }

    public static int subtract(int x, int y) {
        return x - y;
    }

    public static int multiply(int x, int y) {
        return x * y;
    }

    public static double divide(double x, double y) {
        if (y == 0) {
            return 0;
        }
        return x / y;
    }
}
