// word doc
public class WordDocument implements Document {
    public void open() {
        System.out.println("Opening word doc");
    }
    public void save() {
        System.out.println("Saving word doc");
    }
    public void close() {
        System.out.println("Closing word doc");
    }
}
