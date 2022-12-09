import React, { ChangeEvent, FormEvent, useState } from "react";
import bgImage from "../../assets/images/authbg.jpg";
import logo from "../../assets/images/logo.png";
import ResourceAPI from "../../connections/ResourceAPI";
import IAuthCredentials from "../../models/authCredentials";

const Auth = () => {
  const [credentials, setCredentials] = useState<IAuthCredentials>({ usuario: "", password: "" });
  //const [AuthError, setAuthError] = useState("");

  const handleAurhSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    await ResourceAPI.logIn(credentials);
  };

  const handleAuthInput = async (event: ChangeEvent<HTMLInputElement>) => {
    event.preventDefault();
    //setAuthError("");
    let { name, value } = event.target;
    setCredentials({ ...credentials, [name]: value });
  };

  const pageBgStyle = {
    backgroundImage: `url(${bgImage})`,
    backgroundRepeat: "no-repeat",
    backgroundSize: "cover",
  };

  return (
    <div className="auth page" style={pageBgStyle}>
      <div className="auth-page_franja shadow">
        <img src={logo} alt="Logo" className="auth-logo" />
        <form className="col-2" onSubmit={handleAurhSubmit}>
          <h2 className="text-white mb-2 fs-3 text-center">INICIO</h2>

          <label htmlFor="usuario" className="text-light">
            Usuario
          </label>
          <input
            name="usuario"
            type="text"
            className="form-control mb-2"
            placeholder="ingrese su usuario"
            value={credentials.usuario}
            onChange={handleAuthInput}
          />

          <label htmlFor="contraseña" className="text-light">
            Contraseña
          </label>
          <input
            name="password"
            type="password"
            className="form-control mb-2"
            placeholder="ingrese su contraseña"
            value={credentials.password}
            onChange={handleAuthInput}
          />

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
