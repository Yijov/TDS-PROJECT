import React from "react";
import GoogleMapReact from "google-map-react";
import MapMarker from "../map_marker/MapMarker";
import Position from "../../models/Position";
import ITripUpdateResponse from "../../models/ITripUpdateResponse";

const Map: React.FC<{ trips: ITripUpdateResponse[] }> = ({ trips }) => {
  const defaultProps = {
    center: {
      lat: 18.5070955,
      lng: -69.8806138,
    },
    zoom: 11.4,
  };

  return (
    // Important! Always set the container height explicitly
    <div style={{ height: "65vh", width: "75%", marginTop: "2rem" }}>
      <GoogleMapReact
        bootstrapURLKeys={{ key: process.env.REACT_APP_API_KEY!! }}
        defaultCenter={defaultProps.center}
        defaultZoom={defaultProps.zoom}
      >
        {trips &&
          trips.map((trip) => (
            <MapMarker
              lat={trip.position.lat}
              lng={trip.position.lon}
              desde={trip.from || "ITLA"}
              hacia={trip.to || "PINTURA"}
              hora={trip.time || "2:35pm"}
              key={trip.id}
            />
          ))}
      </GoogleMapReact>
    </div>
  );
};

export default Map;

{
  /* <MapMarker lat={18.47825} lng={-69.9420575} desde={"ITLA"} hacia={"PINTURA"} hora={"4:15pm"} />
        <MapMarker lat={18.47692} lng={-69.9446055} desde={"ITLA"} hacia={"PINTURA"} hora={"4:15pm"} />
        <MapMarker lat={18.47825442548412} lng={-69.9420575500183} desde={"ITLA"} hacia={"PINTURA"} hora={"4:15pm"} />
       <MapMarker lat={18.454675169897023} lng={-69.66245077342033} desde={"ITLA"} hacia={"PINTURA"} hora={"4:15pm"} />
        <MapMarker lat={18.45065190007404} lng={-69.97414165296892} desde={"PINTURA"} hacia={"ITLA"} hora={"2:15pm"} /> */
}
