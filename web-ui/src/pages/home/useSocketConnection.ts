import React, { useEffect, useState } from "react";
import { io, Socket } from "socket.io-client";
import Trip from "../../models/Trip";
import EVENTS from "../../constants/events";
import socket from "../../connections/WSocket";

export interface ISocketState {
  trips: Trip[];
  error: string;
}
const useSocketConnection = () => {
  const [socketState, setSocketState] = useState<ISocketState>({ trips: [], error: "" });
  const handleUpdate = (response: Trip[]) => {
    setSocketState({ ...socketState, trips: response });
  };

  const HandleEndTrip = (tripID: string | number) => {
    socket.emit(EVENTS.TRIP_END, tripID);
  };

  const HandSetError = (error: string) => {
    setSocketState({ ...socketState, error });
  };

  const HandlePing = () => {
    socket.emit(EVENTS.PING, "Conected");
  };

  useEffect(() => {
    socket.on(EVENTS.UPDATE, (reponse: Trip[]) => handleUpdate(reponse));
    socket.on(EVENTS.TRIP_END_FAIL, () => HandSetError("Operación fallida, porfavor intente mas tarde"));
    socket.on(EVENTS.PONG, (data: string) => console.log(data));
    return function cleanup() {
      socket.off(EVENTS.UPDATE);
      socket.off(EVENTS.TRIP_END_FAIL);
      socket.off(EVENTS.PONG);
    };
  }, []);

  return { socketState, HandleEndTrip, HandlePing, HandSetError };
};
export default useSocketConnection;
