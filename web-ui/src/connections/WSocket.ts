import io from "socket.io-client";
import APP_CONSTANTS from "../constants/consts";
const severAddress = APP_CONSTANTS.TRACk_API_URI;
const socket = io(severAddress);
export default socket;
