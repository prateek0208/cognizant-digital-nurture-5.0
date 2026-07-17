import React, { useContext } from 'react';
import ThemeContext from './ThemeContext';

const EmployeeCard = ({ name, id }) => {
  const theme = useContext(ThemeContext);

  return (
    <div style={{ border: '1px solid black', margin: '10px', padding: '10px' }}>
      <p>ID: {id}</p>
      <p>Name: {name}</p>
      <button className={theme}>Action</button>
    </div>
  );
};

export default EmployeeCard;
