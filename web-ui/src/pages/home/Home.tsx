import React from "react";
import Map from "../../components/map/Map";
import UserSearchPannel from "../../components/user_search_pannel/UserSearchPannel";
import Navigation from "../../components/navigation/Navigation";

const Home = () => {
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
