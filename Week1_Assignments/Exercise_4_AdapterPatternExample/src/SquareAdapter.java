// square adapter
public class SquareAdapter implements PaymentProcessor {
    private SquareGateway gateway;

    public SquareAdapter(SquareGateway gateway) {
        this.gateway = gateway;
    }

    public void processPayment(double amount) {
        gateway.doPayment(amount);
    }
}
