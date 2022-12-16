import Position from "./Position";
import TripDTO from "./TripDTO";

class Trip {
  private TripId: number = 306;
  private RouteId: number = 1;
  private From: string = "ITLA";
  private To: string = "27 de Feb";
  private Position: Position = { tripId: 0, lat: "", lon: "" };
  private startTime: string;

  constructor(dto: TripDTO) {
    this.TripId = dto.tripId;
    this.RouteId = dto.routeId;
    this.From = dto.from;
    this.To = dto.to;
    this.startTime = new Date().toLocaleTimeString();
  }
  get Id() {
    return this.TripId;
  }

  get position() {
    return this.Position;
  }

  getTrackInfo = async () => {
    let returnable = {
      id: this.TripId,
      route: this.RouteId,
      position: this.Position,
      to: this.To,
      from: this.From,
      time: this.startTime,
    };
    return returnable;
  };

  updatePosition = async (position: Position) => {
    this.Position = position;
  };
}

export default Trip;
