package com.cognizant.springlearn.dao;

import com.cognizant.springlearn.exception.EmployeeNotFoundException;
import com.cognizant.springlearn.model.Employee;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class EmployeeDao {
    private static List<Employee> EMPLOYEE_LIST;

    public EmployeeDao() {
        ApplicationContext context = new ClassPathXmlApplicationContext("employee.xml", "date-format.xml");
        EMPLOYEE_LIST = (ArrayList<Employee>) context.getBean("employeeList");
    }

    public List<Employee> getAllEmployees() {
        return EMPLOYEE_LIST;
    }
    
    public Employee getEmployee(String id) {
        return EMPLOYEE_LIST.stream()
                .filter(e -> e.getId().equals(id))
                .findFirst()
                .orElseThrow(EmployeeNotFoundException::new);
    }
    
    public void updateEmployee(Employee employee) {
        Employee existing = getEmployee(employee.getId());
        existing.setName(employee.getName());
        existing.setSalary(employee.getSalary());
        existing.setPermanent(employee.isPermanent());
        existing.setDateOfBirth(employee.getDateOfBirth());
        existing.setDepartment(employee.getDepartment());
        existing.setSkills(employee.getSkills());
    }
    
    public void deleteEmployee(String id) {
        Employee existing = getEmployee(id);
        EMPLOYEE_LIST.remove(existing);
    }
}
