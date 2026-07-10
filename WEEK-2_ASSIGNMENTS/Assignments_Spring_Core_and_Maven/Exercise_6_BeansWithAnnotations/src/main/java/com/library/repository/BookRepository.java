package com.library.repository;

import org.springframework.stereotype.Repository;

/**
 * Exercise 6: @Repository annotation marks this class as a Spring-managed bean.
 * Component scanning in applicationContext.xml detects this automatically.
 */
@Repository
public class BookRepository {

    public void save(String bookTitle) {
        System.out.println("[BookRepository] Saving book: " + bookTitle);
    }

    public String findById(int id) {
        System.out.println("[BookRepository] Finding book with ID: " + id);
        return "Book-" + id + ": Annotations in Spring";
    }

    public void deleteById(int id) {
        System.out.println("[BookRepository] Deleting book with ID: " + id);
    }
}
