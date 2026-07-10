package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;

    public void addBook(String title) {
        System.out.println("[BookService] Adding book: " + title);
        // Note: bookRepository is null in Exercise 1 (no DI configured yet)
        if (bookRepository != null) {
            bookRepository.save(title);
        }
    }

    public String getBook(int id) {
        System.out.println("[BookService] Fetching book with ID: " + id);
        if (bookRepository != null) {
            return bookRepository.findById(id);
        }
        return "BookRepository not wired yet";
    }
}
