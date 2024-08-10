import React from 'react'

const SignupPageNavbar = () => {
  const navbarHeight = '10vh'
  const stylesDiv = {height: {navbarHeight}, backgroundColor: 'black'}
  const stylesH1 = {textAlign: 'center', color: 'white', fontSize: {navbarHeight}}
  return (
    <div style={stylesDiv}>
      <h1 style={stylesH1}>The signup page</h1>
    </div>
  )
}

export default SignupPageNavbar