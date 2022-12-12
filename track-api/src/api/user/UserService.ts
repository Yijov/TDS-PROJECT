import { Response } from "express";
import UserRepo from "./UserRepository";
import SecurityTools from "../../utils/security";
import { CustomBadRequestError } from "../custom_errors/customErrors";
import { IUserSignInDTO, IUser } from "./UserModel";

const SIGN_IN = async (credentials: IUserSignInDTO, res: Response) => {
  //verify account existence
  const accountExists = await UserRepo.FindUserByEmail(credentials.email);
  if (accountExists) {
    //validate password is coorect
    const authenticatedAccount = await SecurityTools.validatePasswaord(credentials.password, accountExists.password);

    if (authenticatedAccount) {
      //add authentication cookeis to the response
      const token = await SecurityTools.CreateToken({
        id: accountExists._id!!,
      });
      await SecurityTools.addCredentials(res, token);
      return;
    } else {
      throw new CustomBadRequestError("user or password is incorrect");
    }
  } else {
    throw new CustomBadRequestError("user or password is incorrect");
  }
};

const SIGN_OUT = async (res: Response): Promise<boolean> => {
  await SecurityTools.removeCredentials(res);
  return true;
};

export default { SIGN_OUT, SIGN_IN };
