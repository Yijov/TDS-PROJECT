import io from "socket.io-client";
import APP_CONSTANTS from "../constants/consts";
const severAddress = process.env.REACT_APP_TRACk_API_URI!!;
//const severAddress = APP_CONSTANTS.LOCAL_TRACk_API_URI;
const socket = io(severAddress);
export default socket;
