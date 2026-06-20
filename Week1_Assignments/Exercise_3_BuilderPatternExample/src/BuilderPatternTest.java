// test for builder
public class BuilderPatternTest {
    public static void main(String[] args) {
        Computer basicPc = new Computer.Builder("Intel i3", "8GB", "256GB SSD")
            .build();
            
        Computer gamingPc = new Computer.Builder("AMD Ryzen 7", "32GB", "1TB SSD")
            .setGraphicsCard("RTX 4070")
            .setWifi(true)
            .setBluetooth(true)
            .build();

        System.out.println(basicPc);
        System.out.println(gamingPc);
    }
}
