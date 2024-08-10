import React, { useState, useEffect } from 'react'
import { LoginSocialFacebook, LoginSocialInstagram } from 'reactjs-social-login'
import { FacebookLoginButton, InstagramLoginButton } from 'react-social-login-buttons'
import httpClient from '../httpClient'
import { ClipLoader } from 'react-spinners'

const MainPage = () => {
  const [user, setUser] = useState(false);

  const resolveFuncFacebook = async (response) => {
    console.log(response);
    try {
      const resp = await httpClient.post("//localhost:5000/facebook_login", {
        accessToken: response.data.accessToken
      });
      
      console.log("Sent facebook accessToken to the server");
    } catch (error) {
      console.log("Something went wrong with trying to send the facebook login " + 
        "accessToken to the server");
    }
    
  }

  const rejectFuncFacebook = (error) => {
    console.log(error);
  }
  
  const resolveFuncInstagram = (response) => {
    console.log(response)
  }
  
  const rejectFuncInstagram = (error) => {
    console.log(error)
  }

  const logoutUser = async () => {
    try {
      console.log("Logging out...");
      await httpClient.post("//localhost:5000/logout");
      console.log("Logged out.");
      window.location.href = "/";
    } catch (error) {
      console.log("Unable to log out");

    }
  }

  useEffect(() => {
    (async () => {
      try {
        console.log("getting user data...");
        const resp = await httpClient.get("//localhost:5000/main");
        console.log("got user data.");
      } catch (error) {
        if (/40./.test(error.response.status)) {
          console.log(error.response.data.error);
        }
      } finally {
        setUser(true)
      }
    })();
  }, []);

  return (
    <div className="MainPageDiv">
      {user == false ?
        (<>
          <div style={{ width: '100vw', height: '100vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
            <ClipLoader loading={true} size={200} color={'green'} />
          </div>
        </>) :
        (<>
          <button id="loginTwitter">Login with Twitter</button>
          <LoginSocialFacebook
            appId='951803645868211'
            onResolve={resolveFuncFacebook}
            onReject={rejectFuncFacebook}
            scope="pages_manage_posts"
          >
            <FacebookLoginButton />
          </LoginSocialFacebook>
          <LoginSocialInstagram
            onResolve={resolveFuncInstagram}
            onReject={rejectFuncInstagram}
          >
            <InstagramLoginButton />
          </LoginSocialInstagram>
          <button id="loginInstagram">Login with Instagram</button>
          <button id="makePost">Make a Post</button>
          <button id="logOut" onClick={logoutUser}>Log Out</button>
        </>)
      }

    </div >
  )
}

export default MainPage