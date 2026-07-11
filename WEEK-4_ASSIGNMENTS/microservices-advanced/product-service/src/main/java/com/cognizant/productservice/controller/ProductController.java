package com.cognizant.productservice.controller;

import com.cognizant.productservice.model.Product;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/products")
public class ProductController {

    @Value("${product.discount:0}")
    private int discount;

    @GetMapping
    public List<Product> getAllProducts() {
        return List.of(
                new Product(1L, "Laptop", 75000.00),
                new Product(2L, "Smartphone", 25000.00),
                new Product(3L, "Headphones", 3000.00)
        );
    }

    @GetMapping("/discount")
    public Map<String, Integer> getDiscount() {
        return Map.of("discount", discount);
    }
}
