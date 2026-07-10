// computer class with builder
public class Computer {
    private String cpu;
    private String ram;
    private String storage;
    private String graphicsCard;
    private boolean bluetooth;
    private boolean wifi;

    private Computer(Builder b) {
        this.cpu = b.cpu;
        this.ram = b.ram;
        this.storage = b.storage;
        this.graphicsCard = b.graphicsCard;
        this.bluetooth = b.bluetooth;
        this.wifi = b.wifi;
    }

    public String toString() {
        return "Computer [cpu=" + cpu + ", ram=" + ram + ", storage=" + storage 
            + ", gpu=" + graphicsCard + ", bt=" + bluetooth + ", wifi=" + wifi + "]";
    }

    public static class Builder {
        private String cpu;
        private String ram;
        private String storage;
        private String graphicsCard = "None"; // default
        private boolean bluetooth = false;
        private boolean wifi = false;

        public Builder(String cpu, String ram, String storage) {
            this.cpu = cpu;
            this.ram = ram;
            this.storage = storage;
        }

        public Builder setGraphicsCard(String gpu) {
            this.graphicsCard = gpu;
            return this;
        }

        public Builder setBluetooth(boolean bt) {
            this.bluetooth = bt;
            return this;
        }

        public Builder setWifi(boolean wifi) {
            this.wifi = wifi;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }
    }
}
