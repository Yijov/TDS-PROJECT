import Position from "./Position";
import TripDTO from "./TripDTO";
import Trip from "./Trip";

class Tracker {
  private trips: Trip[] = [];

  constructor() {}

  StartTrip = async (trip: TripDTO) => {
    let creted = new Trip(trip);
    this.trips.push(creted);
  };

  EndTrip(tripId: number) {
    let indexToDelete = this.trips.findIndex((x) => x.Id == tripId);
    this.trips.splice(indexToDelete, 1);
  }

  updateTripPosition = async (position: Position) => {
    await this.trips.forEach((elem) => {
      if (elem.Id === position.tripId) elem.updatePosition(position);
    });
  };

  Track = async () => {
    return await this.trips.map((t) => t.getTrackInfo());
  };
}

export default Tracker;
