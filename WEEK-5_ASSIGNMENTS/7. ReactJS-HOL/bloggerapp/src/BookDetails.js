import React from 'react';

const BookDetails = ({ books }) => {
  return (
    <div>
      <h2 style={{ color: 'black' }}>Book Details</h2>
      {books.map(book => (
        <div key={book.id} style={{ marginBottom: '15px' }}>
          <h4 style={{ margin: '5px 0' }}>{book.bname}</h4>
          <p style={{ margin: '0' }}>{book.price}</p>
        </div>
      ))}
    </div>
  );
};

export default BookDetails;
