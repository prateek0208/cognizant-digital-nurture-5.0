import React from 'react';

const Greeting = ({ isLoggedIn }) => {
  if (isLoggedIn) {
    return <h2>Welcome back!</h2>;
  }
  return <h2>Please sign up.</h2>;
};

export default Greeting;
