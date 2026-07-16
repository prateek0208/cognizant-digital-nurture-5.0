import React from 'react';
import './App.css';

function App() {
  const ItemName = { Name: "DBS", Rent: 50000, Address: "Chennai" };
  const jsxatt = <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80&w=300&h=200" width="25%" height="25%" alt="Office Space" />;
  
  let colors = [];
  if (ItemName.Rent <= 60000) {
    colors.push('textRed');
  } else {
    colors.push('textGreen');
  }

  const textColorStyle = { color: ItemName.Rent <= 60000 ? 'red' : 'green' };

  return (
    <div>
      <h1>Office Space, at Affordable Range</h1>
      {jsxatt}
      <h1>Name: {ItemName.Name}</h1>
      <h3 style={textColorStyle}>Rent: Rs. {ItemName.Rent}</h3>
      <h3>Address: {ItemName.Address}</h3>
    </div>
  );
}

export default App;
