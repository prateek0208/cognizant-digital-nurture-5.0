package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Exercise 4: Creating and Configuring a Maven Project
 * Demonstrates a fully configured Maven project with Spring Context,
 * Spring AOP, Spring WebMVC dependencies and Java 1.8 compiler plugin.
 */
public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 4: Maven Project Configuration ===");
        System.out.println("Maven project configured with:");
        System.out.println("  - spring-context 5.3.23");
        System.out.println("  - spring-aop 5.3.23");
        System.out.println("  - spring-webmvc 5.3.23");
        System.out.println("  - aspectjweaver 1.9.9.1");
        System.out.println("  - maven-compiler-plugin (Java 1.8)");
        System.out.println();

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookService = context.getBean("bookService", BookService.class);

        bookService.addBook("Maven: The Definitive Guide");
        System.out.println(bookService.getBook(1));

        System.out.println("=== Maven project running successfully ===");
        ((ClassPathXmlApplicationContext) context).close();
    }
}
