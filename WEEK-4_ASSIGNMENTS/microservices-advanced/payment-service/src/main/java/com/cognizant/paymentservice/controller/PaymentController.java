package com.cognizant.paymentservice.controller;

import com.cognizant.paymentservice.model.Payment;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/payments")
public class PaymentController {

    @GetMapping("/process/{orderId}")
    @CircuitBreaker(name = "paymentService", fallbackMethod = "paymentFallback")
    public Payment processPayment(@PathVariable Long orderId) {
        return new Payment(1L, orderId, 250.00, "SUCCESS");
    }

    public Payment paymentFallback(Long orderId, Throwable t) {
        return new Payment(null, orderId, 0.0, "FALLBACK - Service Unavailable");
    }
}
