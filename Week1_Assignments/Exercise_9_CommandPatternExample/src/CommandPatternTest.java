// Testing the Command Pattern
public class CommandPatternTest {
    public static void main(String[] args) {
        // Create the receiver
        Light light = new Light();

        // Create commands
        Command lightOn = new LightOnCommand(light);
        Command lightOff = new LightOffCommand(light);

        // Create invoker
        RemoteControl remote = new RemoteControl();

        // Turn light on
        remote.setCommand(lightOn);
        System.out.println("Pressing button to turn light ON...");
        remote.pressButton();

        // Turn light off
        remote.setCommand(lightOff);
        System.out.println("Pressing button to turn light OFF...");
        remote.pressButton();
    }
}
