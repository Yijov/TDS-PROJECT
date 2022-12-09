import React, { useEffect } from "react";
import Map from "../../components/map/Map";
import UserSearchPannel from "../../components/user_search_pannel/UserSearchPannel";
import Navigation from "../../components/navigation/Navigation";
import { io } from "socket.io-client";

const Home = () => {
  const socket = io("http://localhost:3011/");
  useEffect(() => {
    socket.connect();
  }, []);
  return (
    <div className="home page container">
      <Navigation />
      <div className="row">
        <Map />
        <UserSearchPannel />
      </div>
    </div>
  );
};

export default Home;
