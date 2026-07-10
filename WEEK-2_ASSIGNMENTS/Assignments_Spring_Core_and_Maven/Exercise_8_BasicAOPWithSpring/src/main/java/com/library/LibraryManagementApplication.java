package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Exercise 8: Basic AOP with Spring
 * Watch the console — @Before and @After advice will fire around every service/repository call.
 */
public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 8: Basic AOP with Spring ===");
        System.out.println("(Observe [AOP - BEFORE] and [AOP - AFTER] log lines below)");
        System.out.println();

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookService = context.getBean("bookService", BookService.class);

        bookService.addBook("Head First Design Patterns");
        System.out.println("---");
        System.out.println(bookService.getBook(1));
        System.out.println("---");
        bookService.removeBook(1);

        System.out.println();
        System.out.println("=== AOP @Before and @After advice verified ===");
        ((ClassPathXmlApplicationContext) context).close();
    }
}
