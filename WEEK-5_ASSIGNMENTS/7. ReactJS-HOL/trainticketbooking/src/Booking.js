import React, { Component } from 'react';

class Booking extends Component {
  constructor(props) {
    super(props);
    this.state = {
      trainName: '',
      trainNumber: '',
      passengerName: ''
    };
  }

  handleChange = (e) => {
    this.setState({ [e.target.name]: e.target.value });
  }

  handleSubmit = (e) => {
    e.preventDefault();
    console.log(`Success! Booking confirmed for ${this.state.passengerName} on ${this.state.trainName} (Train No: ${this.state.trainNumber})`);
    alert(`Success! Booking confirmed for ${this.state.passengerName} on ${this.state.trainName} (Train No: ${this.state.trainNumber})`);
  }

  render() {
    return (
      <div style={{ textAlign: 'center', marginTop: '50px' }}>
        <h2>Train Ticket Booking</h2>
        <form onSubmit={this.handleSubmit} style={{ display: 'inline-block', textAlign: 'left', border: '1px solid black', padding: '20px' }}>
          <div style={{ marginBottom: '10px' }}>
            <label style={{ display: 'inline-block', width: '150px' }}>Passenger Name: </label>
            <input type="text" name="passengerName" onChange={this.handleChange} value={this.state.passengerName} required />
          </div>
          <div style={{ marginBottom: '10px' }}>
            <label style={{ display: 'inline-block', width: '150px' }}>Train Name: </label>
            <input type="text" name="trainName" onChange={this.handleChange} value={this.state.trainName} required />
          </div>
          <div style={{ marginBottom: '10px' }}>
            <label style={{ display: 'inline-block', width: '150px' }}>Train Number: </label>
            <input type="text" name="trainNumber" onChange={this.handleChange} value={this.state.trainNumber} required />
          </div>
          <div style={{ textAlign: 'center', marginTop: '20px' }}>
            <button type="submit">Submit</button>
          </div>
        </form>
      </div>
    );
  }
}

export default Booking;
