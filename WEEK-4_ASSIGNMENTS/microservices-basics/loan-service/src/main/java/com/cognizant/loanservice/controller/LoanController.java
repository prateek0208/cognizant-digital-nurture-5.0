package com.cognizant.loanservice.controller;

import com.cognizant.loanservice.model.Loan;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@RestController
public class LoanController {

    @GetMapping("/loans")
    public List<Loan> getLoans() {
        return Arrays.asList(
                new Loan(1L, "Home Loan", 500000.00),
                new Loan(2L, "Personal Loan", 100000.00),
                new Loan(3L, "Car Loan", 300000.00)
        );
    }
}
