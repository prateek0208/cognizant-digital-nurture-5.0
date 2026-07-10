package com.cognizant.ormlearn.service;

import com.cognizant.ormlearn.model.Department;
import com.cognizant.ormlearn.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentRepository departmentRepository;

    @Transactional(readOnly = true)
    public Department getDepartment(int id) {
        Optional<Department> department = departmentRepository.findById(id);
        return department.orElse(null);
    }
    
    @Transactional
    public void saveDepartment(Department department) {
        departmentRepository.save(department);
    }
}
