import { Request, Response, NextFunction } from "express";
import Responder from "../../utils/Responder";
import ValidateSignInData from "./UserValidator";
import { IUserSignInDTO } from "./UserModel";
import UserService from "./UserService";

//  [POST] /api/v1/account/signin
const POST_SIGNIN = async (req: Request<{}, {}, IUserSignInDTO>, res: Response, next: NextFunction) => {
  try {
    //vañlidate data is complete and in the right format
    const credentials = req.body;
    await ValidateSignInData(credentials);

    //sign in the customer
    await UserService.SIGN_IN(credentials, res);

    //send response
    return Responder.Success(res);
  } catch (error) {
    //proceed to error handleling midleware
    next(error);
  }
};

// [GET] /api/v1/account/signout
const GET_SIGNOUT = async (req: Request, res: Response, next: NextFunction) => {
  try {
    //sign out the customer
    await UserService.SIGN_OUT(res);

    //send response
    Responder.Success(res);
  } catch (error) {
    //proceed to error handleling midleware
    next(error);
  }
};

export default { GET_SIGNOUT, POST_SIGNIN };
