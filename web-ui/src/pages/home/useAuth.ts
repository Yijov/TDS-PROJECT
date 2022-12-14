import react, { useState, useEffect } from "react";
import Axios, { AxiosError } from "axios";
import ResourceAPI from "../../connections/api_connection/ResourceAPI";
import IAuthCredentials from "../../models/authCredentials";
import Cookies from "universal-cookie";
import APP_CONSTANTS from "../../constants/consts";
import IAPIResponse from "./../../connections/api_connection/IAPIReaponse";
import { Link, useNavigate, useLocation } from "react-router-dom";

Axios.defaults.withCredentials = true;

const useAuth = () => {
  // autho state
  const [auth, setAuthState] = useState(true);

  const Navigate = useNavigate();

  const cookies = new Cookies();

  const Api = new ResourceAPI();

  //vaidate if user is loged in
  const VALIDATE_SIGNED_IN = async () => {
    const LogToken = await cookies.get("LogToken");
    if (!LogToken) {
      setAuthState(false);
      Navigate("/auth");
    } else {
      setAuthState(true);
    }
  };

  //log out function
  const SIGNOUT = async (e: React.MouseEvent) => {
    if (window.confirm("¿Are you sure that you are loging out?")) {
      const response = await Api.GET_SIGNOUT();
      setAuthState(false);
    }
  };

  //validate log in on load
  useEffect(() => {
    VALIDATE_SIGNED_IN();
    // eslint-disable-next-line
  }, [auth]);

  //abstracting before exporting
  //the API contains all the methods to modify the state and the STATE contains all relavant pieces of stata
  const AUTH_CONTEXT = { SIGNOUT };

  //Exporting all the information
  return AUTH_CONTEXT;
};

export default useAuth;
