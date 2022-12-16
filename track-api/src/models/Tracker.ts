import Position from "./Position";
import TripDTO from "./TripDTO";
import Trip from "./Trip";

class Tracker {
  private trips: Trip[] = [];

  constructor() {}

  StartTrip = (trip: TripDTO) => {
    let creted = new Trip(trip);
    this.trips.push(creted);
  };

  EndTrip(tripId: number) {
    let indexToDelete = this.trips.findIndex((x) => x.Id == tripId);
    this.trips.splice(indexToDelete, 1);
  }

  updateTripPosition = (position: Position) => {
    let indexToDelete = this.trips.findIndex((x) => x.Id == position.tripId);
    this.trips[indexToDelete]?.updatePosition(position);
  };

  Track = () => {
    return this.trips.map((t) => t.getTrackInfo());
  };
}

export default Tracker;
