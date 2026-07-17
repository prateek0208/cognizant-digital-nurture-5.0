import React, { Component } from 'react';
import './App.css';
import EmployeeList from './EmployeeList';
import ThemeContext from './ThemeContext';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      theme: 'light',
      employees: [
        { id: 1, name: 'John Doe' },
        { id: 2, name: 'Jane Smith' }
      ]
    };
  }

  toggleTheme = () => {
    this.setState(prevState => ({
      theme: prevState.theme === 'light' ? 'dark' : 'light'
    }));
  }

  render() {
    return (
      <ThemeContext.Provider value={this.state.theme}>
        <div className="App" style={{ padding: '20px' }}>
          <h1>Employees App</h1>
          <button onClick={this.toggleTheme}>Toggle Theme</button>
          <EmployeeList employees={this.state.employees} />
        </div>
      </ThemeContext.Provider>
    );
  }
}

export default App;
