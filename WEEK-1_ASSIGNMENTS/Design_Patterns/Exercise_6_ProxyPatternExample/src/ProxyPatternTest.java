public class ProxyPatternTest {
    public static void main(String[] args) {
        Image image = new ProxyImage("test_photo.jpg");

        // first time it should load from server
        System.out.println("First call:");
        image.display();

        // second time it should just display without loading
        System.out.println("\nSecond call:");
        image.display();
    }
}
