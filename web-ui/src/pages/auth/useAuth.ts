import react, { useState, useEffect } from "react";
import Axios, { AxiosError } from "axios";
import IAuthCredentials from "../../models/authCredentials";
import Cookies from "universal-cookie";
import { useNavigate } from "react-router-dom";
import APP_CONSTANTS from "../../constants/consts";

Axios.defaults.withCredentials = true;

const useAuth = () => {
  // autho state
  const [AuthState, setAuthState] = useState<{
    authinticated: boolean;
    authError: string;
  }>({ authinticated: false, authError: "" });

  const [credentials, setCredentials] = useState<IAuthCredentials>({
    email: "",
    password: "",
  });

  const Navigate = useNavigate();

  const cookies = new Cookies();

  //vaidate if user is loged in
  const VALIDATE_SIGNED_IN = async () => {
    const LogToken = await cookies.get("LogToken");
    if (!LogToken) {
      setAuthState({ ...AuthState, authinticated: false });
    } else {
      setAuthState({ ...AuthState, authinticated: true });
      Navigate("/Home");
    }
  };

  //log out function
  const SIGNOUT = async (e: React.MouseEvent) => {
    if (window.confirm("¿Are you sure that you are loging out?")) {
      try {
        await Axios.get(APP_CONSTANTS.TRACk_API_URI_AUTH);
        setAuthState({ ...AuthState, authinticated: false });
      } catch (error) {
        console.error(error);
      }
    }
  };

  //log in submision function

  const SIGNIN_SUBMIT = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const response = await Axios.post(APP_CONSTANTS.TRACk_API_URI_AUTH, credentials);
      response.data.success
        ? setAuthState({ ...AuthState, authinticated: true })
        : setAuthState({ authError: "incorrect user or password", authinticated: false });
    } catch (error) {
      const err = error as AxiosError<{ message: string }>;
      err.isAxiosError
        ? setAuthState({ ...AuthState, authError: "usuario o contraseña incorrectos" })
        : console.error(err);
    }
  };

  // to handle inpust of log in and register

  const HANDLE_AUTH_INPUT = (e: React.ChangeEvent<HTMLInputElement>) => {
    e.preventDefault();
    setAuthState({ ...AuthState, authError: "" });
    let { name, value } = e.target;
    setCredentials({ ...credentials, [name]: value });
  };

  //validate log in on load
  useEffect(() => {
    VALIDATE_SIGNED_IN(); // eslint-disable-next-line
  }, [AuthState.authinticated]);

  //abstracting before exporting
  //the API contains all the methods to modify the state and the STATE contains all relavant pieces of stata
  const AUTH_CONTEXT = {
    STATE: { ...AuthState, credentials },
    API: {
      SIGNIN_SUBMIT,
      HANDLE_AUTH_INPUT,
      SIGNOUT,
    },
  };

  //Exporting all the information
  return AUTH_CONTEXT;
};

export default useAuth;
