import React from 'react';
import EmployeeCard from './EmployeeCard';

const EmployeeList = ({ employees }) => {
  return (
    <div>
      {employees.map(emp => (
        <EmployeeCard key={emp.id} name={emp.name} id={emp.id} />
      ))}
    </div>
  );
};

export default EmployeeList;
