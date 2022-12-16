import Position from "./Position";
import TripDTO from "./TripDTO";

class Trip {
  private TripId: number;
  private RouteId: number;
  private From: string;
  private To: string;
  private Position: Position = { tripId: 0, lat: 0, lon: 0 };

  constructor(dto: TripDTO) {
    this.TripId = dto.tripId;
    this.RouteId = dto.routeId;
    this.From = dto.from;
    this.To = dto.to;
  }
  get Id() {
    return this.TripId;
  }

  get position() {
    return this.Position;
  }

  getTrackInfo = () => {
    let returnable = {
      id: this.TripId,
      route: this.RouteId,
      position: this.Position,
      to: this.To,
      from: this.From,
    };
    return returnable;
  };

  updatePosition = (position: Position) => {
    this.Position = position;
  };
}

export default Trip;
