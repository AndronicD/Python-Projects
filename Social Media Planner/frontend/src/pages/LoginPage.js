import React, { useState } from 'react'
import httpClient from '../httpClient'

const LoginPage = () => {
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")

  const logInUser = async () => {
    console.log(email, password);

    try {
      const resp = await httpClient.post("//localhost:5000/login", {
        email, 
        password,
      });
      console.log(resp.data)
      window.location.href = "/main";
    } catch (error) {
      console.log(error.response);
      if (/40./.test(error.response.status)) {
        alert(error.response.data.error);
      }
    }
  }

  return (
    <div className='IdentityPageDiv'>
      <form>
        <h1>Log In</h1>
        <input type="email" placeholder="Email" value={email} onChange={(e) => setEmail(e.target.value)} id="" />
        <input type="password" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} id=""/>
        <div className="button-container">
          <input type="button" value="Confirm" onClick={logInUser}/>
          <div className="identity-link">
            Forgot Password? <a href="/recovery">Recover Account</a>
          </div>
          <div className="identity-link">
            Don't have an account? <a href="/signup">Sign Up Here</a>
          </div>
        </div>
      </form>
    </div>
  )
}

export default LoginPage