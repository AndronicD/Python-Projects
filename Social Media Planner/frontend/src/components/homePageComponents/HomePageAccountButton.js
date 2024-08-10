import React from 'react';
import { useNavigate } from 'react-router-dom';

const HomePageButton = ({ buttonText, redirect, doWhenClicked = () => {} }) => {
  const navigate = useNavigate();

  const handleClick = (e) => {
    e.preventDefault(); // prevent default navigation
    doWhenClicked();
    navigate(redirect);
  };

  return (
    <div style={{ textAlign: 'center' }}>
      <a href={redirect} onClick={handleClick}>
        <button className="HomePageButtonButton">{buttonText}</button>
      </a>
    </div>
  );
};

export default HomePageButton;
