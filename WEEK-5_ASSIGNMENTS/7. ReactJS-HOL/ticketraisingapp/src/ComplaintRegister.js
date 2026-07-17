import React, { Component } from 'react';

class ComplaintRegister extends Component {
  constructor(props) {
    super(props);
    this.state = {
      ename: '',
      complaint: '',
      NumberHolder: ''
    };
  }

  handleChange = (event) => {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleSubmit = (event) => {
    event.preventDefault();
    const transactionId = Math.floor(Math.random() * 100);
    this.setState({ NumberHolder: transactionId }, () => {
      var msg = "Thanks " + this.state.ename + '\nYour Complaint was Submitted.\nTransaction ID is: ' + this.state.NumberHolder;
      alert(msg);
    });
  }

  render() {
    return (
      <div style={{ textAlign: 'center', marginTop: '50px' }}>
        <h2 style={{ color: 'red' }}>Register your complaints here!!!</h2>
        <form onSubmit={this.handleSubmit} style={{ display: 'inline-block', textAlign: 'left' }}>
          <div style={{ marginBottom: '10px' }}>
            <label style={{ display: 'inline-block', width: '100px' }}>Name: </label>
            <input type="text" name="ename" onChange={this.handleChange} />
          </div>
          <div style={{ marginBottom: '10px' }}>
            <label style={{ display: 'inline-block', width: '100px', verticalAlign: 'top' }}>Complaint: </label>
            <textarea name="complaint" onChange={this.handleChange} rows="4"></textarea>
          </div>
          <div style={{ textAlign: 'center' }}>
            <button type="submit">Submit</button>
          </div>
        </form>
      </div>
    );
  }
}

export default ComplaintRegister;
