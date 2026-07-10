package com.library.service;

import com.library.repository.BookRepository;

/**
 * Exercise 3: BookService with setter injection (same as Ex2).
 * AOP logging is applied at the aspect level — no changes needed here.
 */
public class BookService {

    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
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
