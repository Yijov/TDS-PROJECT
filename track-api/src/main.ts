import { Socket } from "socket.io";
import Position from "./models/Position";
import {Request, Response} from "express";
import EVENTS from "./events";
import Tracker from "./models/Tracker";
import Trip from "./models/Trip";
import TripDTO from './models/TripDTO';
const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);


const TrackingCache:Tracker = new Tracker();

app.get('/', (req: Request, res:Response) => {
  res.status(200).json({success: true})
});

io.on(EVENTS.CONNECTION, (socket:Socket) => {
    
    socket.on(EVENTS.TRIP_START,  (tripDto:TripDTO) => {
      //add  tripp dto in memory
      try {
      TrackingCache.StartTrip(tripDto)
      io.to(socket.id).emit(EVENTS.TRIP_END_SUCCESS)

      } catch (error) {
      io.to(socket.id).emit(EVENTS.TRIP_START_FAILED)
        
      }
    });

    socket.on(EVENTS.TRIP_END, (tripId:number) => {
      // remove the trip from memory
      try {
        TrackingCache.EndTrip(tripId)
        io.to(socket.id).emit(EVENTS.TRIP_END_SUCCESS)
          
        } catch (error) {
        io.to(socket.id).emit(EVENTS.TRIP_END_FAIL)
          
        }
    });

    socket.on(EVENTS.UPDATE_POSITION, async (positionDto:Position) => {
      //updaste position of the trip while cleaning cache
      try {
      TrackingCache.updateTripPosition(positionDto)  
      let response= await TrackingCache.Track()
      socket.broadcast.emit(EVENTS.UPDATE, response);   
      } catch (error) {
      io.to(socket.id).emit(EVENTS.UPDATE_POSITION_FAILED)
      }
       
    });
    
    
    socket.on(EVENTS.DISCONNECT, () => {
        console.log('user disconnected');
        
    });
  
});


server.listen(process.env.PORT||3011, () => {
  console.log('Now listening');
});