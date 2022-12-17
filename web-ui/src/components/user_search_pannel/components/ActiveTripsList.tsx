import React from "react";
import ITripUpdateResponse from "../../../models/ITripUpdateResponse";

const TripCardComponent: React.FC<{ trip: ITripUpdateResponse }> = ({ trip }) => {
  return (
    <div
      onClick={() => {
        navigator.clipboard.writeText(trip.id.toString());
      }}
      className="active-trip-list-customer-card bg-success"
    >{`${trip.id} ${trip.from} - ${trip.to}   ${trip.time}`}</div>
  );
};
const ActiveTripsList: React.FC<{ trips: ITripUpdateResponse[] }> = ({ trips }) => {
  return (
    <div className="active-trip-list">
      <div className="active-trip-list_header">ACTIVE TRIPS</div>
      {trips && trips.map((trip) => <TripCardComponent trip={trip} />)}
    </div>
  );
};

export default ActiveTripsList;
