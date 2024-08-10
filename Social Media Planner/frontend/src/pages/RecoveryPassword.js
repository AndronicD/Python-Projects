import React, { useState } from 'react'
import httpClient from '../httpClient'

const RecoveryPassword = () => {
  const [email, setEmail] = useState("")
  const [clicked, setClicked] = useState(false)

  const recoverAccount = async () => {
    console.log(email);
    setClicked(true)

    try {
      const resp = await httpClient.post("//localhost:5000/recovery", {
        email,  
      });
      console.log(resp)
      alert(resp.data.message);
      window.location.href = "/";
    } catch (error) {
      setClicked(false)
      if (/40./.test(error.response.status)) {
        alert(error.response.data.error);
      }
    }
  }

  return (
    <div className='IdentityPageDiv'>
      <form>
        <h1>Recover Account</h1>
        <input type="email" placeholder="Email" value={email} onChange={(e) => setEmail(e.target.value)} id="" />
        <div className="button-container">
          {!clicked && <input type="button" value="Confirm" onClick={recoverAccount}/>}
        </div>
      </form>
    </div>
  )
}

export default RecoveryPassword