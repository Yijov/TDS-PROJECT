import { Response } from "express";

//200 ok
const Ok = async (res: Response) => {
  return res.status(200).send();
};

const Success = async (res: Response, payload?: {} | []) => {
  return res.status(200).json({ success: true, payload });
};

//200 deleted
const Deleted = async (res: Response) => {
  return res.status(200).send();
};

//204 No Content
const NoContent = async (res: Response, message: string) => {
  return res.status(204).json({ success: false, message: message });
};

//201 Created include a Location header identifying the location of the newly created resource.
const Created = async (res: Response, payload: {}, _id: string, location: string) => {
  res.location(location + _id);
  return res.status(201).json({ success: true, payload: payload });
};

// updated
const Updated = async (res: Response, payload: {} | []) => {
  return res.status(204).json({ success: true, payload });
};

export default { Updated, Created, NoContent, Deleted, Success, Ok };
