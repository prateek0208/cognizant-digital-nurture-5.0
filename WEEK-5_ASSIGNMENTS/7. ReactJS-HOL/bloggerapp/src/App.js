import React from 'react';
import './App.css';
import BookDetails from './BookDetails';
import BlogDetails from './BlogDetails';
import CourseDetails from './CourseDetails';

const books = [
  { id: 101, bname: 'Master React', price: 670 },
  { id: 102, bname: 'Deep Dive into Angular 11', price: 800 },
  { id: 103, bname: 'Mongo Essentials', price: 450 }
];

function App() {
  return (
    <div className="App" style={{ display: 'flex', justifyContent: 'center', marginTop: '50px', textAlign: 'left', fontFamily: 'Arial, sans-serif' }}>
      <div style={{ padding: '0 40px' }}>
        <CourseDetails />
      </div>
      <div style={{ borderLeft: '3px solid green', height: '300px' }}></div>
      <div style={{ padding: '0 40px' }}>
        <BookDetails books={books} />
      </div>
      <div style={{ borderLeft: '3px solid green', height: '300px' }}></div>
      <div style={{ padding: '0 40px' }}>
        <BlogDetails />
      </div>
    </div>
  );
}

export default App;
