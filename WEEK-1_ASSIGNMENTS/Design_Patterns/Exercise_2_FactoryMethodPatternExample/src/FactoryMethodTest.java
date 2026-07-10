// test factory
public class FactoryMethodTest {
    public static void main(String[] args) {
        DocumentFactory wordFact = new WordDocumentFactory();
        Document doc1 = wordFact.createDocument();
        doc1.open();
        doc1.save();
        doc1.close();

        DocumentFactory pdfFact = new PdfDocumentFactory();
        Document doc2 = pdfFact.createDocument();
        doc2.open();
    }
}
