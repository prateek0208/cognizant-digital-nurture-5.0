package com.cognizant.resourceserver.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.Map;

@RestController
public class ResourceController {

    @GetMapping("/api/resource")
    public Map<String, Object> getResource() {
        return Map.of(
            "message", "This is a protected resource from the Resource Server",
            "timestamp", Instant.now().toString()
        );
    }
}
