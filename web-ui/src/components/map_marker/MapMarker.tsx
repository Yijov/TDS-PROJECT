import React from "react";

const MapMarker: React.FC<{ text: string; lat: number; lng: number }> = ({ text }) => <div>{text}</div>;

export default MapMarker;