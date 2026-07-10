// Testing the MVC Pattern
public class MVCPatternTest {
    public static void main(String[] args) {
        // Create model
        Student student = new Student("Prateek", "S101", "A");

        // Create view
        StudentView view = new StudentView();

        // Create controller
        StudentController controller = new StudentController(student, view);

        // Display initial details
        System.out.println("Initial student info:");
        controller.updateView();

        // Update some fields through controller
        controller.setStudentName("Prateek Kumar");
        controller.setStudentGrade("A+");

        System.out.println("\nAfter updating name and grade:");
        controller.updateView();
    }
}
