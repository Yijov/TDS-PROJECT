import React from 'react'
import bgImage from "../../assets/images/authbg.jpg"
import logo from "../../assets/images/logo.png"


const Auth = () => {
  return (
    <div className='auth page' 
    style={{
      backgroundImage: `url(${bgImage})`, 
      backgroundRepeat:'no-repeat',
      backgroundSize:"cover"
    }}
    > 
   <div className="auth-page_franja shadow">
   <img src={logo} alt="Logo" className="auth-logo" />
    <form className='col-2' action="">
    <h2 className='text-white mb-2 fs-3 text-center'>INICIO</h2>
    <label htmlFor="usuario" className='text-light'>Usuario</label>
    <input name='usuario' type="text" className='form-control mb-2' placeholder='ingrese su usuario' />

    <label htmlFor="contraseña" className='text-light'>Contraseña</label>
    <input name='contraseña' type="password" className='form-control mb-2' placeholder='ingrese su contraseña' />

    <button className='btn btn-dark btn-mdc col-12' type="submit">Log in</button>
    </form>
    <img src={logo} alt="Logo" className="auth-logo" />
   </div>
    </div>
  )
}

export default Auth