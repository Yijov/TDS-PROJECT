import Position from "./Position";
export default interface TripDTO {
  tripId: number;
  route: string;
  from: string;
  position: Position;
  to: string;
  routeId: number;
}
