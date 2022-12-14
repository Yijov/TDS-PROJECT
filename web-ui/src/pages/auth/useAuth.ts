import react, { useState, useEffect } from "react";
import Axios, { AxiosError } from "axios";
import ResourceAPI from "../../connections/api_connection/ResourceAPI";
import IAuthCredentials from "../../models/authCredentials";
import Cookies from "universal-cookie";
import APP_CONSTANTS from "../../constants/consts";
import IAPIResponse from "./../../connections/api_connection/IAPIReaponse";
import { useNavigate } from "react-router-dom";

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

  const Api = new ResourceAPI();

  const AUTH_API_URI = APP_CONSTANTS.TRACk_API_URI_AUTH;

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
      const response = await Api.GET_SIGNOUT();
      setAuthState({ ...AuthState, authinticated: false });
    }
  };

  //log in submision function

  const SIGNIN_SUBMIT = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const response = await Axios.post(AUTH_API_URI, credentials);
      response.data.success
        ? setAuthState({ ...AuthState, authinticated: true })
        : setAuthState({ authError: "incorrect user or password", authinticated: false });
    } catch (error) {
      const err = error as AxiosError<IAPIResponse>;
      setAuthState({ ...AuthState, authError: err.response!!.data.message });
      console.error(err);
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
