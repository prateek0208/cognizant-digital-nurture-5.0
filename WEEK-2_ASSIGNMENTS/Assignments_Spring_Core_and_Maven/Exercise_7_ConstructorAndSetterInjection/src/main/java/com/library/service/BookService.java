package com.library.service;

import com.library.repository.BookRepository;

/**
 * Exercise 7: Constructor and Setter Injection
 *
 * - Constructor Injection: libraryName is passed via constructor.
 * - Setter Injection: bookRepository is injected via setter method.
 */
public class BookService {

    // Injected via Constructor
    private final String libraryName;

    // Injected via Setter
    private BookRepository bookRepository;

    // Constructor Injection
    public BookService(String libraryName) {
        this.libraryName = libraryName;
        System.out.println("[BookService] Constructor Injection — libraryName: " + libraryName);
    }

    // Setter Injection
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("[BookService] Setter Injection — BookRepository: " + bookRepository.getClass().getSimpleName());
    }

    public BookRepository getBookRepository() {
        return bookRepository;
    }

    public String getLibraryName() {
        return libraryName;
    }

    public void addBook(String title) {
        System.out.println("[" + libraryName + "] Adding book: " + title);
        bookRepository.save(title);
    }

    public String getBook(int id) {
        System.out.println("[" + libraryName + "] Fetching book ID: " + id);
        return bookRepository.findById(id);
    }
}
