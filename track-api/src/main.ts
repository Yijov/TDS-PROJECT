import env from "dotenv";
env.config();
import Position from "./models/Position";
import EVENTS from "./events";
import Tracker from "./models/Tracker";
import TripDTO from "./models/TripDTO";
import { Socket } from "socket.io";
import router from "./router/Router";
import helmet from "helmet";
import cookieParser from "cookie-parser";
import ErrorHandler from "./utils/ErrorHandler";

const cors = require("cors");
const morgan = require("morgan");
const express = require("express");
const app = express();
const http = require("http");
const server = http.createServer(app);
const socketIO = require("socket.io");
const TrackingCache: Tracker = new Tracker();
const PORT = process.env.PORT;
const NODE_ENV = process.env.NODE_ENV;
const io = socketIO(server, {
  cors: {
    origin: "*",
    credentials: true,
    methods: ["GET", "POST"],
  },
});

app.use(cors({ origin: "http://localhost:3000", credentials: true }));
app.use(morgan("dev"));
app.use(helmet());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use("/api/v1", router);

io.on(EVENTS.CONNECTION, (socket: Socket) => {
  console.log(socket.id + " has conected");
  io.to(socket.id).emit(EVENTS.UPDATE, TrackingCache.Track());

  socket.on(EVENTS.GET_STATE, () => {
    let response = TrackingCache.Track();
    io.to(socket.id).emit(EVENTS.UPDATE, response);
  });

  socket.on(EVENTS.PING, (data: string | number | Object) => {
    io.to(socket.id).emit(EVENTS.PONG, data);
  });

  socket.on(EVENTS.TRIP_START, (tripDto: TripDTO) => {
    //add  tripp dto in memory
    try {
      TrackingCache.StartTrip(tripDto);
      io.to(socket.id).emit(EVENTS.TRIP_START_SUCCESS);
      let response = TrackingCache.Track();
      socket.broadcast.emit(EVENTS.UPDATE, response);
    } catch (error) {
      io.to(socket.id).emit(EVENTS.TRIP_START_FAILED, error);
    }
  });

  socket.on(EVENTS.TRIP_END, (tripId: number) => {
    // remove the trip from memory
    try {
      TrackingCache.EndTrip(tripId);
      io.to(socket.id).emit(EVENTS.TRIP_END_SUCCESS);
    } catch (error) {
      io.to(socket.id).emit(EVENTS.TRIP_END_FAIL, error);
    }
  });

  socket.on(EVENTS.UPDATE_POSITION, (positionDto: Position) => {
    //updaste position of the trip while cleaning cache
    try {
      TrackingCache.updateTripPosition(positionDto);
      let response = TrackingCache.Track();
      socket.broadcast.emit(EVENTS.UPDATE, response);
    } catch (error) {
      io.to(socket.id).emit(EVENTS.UPDATE_POSITION_FAILED, error);
    }
  });

  socket.on(EVENTS.DISCONNECT, () => {
    console.log("user " + socket.id + " disconnected");
  });
});

app.use("*", ErrorHandler.NotFoundRouteHandler);
app.use(ErrorHandler.ExeptionHandler);

server.listen(PORT, () => {
  NODE_ENV === "development" ? console.log("Now listening on port " + PORT) : console.log("Now listening");
});
