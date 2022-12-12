export interface IUser {
  _id?: string;
  name: string;
  lastName: string;
  email: string;
  password: string;
}

export interface IUserSignInDTO {
  email: string;
  password: string;
}
