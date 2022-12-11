import React, { useEffect } from "react";
import { io } from "socket.io-client";
import EVENTS from "../../constants/events";
import Trip from "../../models/Trip";

const Map = () => {
  const socket = io("http://localhost:3011/");

  const testEmit = () => {
    socket.emit("test", "carlos");
  };
  useEffect(() => {
    socket.on(EVENTS.UPDATE, (trips: Trip[]) => {
      console.log("app");
    });
  }, []);

  return (
    <div className="map m-1 bg-info col-8">
      <button onClick={testEmit}>TEST</button>
    </div>
  );
};

export default Map;
