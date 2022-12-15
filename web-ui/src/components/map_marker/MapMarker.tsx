import React from "react";
import { BiBus } from "react-icons/bi";

const MapMarker: React.FC<{ hora: string; lat: number; lng: number; desde: string; hacia: string }> = ({
  desde,
  hacia,
  hora,
}) => {
  return (
    <div className="map-marker">
      <BiBus />
      <span className="map-marker_text">
        <p>
          {desde}-{hacia}
        </p>
        <p>{hora}</p>
      </span>
    </div>
  );
};

export default MapMarker;
