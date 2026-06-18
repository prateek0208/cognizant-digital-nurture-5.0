// Exercise 4 - Employee Management System
// Using array to store employee records

public class Exercise4_EmployeeManagementSystem {

    static class Employee {
        int employeeId;
        String name;
        String position;
        double salary;

        Employee(int employeeId, String name, String position, double salary) {
            this.employeeId = employeeId;
            this.name = name;
            this.position = position;
            this.salary = salary;
        }

        public String toString() {
            return "ID: " + employeeId + ", Name: " + name + ", Position: " + position + ", Salary: $" + salary;
        }
    }

    private Employee[] employees;
    private int count; // how many employees are currently stored

    public Exercise4_EmployeeManagementSystem(int maxSize) {
        employees = new Employee[maxSize];
        count = 0;
    }

    // add employee at the end - O(1)
    public void addEmployee(Employee emp) {
        if (count >= employees.length) {
            System.out.println("Array is full, cannot add more employees.");
            return;
        }
        employees[count] = emp;
        count++;
        System.out.println("Added: " + emp);
    }

    // search by ID - O(n) because we check each element
    public Employee searchEmployee(int id) {
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == id) {
                return employees[i];
            }
        }
        return null;
    }

    // traverse - just print all employees - O(n)
    public void traverseEmployees() {
        if (count == 0) {
            System.out.println("No employees found.");
            return;
        }
        System.out.println("\n--- Employee Records ---");
        for (int i = 0; i < count; i++) {
            System.out.println(employees[i]);
        }
        System.out.println("------------------------\n");
    }

    // delete by ID - O(n) because we need to shift elements
    public void deleteEmployee(int id) {
        int index = -1;

        // find the employee first
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == id) {
                index = i;
                break;
            }
        }

        if (index == -1) {
            System.out.println("Employee not found with ID: " + id);
            return;
        }

        System.out.println("Deleted: " + employees[index]);

        // shift remaining elements to left
        for (int i = index; i < count - 1; i++) {
            employees[i] = employees[i + 1];
        }
        employees[count - 1] = null;
        count--;
    }

    public static void main(String[] args) {
        Exercise4_EmployeeManagementSystem sys = new Exercise4_EmployeeManagementSystem(10);

        sys.addEmployee(new Employee(1, "Prateek", "Developer", 75000));
        sys.addEmployee(new Employee(2, "Anjali", "Designer", 65000));
        sys.addEmployee(new Employee(3, "Rahul", "Manager", 90000));
        sys.addEmployee(new Employee(4, "Sneha", "Tester", 60000));

        sys.traverseEmployees();

        // searching
        Employee e = sys.searchEmployee(3);
        System.out.println("Found: " + (e != null ? e : "Not Found"));

        // deleting
        sys.deleteEmployee(2);
        sys.traverseEmployees();
    }
}

/*
 Analysis:
 - Add: O(1) - just put at the end
 - Search: O(n) - have to check each element
 - Traverse: O(n) - go through all
 - Delete: O(n) - need to find + shift elements
 
 Arrays in memory: stored in contiguous memory blocks, so accessing by index is O(1).
 
 Limitations of arrays:
 - Fixed size, cant grow once created
 - Deleting from middle needs shifting which is slow
 - Wastage of memory if we allocate large but use less
 Use arrays when: size is known, fast index access needed, data doesnt change much
*/
