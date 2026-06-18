// Exercise 5 - Task Management System
// Using Singly Linked List to manage tasks

public class Exercise5_TaskManagementSystem {

    static class Task {
        int taskId;
        String taskName;
        String status;

        Task(int taskId, String taskName, String status) {
            this.taskId = taskId;
            this.taskName = taskName;
            this.status = status;
        }

        public String toString() {
            return "TaskID: " + taskId + ", Name: " + taskName + ", Status: " + status;
        }
    }

    // Node class for linked list
    static class Node {
        Task data;
        Node next;

        Node(Task data) {
            this.data = data;
            this.next = null;
        }
    }

    private Node head;

    public Exercise5_TaskManagementSystem() {
        head = null;
    }

    // add task at end - O(n) since we traverse to the end
    public void addTask(Task task) {
        Node newNode = new Node(task);
        if (head == null) {
            head = newNode;
        } else {
            Node temp = head;
            while (temp.next != null) {
                temp = temp.next;
            }
            temp.next = newNode;
        }
        System.out.println("Added: " + task);
    }

    // search by taskId - O(n)
    public Task searchTask(int id) {
        Node temp = head;
        while (temp != null) {
            if (temp.data.taskId == id) {
                return temp.data;
            }
            temp = temp.next;
        }
        return null;
    }

    // traverse - print all tasks - O(n)
    public void traverseTasks() {
        if (head == null) {
            System.out.println("No tasks in the list.");
            return;
        }
        System.out.println("\n--- Task List ---");
        Node temp = head;
        while (temp != null) {
            System.out.println(temp.data);
            temp = temp.next;
        }
        System.out.println("-----------------\n");
    }

    // delete by taskId - O(n)
    public void deleteTask(int id) {
        if (head == null) {
            System.out.println("List is empty.");
            return;
        }

        // if head node itself needs to be deleted
        if (head.data.taskId == id) {
            System.out.println("Deleted: " + head.data);
            head = head.next;
            return;
        }

        // find the node before the one we want to delete
        Node temp = head;
        while (temp.next != null) {
            if (temp.next.data.taskId == id) {
                System.out.println("Deleted: " + temp.next.data);
                temp.next = temp.next.next; // skip the node
                return;
            }
            temp = temp.next;
        }
        System.out.println("Task not found with ID: " + id);
    }

    public static void main(String[] args) {
        Exercise5_TaskManagementSystem sys = new Exercise5_TaskManagementSystem();

        sys.addTask(new Task(1, "Design UI", "Pending"));
        sys.addTask(new Task(2, "Write Backend", "In Progress"));
        sys.addTask(new Task(3, "Setup Database", "Completed"));
        sys.addTask(new Task(4, "Write Tests", "Pending"));

        sys.traverseTasks();

        // search
        Task t = sys.searchTask(2);
        System.out.println("Found: " + (t != null ? t : "Not Found"));

        // delete from middle and head
        sys.deleteTask(3);
        sys.deleteTask(1);

        sys.traverseTasks();
    }
}

/*
 Analysis:
 - Add: O(n) to traverse to end, O(1) if adding at head
 - Search: O(n) - go through each node
 - Traverse: O(n)
 - Delete: O(n) - need to find the node first
 
 Types of Linked Lists:
 - Singly: each node points to next only, one direction traversal
 - Doubly: each node has next and previous pointer, can go both ways
 
 Advantages over arrays:
 - Dynamic size, no need to declare size upfront
 - Insert/delete at beginning is O(1) vs O(n) in arrays
 - No memory wasted from empty slots
 - No shifting needed when deleting
*/
