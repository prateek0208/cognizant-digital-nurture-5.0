import java.util.Arrays;

// Exercise 6 - Library Management System
// Searching books by title using linear search and binary search

public class Exercise6_LibraryManagementSystem {

    static class Book {
        int bookId;
        String title;
        String author;

        Book(int bookId, String title, String author) {
            this.bookId = bookId;
            this.title = title;
            this.author = author;
        }

        public String toString() {
            return "BookID: " + bookId + ", Title: " + title + ", Author: " + author;
        }
    }

    // Linear Search - check each book title one by one
    public static Book linearSearchByTitle(Book[] books, String title) {
        for (int i = 0; i < books.length; i++) {
            if (books[i].title.equalsIgnoreCase(title)) {
                return books[i];
            }
        }
        return null;
    }

    // Binary Search - books must be sorted by title first
    public static Book binarySearchByTitle(Book[] books, String title) {
        int low = 0, high = books.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            int cmp = books[mid].title.compareToIgnoreCase(title);

            if (cmp == 0) {
                return books[mid];
            } else if (cmp < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Book[] books = {
            new Book(1, "The Great Gatsby", "F. Scott Fitzgerald"),
            new Book(2, "To Kill a Mockingbird", "Harper Lee"),
            new Book(3, "1984", "George Orwell"),
            new Book(4, "Pride and Prejudice", "Jane Austen"),
            new Book(5, "Moby Dick", "Herman Melville"),
            new Book(6, "Brave New World", "Aldous Huxley")
        };

        // linear search - works on unsorted
        System.out.println("--- Linear Search ---");
        Book result = linearSearchByTitle(books, "1984");
        System.out.println("Search '1984': " + (result != null ? result : "Not Found"));

        result = linearSearchByTitle(books, "Harry Potter");
        System.out.println("Search 'Harry Potter': " + (result != null ? result : "Not Found"));

        // sort books by title for binary search
        Arrays.sort(books, (a, b) -> a.title.compareToIgnoreCase(b.title));

        System.out.println("\n--- Binary Search (sorted by title) ---");
        result = binarySearchByTitle(books, "Pride and Prejudice");
        System.out.println("Search 'Pride and Prejudice': " + (result != null ? result : "Not Found"));

        result = binarySearchByTitle(books, "The Hobbit");
        System.out.println("Search 'The Hobbit': " + (result != null ? result : "Not Found"));
    }
}

/*
 Analysis:
 - Linear Search: O(n) - simple, works on unsorted data
 - Binary Search: O(log n) - faster but needs sorted data
 
 When to use which:
 - Small dataset or unsorted -> use linear search
 - Large dataset that is already sorted -> binary search is much better
 - In a library system where books are cataloged alphabetically,
   binary search makes more sense since we can search in O(log n)
*/
