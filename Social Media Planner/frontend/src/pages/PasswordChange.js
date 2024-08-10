import React, { useState } from 'react'
import httpClient from '../httpClient'
import { useParams } from 'react-router-dom'

const PasswordChange = () => {
    const [new_password, setPassword] = useState("")
    const [new_confirmed_password, setConfirmedPassword] = useState("")
    const params = useParams()
    const url_extension = params.url_extension

  const setNewPassword = async () => {
    console.log(new_password, new_confirmed_password);

    try {
      const resp = await httpClient.post("//localhost:5000/password_change/" + url_extension, {
        new_password,
        new_confirmed_password,  
      });

      console.log(resp.data)
      alert(resp.data.message);
      window.location.href = "/";
    } catch (error) {
      console.log(error.response)

      if (/40./.test(error.response.status)) {
        alert(error.response.data.error);
      } 
    }
  }

  return (
    <div className='IdentityPageDiv'>
      <form>
			<h1>Reset Password</h1>
			<input type="password" placeholder="Password" value={new_password} onChange={(e) => setPassword(e.target.value)} id=""/>
			<input type="password" placeholder="Confirm Password" value={new_confirmed_password} onChange={(e) => setConfirmedPassword(e.target.value)} id="" />
      <div className="button-container">
				<input type="button" value="Confirm" onClick={setNewPassword}/>
			</div>
		  </form>
    </div>
  )
}

export default PasswordChange