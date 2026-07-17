import React, { Component } from 'react';

class EventExamples extends Component {
  constructor(props) {
    super(props);
    this.state = {
      inputValue: '',
      isFocused: false,
      hoverMessage: ''
    };
  }

  handleInputChange = (e) => {
    this.setState({ inputValue: e.target.value });
  }

  handleFocus = () => {
    this.setState({ isFocused: true });
  }

  handleBlur = () => {
    this.setState({ isFocused: false });
  }

  handleMouseEnter = () => {
    this.setState({ hoverMessage: 'Mouse entered!' });
  }

  handleMouseLeave = () => {
    this.setState({ hoverMessage: 'Mouse left!' });
  }

  handleClick = (e) => {
    e.preventDefault();
    alert('Button clicked! Input value: ' + this.state.inputValue);
  }

  render() {
    return (
      <div style={{ textAlign: 'center', marginTop: '50px' }}>
        <h2>Event Examples</h2>
        <form onSubmit={this.handleClick} style={{ margin: '20px auto', width: '300px', border: '1px solid black', padding: '20px' }}>
          <div style={{ marginBottom: '15px' }}>
            <label>Input Text (onChange, onFocus, onBlur): </label><br/>
            <input 
              type="text" 
              value={this.state.inputValue} 
              onChange={this.handleInputChange}
              onFocus={this.handleFocus}
              onBlur={this.handleBlur}
              style={{ backgroundColor: this.state.isFocused ? 'lightyellow' : 'white' }}
            />
            <p>Input Value: {this.state.inputValue}</p>
          </div>
          <div 
            onMouseEnter={this.handleMouseEnter} 
            onMouseLeave={this.handleMouseLeave}
            style={{ padding: '10px', backgroundColor: 'lightblue', marginBottom: '15px' }}
          >
            Hover over me! (onMouseEnter, onMouseLeave)
            <p>{this.state.hoverMessage}</p>
          </div>
          <button type="submit">Submit (onClick/onSubmit)</button>
        </form>
      </div>
    );
  }
}

export default EventExamples;
