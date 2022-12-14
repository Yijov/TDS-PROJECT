import React from "react";
import bgImage from "../../assets/images/authbg.jpg";
import logo from "../../assets/images/logo.png";
import useAuth from "./useAuth";

const Auth = () => {
  const { API, STATE } = useAuth();

  const pageBgStyle = {
    backgroundImage: `url(${bgImage})`,
    backgroundRepeat: "no-repeat",
    backgroundSize: "cover",
  };

  return (
    <div className="auth page" style={pageBgStyle}>
      <div className="auth-page_franja shadow">
        <img src={logo} alt="Logo" className="auth-logo" />
        <form className="col-2" onSubmit={API.SIGNIN_SUBMIT}>
          <h2 className="text-white mb-2 fs-3 text-center">INICIO</h2>

          <label htmlFor="email" className="text-light required">
            Usuario
          </label>
          <input
            name="email"
            type="text"
            className="form-control mb-2"
            placeholder="ingrese su usuario"
            autoComplete="off"
            value={STATE.credentials.email}
            onChange={API.HANDLE_AUTH_INPUT}
          />

          <label htmlFor="password" className="text-light required">
            Contraseña
          </label>
          <input
            name="password"
            type="password"
            className="form-control mb-2"
            placeholder="ingrese su contraseña"
            autoComplete="off"
            value={STATE.credentials.password}
            onChange={API.HANDLE_AUTH_INPUT}
          />
          <div className="text-light text-center">
            <span>{STATE.authError || <br />}</span>
          </div>

          <button className="btn btn-dark btn-mdc col-12" type="submit">
            Log in
          </button>
        </form>
        <img src={logo} alt="Logo" className="auth-logo" />
      </div>
    </div>
  );
};

export default Auth;
