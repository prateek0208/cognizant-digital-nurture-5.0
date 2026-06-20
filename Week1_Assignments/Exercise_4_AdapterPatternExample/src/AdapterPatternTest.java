// test class for adapter
public class AdapterPatternTest {
    public static void main(String[] args) {
        PaymentProcessor pp1 = new PayPalAdapter(new PayPalGateway());
        pp1.processPayment(50.0);

        PaymentProcessor pp2 = new StripeAdapter(new StripeGateway());
        pp2.processPayment(100.0);

        PaymentProcessor pp3 = new SquareAdapter(new SquareGateway());
        pp3.processPayment(25.5);
    }
}
