import React, { Component } from 'react';

class Register extends Component {
  constructor(props) {
    super(props);
    this.state = {
      fullName: '',
      email: '',
      password: '',
      errors: {
        fullName: 'Full Name must be 5 characters long!',
        email: 'Email is not valid!',
        password: 'Password must be 8 characters long!'
      }
    };
  }

  handleChange = (event) => {
    event.preventDefault();
    const { name, value } = event.target;
    let errors = this.state.errors;

    switch (name) {
      case 'fullName':
        errors.fullName = value.length < 5 ? 'Full Name must be 5 characters long!' : '';
        break;
      case 'email':
        const validEmailRegex = RegExp(/^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i);
        errors.email = validEmailRegex.test(value) ? '' : 'Email is not valid!';
        break;
      case 'password':
        errors.password = value.length < 8 ? 'Password must be 8 characters long!' : '';
        break;
      default:
        break;
    }

    this.setState({ errors, [name]: value });
  }

  validateForm = (errors) => {
    let valid = true;
    Object.values(errors).forEach(val => val.length > 0 && (valid = false));
    return valid;
  }

  handleSubmit = (event) => {
    event.preventDefault();
    if(this.validateForm(this.state.errors)) {
      alert('Valid Form');
    } else {
      if(this.state.errors.fullName !== "") {
        alert(this.state.errors.fullName);
      } else if(this.state.errors.email !== "") {
        alert(this.state.errors.email);
      } else if(this.state.errors.password !== "") {
        alert(this.state.errors.password);
      }
    }
  }

  render() {
    return (
      <div style={{ textAlign: 'center', marginTop: '50px' }}>
        <h2 style={{ color: 'red' }}>Register Here!!!</h2>
        <form onSubmit={this.handleSubmit} style={{ display: 'inline-block', textAlign: 'left' }}>
          <div style={{ marginBottom: '5px' }}>
            <label style={{ display: 'inline-block', width: '80px' }}>Name: </label>
            <input type="text" name="fullName" onChange={this.handleChange} />
          </div>
          <div style={{ marginBottom: '5px' }}>
            <label style={{ display: 'inline-block', width: '80px' }}>Email: </label>
            <input type="email" name="email" onChange={this.handleChange} />
          </div>
          <div style={{ marginBottom: '10px' }}>
            <label style={{ display: 'inline-block', width: '80px' }}>Password: </label>
            <input type="password" name="password" onChange={this.handleChange} />
          </div>
          <div style={{ marginLeft: '80px' }}>
            <button type="submit">Submit</button>
          </div>
        </form>
      </div>
    );
  }
}

export default Register;
