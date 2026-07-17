import React from 'react';

const CourseDetails = () => {
  return (
    <div>
      <h2 style={{ color: 'black' }}>Course Details</h2>
      <div style={{ marginBottom: '15px' }}>
        <h4 style={{ margin: '5px 0' }}>Angular</h4>
        <p style={{ margin: '0', fontSize: '14px', fontWeight: 'bold' }}>4/5/2021</p>
      </div>
      <div>
        <h4 style={{ margin: '5px 0' }}>React</h4>
        <p style={{ margin: '0', fontSize: '14px', fontWeight: 'bold' }}>6/3/20201</p>
      </div>
    </div>
  );
};

export default CourseDetails;
