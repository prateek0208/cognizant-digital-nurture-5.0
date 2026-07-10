package com.library.service;

import com.library.repository.BookRepository;

/**
 * Exercise 2: Dependency Injection via Setter
 * BookRepository is injected by Spring through the setter method.
 */
public class BookService {

    private BookRepository bookRepository;

    // Setter method for Spring to inject BookRepository dependency
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("[BookService] BookRepository injected via setter: " + bookRepository.getClass().getName());
    }

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
