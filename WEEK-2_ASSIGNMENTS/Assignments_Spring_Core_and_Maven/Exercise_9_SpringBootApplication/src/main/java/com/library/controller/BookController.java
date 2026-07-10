package com.library.controller;

import com.library.entity.Book;
import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

/**
 * Exercise 9: REST Controller for CRUD operations on Book entity.
 *
 * Endpoints:
 *   GET    /api/books           — Get all books
 *   GET    /api/books/{id}      — Get book by ID
 *   POST   /api/books           — Add a new book
 *   PUT    /api/books/{id}      — Update an existing book
 *   DELETE /api/books/{id}      — Delete a book
 */
@RestController
@RequestMapping("/api/books")
public class BookController {

    @Autowired
    private BookRepository bookRepository;

    // GET all books
    @GetMapping
    public ResponseEntity<List<Book>> getAllBooks() {
        List<Book> books = bookRepository.findAll();
        return ResponseEntity.ok(books);
    }

    // GET book by ID
    @GetMapping("/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable Long id) {
        Optional<Book> book = bookRepository.findById(id);
        return book.map(ResponseEntity::ok)
                   .orElse(ResponseEntity.notFound().build());
    }

    // POST — Create new book
    @PostMapping
    public ResponseEntity<Book> addBook(@RequestBody Book book) {
        Book savedBook = bookRepository.save(book);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedBook);
    }

    // PUT — Update existing book
    @PutMapping("/{id}")
    public ResponseEntity<Book> updateBook(@PathVariable Long id, @RequestBody Book bookDetails) {
        Optional<Book> existing = bookRepository.findById(id);
        if (!existing.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        Book book = existing.get();
        book.setTitle(bookDetails.getTitle());
        book.setAuthor(bookDetails.getAuthor());
        book.setIsbn(bookDetails.getIsbn());
        book.setPrice(bookDetails.getPrice());
        Book updated = bookRepository.save(book);
        return ResponseEntity.ok(updated);
    }

    // DELETE — Remove a book
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
        if (!bookRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        bookRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    // GET — Search by author
    @GetMapping("/search/author")
    public ResponseEntity<List<Book>> getByAuthor(@RequestParam String author) {
        return ResponseEntity.ok(bookRepository.findByAuthor(author));
    }

    // GET — Search by title keyword
    @GetMapping("/search/title")
    public ResponseEntity<List<Book>> searchByTitle(@RequestParam String keyword) {
        return ResponseEntity.ok(bookRepository.findByTitleContainingIgnoreCase(keyword));
    }
}
