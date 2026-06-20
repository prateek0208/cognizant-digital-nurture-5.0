// pdf doc
public class PdfDocument implements Document {
    public void open() {
        System.out.println("Opening pdf doc");
    }
    public void save() {
        System.out.println("Saving pdf doc");
    }
    public void close() {
        System.out.println("Closing pdf doc");
    }
}
