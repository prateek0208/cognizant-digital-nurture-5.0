import React from 'react';
import styles from './CohortDetails.module.css';

const CohortDetails = ({ cohortName, code, startedOn, status, coach, trainer }) => {
  const statusColor = status.toLowerCase() === 'ongoing' ? 'green' : 'blue';

  return (
    <div className={styles.box}>
      <h3 style={{ color: statusColor, fontSize: '16px' }}>{cohortName} - {code}</h3>
      <div style={{ fontSize: '14px', lineHeight: '1.5' }}>
        <div style={{ display: 'flex', flexDirection: 'column', marginBottom: '10px' }}>
          <dt>Started On</dt>
          <dd style={{ margin: '0 0 0 20px' }}>{startedOn}</dd>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', marginBottom: '10px' }}>
          <dt>Current Status</dt>
          <dd style={{ margin: '0 0 0 20px' }}>{status}</dd>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', marginBottom: '10px' }}>
          <dt>Coach</dt>
          <dd style={{ margin: '0 0 0 20px' }}>{coach}</dd>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', marginBottom: '10px' }}>
          <dt>Trainer</dt>
          <dd style={{ margin: '0 0 0 20px' }}>{trainer}</dd>
        </div>
      </div>
    </div>
  );
};

export default CohortDetails;
