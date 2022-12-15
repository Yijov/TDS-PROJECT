import io from "socket.io-client";
const severAddress = process.env.REACT_APP_TRACk_API_URI!!;
const socket = io(severAddress);
export default socket;
