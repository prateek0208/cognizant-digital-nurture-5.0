import React from 'react';
import { Home } from './Components/Home';
import { About } from './Components/About';
import { Contact } from './Components/Contact';

function App() {
  return (
    <div className="container" style={{ textAlign: 'center', marginTop: '50px' }}>
      <Home />
      <About />
      <Contact />
    </div>
  );
}

export default App;
