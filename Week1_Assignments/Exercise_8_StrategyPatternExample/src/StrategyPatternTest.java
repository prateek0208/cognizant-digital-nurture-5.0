public class StrategyPatternTest {
    public static void main(String[] args) {
        PaymentContext context = new PaymentContext();

        // test credit card
        context.setPaymentStrategy(new CreditCardPayment("John Doe", "1234567890123456"));
        context.executePayment(50.0);

        // test paypal
        context.setPaymentStrategy(new PayPalPayment("john@example.com"));
        context.executePayment(25.50);
    }
}
