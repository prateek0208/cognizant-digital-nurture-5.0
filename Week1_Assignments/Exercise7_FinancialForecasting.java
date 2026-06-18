// Exercise 7 - Financial Forecasting
// Using recursion to predict future value based on growth rate

public class Exercise7_FinancialForecasting {

    // Recursive method to calculate future value
    // Formula: FV = PV * (1 + growthRate) ^ years
    // Base case: if years == 0, return the present value
    // Recursive case: multiply last year's value by (1 + rate)
    public static double calculateFutureValue(double presentValue, double growthRate, int years) {
        if (years == 0) {
            return presentValue; // base case
        }
        return calculateFutureValue(presentValue, growthRate, years - 1) * (1 + growthRate);
    }

    // Iterative version (optimized, no recursion stack)
    public static double futureValueIterative(double presentValue, double growthRate, int years) {
        double value = presentValue;
        for (int i = 0; i < years; i++) {
            value = value * (1 + growthRate);
        }
        return value;
    }

    public static void main(String[] args) {
        double presentValue = 10000.0;
        double growthRate = 0.08; // 8%
        int years = 10;

        System.out.println("Present Value: $" + presentValue);
        System.out.println("Growth Rate: " + (growthRate * 100) + "%");
        System.out.println("Years: " + years);
        System.out.println();

        // using recursive method
        double fv = calculateFutureValue(presentValue, growthRate, years);
        System.out.println("Future Value (Recursive): $" + String.format("%.2f", fv));

        // using iterative method
        double fv2 = futureValueIterative(presentValue, growthRate, years);
        System.out.println("Future Value (Iterative): $" + String.format("%.2f", fv2));

        // year by year breakdown
        System.out.println("\nYear-by-year breakdown:");
        for (int i = 1; i <= years; i++) {
            double val = calculateFutureValue(presentValue, growthRate, i);
            System.out.println("  Year " + i + ": $" + String.format("%.2f", val));
        }
    }
}

/*
 Analysis:
 - Recursion: method calls itself with a smaller problem until base case
 - Time complexity: O(n) where n is the number of years
 - Space complexity: O(n) because of recursive call stack
 
 Optimization:
 - Use iterative approach instead -> same O(n) time but O(1) space
 - Avoids StackOverflowError for very large number of years
 - We can also use memoization (store already calculated values in a map)
   to avoid recalculating same values if function is called multiple times
*/
