package com.library.repository;

import com.library.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Exercise 9: BookRepository extends JpaRepository.
 * Spring Data JPA auto-generates CRUD implementations at runtime.
 */
@Repository
public interface BookRepository extends JpaRepository<Book, Long> {

    // Custom query method — Spring Data JPA generates SQL automatically
    List<Book> findByAuthor(String author);

    List<Book> findByTitleContainingIgnoreCase(String keyword);
}
