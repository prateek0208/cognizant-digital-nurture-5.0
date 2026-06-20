// stripe adapter
public class StripeAdapter implements PaymentProcessor {
    private StripeGateway gateway;

    public StripeAdapter(StripeGateway gateway) {
        this.gateway = gateway;
    }

    public void processPayment(double amount) {
        gateway.sendPayment(amount);
    }
}
