import React from 'react'
import { useState, useEffect } from 'react'
import httpClient from '../httpClient'
import logo from '../images/logo.png'
import { ClipLoader } from 'react-spinners'

const HomePage = () => {
  // checking if change happens on host with this comment

  const [fetching, setFetching] = useState(true);

  useEffect(() => {
    (async () => {
      try {
        console.log("getting user data...");
        const resp = await httpClient.get("//localhost:5000/main");
        console.log("got user data.");

        window.location.href = "/main";
      } catch (error) {
        if (/40./.test(error.response.status)) {
          setFetching(false);
          console.log("No session cookie or invalid session cookie");
        }
      }
    })();
  }, []);

  return (
    <div className='HomePageDiv'>
      {fetching == true ?
        <>
          <div style={{ width: '100vw', height: '100vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', }}>
            <ClipLoader loading={true} size={200} color={'green'} />
          </div>
        </> :
        (
          <>
            <div className="container">
              <div className="logo">
                <img src={logo} alt="Logo" />
              </div>
              <div className="buttons">
                <a href="/login"><button className="login-btn">Log In</button></a>
                <a href="/signup"><button className="signup-btn">Sign Up</button></a>
              </div>
            </div>
          </>
        )
      }
    </div>
  )
}

export default HomePage