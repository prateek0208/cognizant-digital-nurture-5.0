package com.library.entity;

import javax.persistence.*;

/**
 * Exercise 9: JPA Entity representing a Book in the database.
 */
@Entity
@Table(name = "books")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String author;

    @Column(nullable = false)
    private String isbn;

    @Column(nullable = false)
    private Double price;

    // Default constructor (required by JPA)
    public Book() {}

    public Book(String title, String author, String isbn, Double price) {
        this.title  = title;
        this.author = author;
        this.isbn   = isbn;
        this.price  = price;
    }

    // Getters and Setters
    public Long getId()                   { return id; }
    public void setId(Long id)            { this.id = id; }

    public String getTitle()              { return title; }
    public void setTitle(String title)    { this.title = title; }

    public String getAuthor()             { return author; }
    public void setAuthor(String author)  { this.author = author; }

    public String getIsbn()               { return isbn; }
    public void setIsbn(String isbn)      { this.isbn = isbn; }

    public Double getPrice()              { return price; }
    public void setPrice(Double price)    { this.price = price; }

    @Override
    public String toString() {
        return "Book{id=" + id + ", title='" + title + "', author='" + author
                + "', isbn='" + isbn + "', price=" + price + "}";
    }
}
