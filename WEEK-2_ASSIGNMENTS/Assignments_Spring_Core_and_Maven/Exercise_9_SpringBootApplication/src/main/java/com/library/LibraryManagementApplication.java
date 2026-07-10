package com.library;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Exercise 9: Spring Boot Application Entry Point
 * @SpringBootApplication combines @Configuration, @EnableAutoConfiguration, @ComponentScan.
 */
@SpringBootApplication
public class LibraryManagementApplication {
    public static void main(String[] args) {
        SpringApplication.run(LibraryManagementApplication.class, args);
        System.out.println("=== Library Management Spring Boot App Started ===");
        System.out.println("Test REST endpoints:");
        System.out.println("  GET    http://localhost:8080/api/books");
        System.out.println("  GET    http://localhost:8080/api/books/{id}");
        System.out.println("  POST   http://localhost:8080/api/books");
        System.out.println("  PUT    http://localhost:8080/api/books/{id}");
        System.out.println("  DELETE http://localhost:8080/api/books/{id}");
    }
}
