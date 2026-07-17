import React from 'react';

const BlogDetails = () => {
  return (
    <div>
      <h2 style={{ color: 'black' }}>Blog Details</h2>
      <div style={{ marginBottom: '15px' }}>
        <h4 style={{ margin: '5px 0' }}>React Learning</h4>
        <p style={{ margin: '0', fontSize: '14px' }}>Stephen Biz</p>
        <p style={{ margin: '5px 0', fontSize: '12px', color: 'gray' }}>Welcome to learning React!</p>
      </div>
      <div>
        <h4 style={{ margin: '5px 0' }}>Installation</h4>
        <p style={{ margin: '0', fontSize: '14px' }}>Schewzdenier</p>
        <p style={{ margin: '5px 0', fontSize: '12px', color: 'gray' }}>You can install React from npm.</p>
      </div>
    </div>
  );
};

export default BlogDetails;
