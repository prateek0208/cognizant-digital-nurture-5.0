package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Exercise 2: Implementing Dependency Injection
 * Verifies that BookRepository is injected into BookService via setter injection.
 */
public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 2: Dependency Injection ===");

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        BookService bookService = context.getBean("bookService", BookService.class);

        // Verify DI worked - BookRepository should be injected
        System.out.println("BookRepository injected: " + (bookService.getBookRepository() != null));

        // Test operations
        bookService.addBook("Clean Code");
        bookService.addBook("Effective Java");
        System.out.println(bookService.getBook(1));
        bookService.removeBook(1);

        System.out.println("=== Dependency Injection verified successfully ===");
        ((ClassPathXmlApplicationContext) context).close();
    }
}
