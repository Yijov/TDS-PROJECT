import { IUser } from "./UserModel";
const USERS: IUser[] = [
  { _id: "101", name: "yirbett", lastName: "Joseph", email: "yirbett@gmail.com", password: "admin" },
  { _id: "102", name: "Carloz", lastName: "Mendez", email: "Carlos@gmaol.com", password: "admin" },
];
export const FindUserByEmail = async (email: string) => {
  try {
    const Account = await USERS.find((user) => user.email === email);
    return Account;
  } catch (error) {
    throw error;
  }
};

export const FindAllUsers = async () => {
  return USERS;
};

export const FindUserById = async (_id: string) => {
  try {
    const Account = await USERS.find((user) => user._id === _id);
    return Account;
  } catch (error) {
    throw error;
  }
};
export default { FindUserByEmail, FindUserById, FindAllUsers };
