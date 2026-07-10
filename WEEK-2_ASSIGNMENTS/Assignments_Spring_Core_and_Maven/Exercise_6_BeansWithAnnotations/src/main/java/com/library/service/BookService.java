package com.library.service;

import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Exercise 6: @Service marks this as a Spring service bean.
 * @Autowired injects BookRepository automatically via component scanning.
 */
@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    public BookRepository getBookRepository() {
        return bookRepository;
    }

    public void addBook(String title) {
        System.out.println("[BookService] Adding book: " + title);
        bookRepository.save(title);
    }

    public String getBook(int id) {
        System.out.println("[BookService] Fetching book with ID: " + id);
        return bookRepository.findById(id);
    }

    public void removeBook(int id) {
        System.out.println("[BookService] Removing book with ID: " + id);
        bookRepository.deleteById(id);
    }
}
