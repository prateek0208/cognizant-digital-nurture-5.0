package com.library.service;

import com.library.repository.BookRepository;

/**
 * Exercise 5: Spring IoC Container
 * The IoC container controls the creation and lifecycle of this bean,
 * injecting BookRepository through the setter method.
 */
public class BookService {

    private BookRepository bookRepository;

    // IoC container calls this setter to inject BookRepository
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public BookRepository getBookRepository() {
        return bookRepository;
    }

    public void addBook(String title) {
        System.out.println("[BookService] addBook() called with: " + title);
        bookRepository.save(title);
    }

    public String getBook(int id) {
        System.out.println("[BookService] getBook() called with id: " + id);
        return bookRepository.findById(id);
    }
}
