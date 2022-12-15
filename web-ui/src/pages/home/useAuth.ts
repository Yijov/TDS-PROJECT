import { useState, useEffect } from "react";
import Axios from "axios";
import Cookies from "universal-cookie";
import { useNavigate } from "react-router-dom";
import APP_CONSTANTS from "../../constants/consts";

const useAuth = () => {
  // autho state
  const [auth, setAuthState] = useState(true);

  const Navigate = useNavigate();

  const cookies = new Cookies();

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
    if (window.confirm("¿Do you wish to log out?")) {
      try {
        await Axios.get(APP_CONSTANTS.TRACk_API_URI_AUTH);
        setAuthState(false);
      } catch (error) {
        console.error(error);
      }
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
