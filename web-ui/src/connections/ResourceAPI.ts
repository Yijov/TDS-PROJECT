import User from "../models/User";
import IAuthCredentials from "../models/authCredentials";

import axios from "axios";

export default class ResourceAPI {
  static getUserByid = async (matricula: string) => {};
  static updateUser = async (user: User) => {};
  static createUser = async (user: User) => {};
  static deleteUserByid = async (matricula: string) => {};
  static logIn = async (credentials: IAuthCredentials) => {
    console.log(credentials);
  };
  static logOut = async () => {};
}
