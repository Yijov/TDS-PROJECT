import Position from "./Position";
export default interface TripDTO {
  tripId: number;
  route: number;
  from: string;
  position: Position;
  to: string;
  routeId: number;
}
