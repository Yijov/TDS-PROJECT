import Position from "./Position";
interface ITripUpdateResponse {
  id: number;
  route: number;
  position: Position;
  to: string;
  from: string;
  time: string;
}

export default ITripUpdateResponse;
