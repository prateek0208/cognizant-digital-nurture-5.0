package com.library.repository;

public class BookRepository {

    public void save(String bookTitle) {
        System.out.println("[BookRepository] Saving book: " + bookTitle);
    }

    public String findById(int id) {
        System.out.println("[BookRepository] Finding book with ID: " + id);
        return "Book-" + id + ": Spring Framework Documentation";
    }

    public void deleteById(int id) {
        System.out.println("[BookRepository] Deleting book with ID: " + id);
    }
}
