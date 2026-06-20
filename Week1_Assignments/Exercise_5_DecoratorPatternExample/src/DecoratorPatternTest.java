public class DecoratorPatternTest {
    public static void main(String[] args) {
        Notifier notifier = new EmailNotifier();
        
        // wrap with sms and slack
        Notifier smsNotifier = new SMSNotifierDecorator(notifier);
        Notifier slackNotifier = new SlackNotifierDecorator(smsNotifier);
        
        System.out.println("Testing base notifier:");
        notifier.send("Hello World");
        
        System.out.println("\nTesting notifier with SMS and Slack:");
        slackNotifier.send("Important update");
    }
}
