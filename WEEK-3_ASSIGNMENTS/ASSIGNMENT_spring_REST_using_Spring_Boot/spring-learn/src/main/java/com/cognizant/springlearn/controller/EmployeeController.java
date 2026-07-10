package com.cognizant.springlearn.controller;

import com.cognizant.springlearn.dao.EmployeeDao;
import com.cognizant.springlearn.model.Employee;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/employees")
public class EmployeeController {
    private static final Logger LOGGER = LoggerFactory.getLogger(EmployeeController.class);

    @Autowired
    private EmployeeDao employeeDao;

    @GetMapping
    public List<Employee> getAllEmployees() {
        LOGGER.info("Start");
        List<Employee> list = employeeDao.getAllEmployees();
        LOGGER.info("End");
        return list;
    }

    @GetMapping("/{id}")
    public Employee getEmployee(@PathVariable String id) {
        LOGGER.info("Start");
        Employee emp = employeeDao.getEmployee(id);
        LOGGER.info("End");
        return emp;
    }

    @PutMapping
    public void updateEmployee(@Valid @RequestBody Employee employee) {
        LOGGER.info("Start");
        employeeDao.updateEmployee(employee);
        LOGGER.info("End");
    }

    @DeleteMapping("/{id}")
    public void deleteEmployee(@PathVariable String id) {
        LOGGER.info("Start");
        employeeDao.deleteEmployee(id);
        LOGGER.info("End");
    }
}
