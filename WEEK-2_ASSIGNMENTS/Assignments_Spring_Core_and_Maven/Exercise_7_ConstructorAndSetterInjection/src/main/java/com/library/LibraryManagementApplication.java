package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Exercise 7: Constructor and Setter Injection
 */
public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 7: Constructor and Setter Injection ===");

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookService = context.getBean("bookService", BookService.class);

        // Verify constructor injection
        System.out.println("Library Name (Constructor Injection): " + bookService.getLibraryName());

        // Verify setter injection
        System.out.println("BookRepository (Setter Injection): " + (bookService.getBookRepository() != null));

        // Test operations
        bookService.addBook("The Pragmatic Programmer");
        System.out.println(bookService.getBook(1));

        System.out.println("=== Both injection types verified successfully ===");
        ((ClassPathXmlApplicationContext) context).close();
    }
}
