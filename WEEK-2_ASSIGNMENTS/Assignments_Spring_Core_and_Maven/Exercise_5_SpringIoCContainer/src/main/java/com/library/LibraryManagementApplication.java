package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Exercise 5: Configuring the Spring IoC Container
 */
public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 5: Spring IoC Container ===");

        // The IoC container (ApplicationContext) creates and manages all beans
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        System.out.println("IoC Container initialized — beans created and wired.");

        BookService bookService = context.getBean("bookService", BookService.class);

        // Confirm IoC has injected the dependency
        System.out.println("BookRepository injected by IoC: " + (bookService.getBookRepository() != null));

        bookService.addBook("IoC and DI in Spring");
        System.out.println(bookService.getBook(1));

        System.out.println("=== IoC Container test complete ===");
        ((ClassPathXmlApplicationContext) context).close();
    }
}
