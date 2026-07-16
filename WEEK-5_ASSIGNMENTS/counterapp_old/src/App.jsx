import React from 'react';

class CountPeople extends React.Component {
  constructor() {
    super();
    this.state = {
      entrycount: 0,
      exitcount: 0
    };
  }

  updateEntry = () => {
    this.setState((prevState) => {
      return { entrycount: prevState.entrycount + 1 };
    });
  }

  updateExit = () => {
    this.setState((prevState) => {
      return { exitcount: prevState.exitcount + 1 };
    });
  }

  render() {
    return (
      <div style={{ textAlign: 'center', marginTop: '50px' }}>
        <button onClick={this.updateEntry} style={{ backgroundColor: 'lightgreen', marginRight: '10px' }}>Login</button>
        <span>{this.state.entrycount} People Entered!!!</span>
        
        <span style={{ margin: '0 50px' }}></span>

        <button onClick={this.updateExit} style={{ backgroundColor: 'lightgreen', marginRight: '10px' }}>Exit</button>
        <span>{this.state.exitcount} People Left!!!</span>
      </div>
    );
  }
}

function App() {
  return (
    <div>
      <CountPeople />
    </div>
  );
}

export default App;
