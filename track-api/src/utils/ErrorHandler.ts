import { Request, Response, NextFunction } from "express";
import {
  CustomValidationError,
  CustomAuthError,
  CustomBadRequestError,
  CustomNotFoundError,
  CustomConflictError,
} from "../api/custom_errors/customErrors";

const NotFoundRouteHandler = (req: Request, res: Response, next: NextFunction) => {
  const error = new Error(`Not Found - ${req.originalUrl}`);
  res.status(404);
  next(error);
};

// eslint-disable-next-line no-unused-vars
const ExeptionHandler = (error: Error, req: Request, res: Response, next: NextFunction) => {
  let statusCode;
  const ErrorStack = process.env.NODE_ENV === "production" ? "FAIL :(" : error.stack;

  if (error instanceof CustomValidationError) {
    statusCode = 400;
  } else if (error instanceof CustomAuthError) {
    statusCode = 401;
  } else if (error instanceof CustomBadRequestError) {
    statusCode = 400;
  } else if (error instanceof CustomNotFoundError) {
    statusCode = 404;
  } else if (error instanceof CustomConflictError) {
    statusCode = 409;
  } else {
    statusCode = res.statusCode === 200 ? 500 : res.statusCode;
  }

  res.status(statusCode);
  res.json({
    success: false,
    message: error.message,
    stack: ErrorStack,
  });
};

export default { ExeptionHandler, NotFoundRouteHandler };
