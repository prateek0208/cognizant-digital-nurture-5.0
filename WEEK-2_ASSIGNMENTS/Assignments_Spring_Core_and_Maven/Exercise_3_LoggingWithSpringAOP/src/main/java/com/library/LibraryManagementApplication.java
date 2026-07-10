package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Exercise 3: Logging with Spring AOP
 * Observe console output — LoggingAspect will print execution times around each method call.
 */
public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 3: Logging with Spring AOP ===");

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookService = context.getBean("bookService", BookService.class);

        // AOP LoggingAspect will intercept these calls and log execution times
        bookService.addBook("Design Patterns");
        bookService.addBook("Refactoring");
        System.out.println(bookService.getBook(1));
        bookService.removeBook(1);

        System.out.println("=== Check console output above for AOP execution time logs ===");
        ((ClassPathXmlApplicationContext) context).close();
    }
}
