package com.example.employeemanagement.repository;

import com.example.employeemanagement.entity.Employee;
import com.example.employeemanagement.projection.EmployeeDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    // Derived Query Method
    List<Employee> findByName(String name);
    
    // Derived Query Method
    List<Employee> findByDepartmentName(String departmentName);

    // Custom @Query
    @Query("SELECT e FROM Employee e WHERE e.name LIKE %:keyword%")
    List<Employee> searchByName(@Param("keyword") String keyword);

    // NamedQuery
    Employee findByEmailNamed(@Param("email") String email);

    // Pagination
    Page<Employee> findAll(Pageable pageable);

    // Projection
    @Query("SELECT e.id as id, e.name as name, e.email as email FROM Employee e")
    List<EmployeeDto> findAllEmployeeDto();
}
