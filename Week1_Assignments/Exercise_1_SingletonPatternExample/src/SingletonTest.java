// test class for logger
public class SingletonTest {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        logger1.log("Testing logger 1");
        logger2.log("Testing logger 2");

        if (logger1 == logger2) {
            System.out.println("Both loggers are the same");
        } else {
            System.out.println("Loggers are different");
        }
    }
}
