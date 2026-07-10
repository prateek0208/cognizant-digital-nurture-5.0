package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Exercise 6: Configuring Beans with Annotations
 * Uses @Service, @Repository, and @Autowired instead of XML bean wiring.
 */
public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 6: Beans with Annotations ===");

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        // Bean is auto-detected via @Service annotation + component scanning
        BookService bookService = context.getBean(BookService.class);

        System.out.println("BookService detected via @Service: " + bookService.getClass().getName());
        System.out.println("BookRepository injected via @Autowired: " + (bookService.getBookRepository() != null));

        bookService.addBook("Spring Annotations Guide");
        System.out.println(bookService.getBook(1));
        bookService.removeBook(1);

        System.out.println("=== Annotation-based configuration verified ===");
        ((ClassPathXmlApplicationContext) context).close();
    }
}
