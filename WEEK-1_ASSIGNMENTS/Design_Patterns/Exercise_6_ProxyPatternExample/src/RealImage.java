public class RealImage implements Image {
    private String filename;

    public RealImage(String filename) {
        this.filename = filename;
        loadFromServer();
    }

    // simulates a heavy operation
    private void loadFromServer() {
        System.out.println("Loading " + filename + " from server...");
    }

    @Override
    public void display() {
        System.out.println("Displaying " + filename);
    }
}
