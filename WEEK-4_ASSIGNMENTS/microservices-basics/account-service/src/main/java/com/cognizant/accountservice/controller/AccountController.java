package com.cognizant.accountservice.controller;

import com.cognizant.accountservice.model.Account;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@RestController
public class AccountController {

    @GetMapping("/accounts")
    public List<Account> getAccounts() {
        return Arrays.asList(
                new Account(1L, "Savings Account", 15000.00),
                new Account(2L, "Current Account", 25000.50),
                new Account(3L, "Fixed Deposit", 100000.00)
        );
    }
}
