import React from "react";
import GoogleMapReact from "google-map-react";

const AnyReactComponent: React.FC<{ text: string; lat: number; lng: number }> = ({ text }) => <div>{text}</div>;

export default function Map() {
  const defaultProps = {
    center: {
      lat: 	18.5090163,
      lng: -69.8561,
    },
    zoom: 11.5,
  };

  return (
    // Important! Always set the container height explicitly
    <div  style={{ height: "65vh", width: "75%", marginTop:"2rem" }}>
      <GoogleMapReact
        bootstrapURLKeys={{ key: "AIzaSyBKMV5ijv9Y3euwLYLKp0xu1t1k6ziivCQ" }}
        defaultCenter={defaultProps.center}
        defaultZoom={defaultProps.zoom}
      >
        <AnyReactComponent lat={18.4498609} lng={-69.9772554} text="My Marker" />
        
      </GoogleMapReact>
    </div>
  );
}

//