import React, { useState } from 'react'
import httpClient from '../httpClient'

const SignupPage = () => {
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [confirmedPassword, setConfirmedPassword] = useState("")

  const signUpUser = async () => {
    console.log(email, password, confirmedPassword);

    try {
      const resp = await httpClient.post("//localhost:5000/signup", {
        email, 
        password, 
        confirmed_password: confirmedPassword
      });
      console.log(resp.data);
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
			<h1>Register</h1>
			<input type="email" placeholder="Email" value={email} onChange={(e) => setEmail(e.target.value)} id="" />
			<input type="password" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} id=""/>
			<input type="password" placeholder="Confirm Password" value={confirmedPassword} onChange={(e) => setConfirmedPassword(e.target.value)} id="" />
      <div className="button-container">
				<input type="button" value="Confirm" onClick={signUpUser}/>
				<div className="identity-link">
					Already got an account? <a href="/login">Login here</a>
				</div>
			</div>
		  </form>
    </div>
  )
}

export default SignupPage