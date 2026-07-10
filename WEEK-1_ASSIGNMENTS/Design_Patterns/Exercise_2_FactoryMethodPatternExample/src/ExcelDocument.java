// excel doc
public class ExcelDocument implements Document {
    public void open() {
        System.out.println("Opening excel doc");
    }
    public void save() {
        System.out.println("Saving excel doc");
    }
    public void close() {
        System.out.println("Closing excel doc");
    }
}
