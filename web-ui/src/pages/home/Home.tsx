import React from "react";
import Map from "../../components/map/Map";
import UserSearchPannel from "../../components/user_search_pannel/UserSearchPannel";
import Navigation from "../../components/navigation/Navigation";
import useSocketConnection from "./useSocketConnection";
import useAuth from "./useAuth";

const Home = () => {
  const { socketState, HandlePing } = useSocketConnection();
  const { SIGNOUT } = useAuth();

  return (
    <div className="home page container">
      <Navigation soutFunction={SIGNOUT} />
      <button onClick={HandlePing}>PING</button>
      <div className="row">
        <Map trips={socketState.trips} />
        <UserSearchPannel trips={socketState.trips} />
      </div>
    </div>
  );
};

export default Home;
