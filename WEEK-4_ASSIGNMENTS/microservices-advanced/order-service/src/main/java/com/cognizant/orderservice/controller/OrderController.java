package com.cognizant.orderservice.controller;

import com.cognizant.orderservice.model.Order;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/orders")
public class OrderController {

    private final List<Order> orders = Arrays.asList(
            new Order(1L, "Laptop", 1L),
            new Order(2L, "Phone", 1L),
            new Order(3L, "Tablet", 2L),
            new Order(4L, "Monitor", 2L),
            new Order(5L, "Keyboard", 3L)
    );

    @GetMapping
    public List<Order> getAllOrders() {
        return orders;
    }

    @GetMapping("/user/{userId}")
    public List<Order> getOrdersByUserId(@PathVariable Long userId) {
        return orders.stream()
                .filter(order -> order.getUserId().equals(userId))
                .collect(Collectors.toList());
    }
}
