// Controller - connects the model and view
public class StudentController {
    private Student model;
    private StudentView view;

    public StudentController(Student model, StudentView view) {
        this.model = model;
        this.view = view;
    }

    // Getters and setters that go through the model
    public String getStudentName() {
        return model.getName();
    }

    public void setStudentName(String name) {
        model.setName(name);
    }

    public String getStudentId() {
        return model.getId();
    }

    public void setStudentId(String id) {
        model.setId(id);
    }

    public String getStudentGrade() {
        return model.getGrade();
    }

    public void setStudentGrade(String grade) {
        model.setGrade(grade);
    }

    // Ask the view to display current model data
    public void updateView() {
        view.displayStudentDetails(model.getName(), model.getId(), model.getGrade());
    }
}
