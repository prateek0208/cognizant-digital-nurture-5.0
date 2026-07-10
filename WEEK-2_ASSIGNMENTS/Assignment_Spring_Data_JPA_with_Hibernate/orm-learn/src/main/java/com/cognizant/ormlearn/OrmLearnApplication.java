package com.cognizant.ormlearn;

import com.cognizant.ormlearn.service.CountryService;
import com.cognizant.ormlearn.service.EmployeeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class OrmLearnApplication {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrmLearnApplication.class);

    private static CountryService countryService;
    private static EmployeeService employeeService;

    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(OrmLearnApplication.class, args);
        LOGGER.info("Inside main");

        countryService = context.getBean(CountryService.class);
        employeeService = context.getBean(EmployeeService.class);

        testGetAllCountries();
        testGetAllPermanentEmployees();
        // Additional tests can be added here
    }

    private static void testGetAllCountries() {
        LOGGER.info("Start testGetAllCountries");
        try {
            LOGGER.info("Countries: {}", countryService.getAllCountries());
        } catch (Exception e) {
            LOGGER.error("Error in testGetAllCountries", e);
        }
        LOGGER.info("End testGetAllCountries");
    }

    private static void testGetAllPermanentEmployees() {
        LOGGER.info("Start testGetAllPermanentEmployees");
        try {
            LOGGER.info("Permanent Employees: {}", employeeService.getAllPermanentEmployees());
        } catch (Exception e) {
            LOGGER.error("Error in testGetAllPermanentEmployees", e);
        }
        LOGGER.info("End testGetAllPermanentEmployees");
    }
}
