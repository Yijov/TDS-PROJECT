import React from "react";
import Map from "../../components/map/Map";
import UserSearchPannel from "../../components/user_search_pannel/UserSearchPannel";
import Navigation from "../../components/navigation/Navigation";
import useSocketConnection from "./useSocketConnection";
import useAuth from "./useAuth";

const Home = () => {
  const { STATE, API } = useSocketConnection();
  const { SIGNOUT } = useAuth();

  return (
    <div className="home page container">
      <Navigation soutFunction={SIGNOUT} />
      <div className="row">
        <Map trips={STATE.trips} />
        <UserSearchPannel trips={STATE.trips} socketAPI={API} />
      </div>
    </div>
  );
};

export default Home;
