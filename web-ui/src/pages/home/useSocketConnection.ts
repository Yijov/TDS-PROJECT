import React, { useEffect, useState } from "react";
import EVENTS from "../../constants/events";
import socket from "../../connections/WSocket";
import ITripUpdateResponse from "../../models/ITripUpdateResponse";

export interface ISocketState {
  trips: ITripUpdateResponse[];
  error: string;
}
const useSocketConnection = () => {
  const [socketState, setSocketState] = useState<ISocketState>({ trips: [], error: "" });
  const handleUpdate = (response: ITripUpdateResponse[]) => {
    console.log(response);

    setSocketState({ ...socketState, trips: response });
  };

  const HandleEndTrip = (tripID: string | number) => {
    socket.emit(EVENTS.TRIP_END, tripID);
  };

  const HandSetError = (error: string) => {
    setSocketState({ ...socketState, error });
  };

  const HandlePing = (data: any = "conected") => {
    socket.emit(EVENTS.PING, data);
  };

  useEffect(() => {
    socket.on(EVENTS.UPDATE, (reponse: ITripUpdateResponse[]) => handleUpdate(reponse));
    socket.on(EVENTS.TRIP_END_FAIL, () => HandSetError("Operación fallida, porfavor intente mas tarde"));
    socket.on(EVENTS.PONG, (data: string) => console.log(data));
    return function cleanup() {
      socket.off(EVENTS.UPDATE);
      socket.off(EVENTS.TRIP_END_FAIL);
      socket.off(EVENTS.PONG);
    };
  }, []);

  return { STATE: socketState, API: { HandleEndTrip, HandlePing, HandSetError } };
};
export default useSocketConnection;
