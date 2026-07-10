package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Exercise 1: Configuring a Basic Spring Application
 * Loads the Spring context and verifies beans are configured correctly.
 */
public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 1: Basic Spring Application ===");

        // Load the Spring Application Context from XML configuration
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        System.out.println("Spring ApplicationContext loaded successfully!");

        // Retrieve BookService bean from the context
        BookService bookService = context.getBean("bookService", BookService.class);
        System.out.println("BookService bean retrieved: " + bookService.getClass().getName());

        // Test the service
        bookService.addBook("Spring in Action");
        System.out.println(bookService.getBook(1));

        System.out.println("=== Application finished successfully ===");
        ((ClassPathXmlApplicationContext) context).close();
    }
}
