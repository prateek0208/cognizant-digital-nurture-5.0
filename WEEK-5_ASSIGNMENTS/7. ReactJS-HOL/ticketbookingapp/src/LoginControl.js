import React, { Component } from 'react';
import Greeting from './Greeting';

class LoginControl extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isLoggedIn: false
    };
  }

  handleLoginClick = () => {
    this.setState({ isLoggedIn: true });
  }

  handleLogoutClick = () => {
    this.setState({ isLoggedIn: false });
  }

  render() {
    const isLoggedIn = this.state.isLoggedIn;
    let button;

    if (isLoggedIn) {
      button = <button onClick={this.handleLogoutClick}>Logout</button>;
    } else {
      button = <button onClick={this.handleLoginClick}>Login</button>;
    }

    return (
      <div style={{ textAlign: 'center', marginTop: '20px' }}>
        <Greeting isLoggedIn={isLoggedIn} />
        {button}
      </div>
    );
  }
}

export default LoginControl;
