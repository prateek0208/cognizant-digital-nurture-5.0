package com.cognizant.springlearn.controller;

import com.cognizant.springlearn.exception.CountryNotFoundException;
import com.cognizant.springlearn.model.Country;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/countries")
public class CountryController {
    private static final Logger LOGGER = LoggerFactory.getLogger(CountryController.class);

    @GetMapping
    public List<Country> getAllCountries() {
        LOGGER.info("Start");
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        List<Country> countries = (ArrayList<Country>) context.getBean("countryList");
        LOGGER.info("End");
        return countries;
    }

    @GetMapping("/{code}")
    public Country getCountry(@PathVariable String code) {
        LOGGER.info("Start");
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        List<Country> countries = (ArrayList<Country>) context.getBean("countryList");
        Country country = countries.stream()
                .filter(c -> c.getCode().equalsIgnoreCase(code))
                .findFirst()
                .orElseThrow(CountryNotFoundException::new);
        LOGGER.info("End");
        return country;
    }

    @PostMapping
    public Country addCountry(@Valid @RequestBody Country country) {
        LOGGER.info("Start");
        LOGGER.debug("Country added: {}", country);
        LOGGER.info("End");
        return country;
    }
}
