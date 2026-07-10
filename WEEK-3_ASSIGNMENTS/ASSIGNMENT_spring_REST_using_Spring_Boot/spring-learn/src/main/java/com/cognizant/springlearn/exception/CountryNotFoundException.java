package com.cognizant.springlearn.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST, reason = "Country not found")
public class CountryNotFoundException extends RuntimeException {
    public CountryNotFoundException() {
        super("Country not found");
    }
}
