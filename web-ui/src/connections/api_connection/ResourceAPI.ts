import IAuthCredentials from "../../models/authCredentials";
import Connection from "./connection";

export default class ResourceAPI extends Connection {
  private routes = {
    signin: `${this.API_DOMAIN}/api/v1/auth`,
    signout: `${this.API_DOMAIN}/api/v1/auth`,
  };
  public POST_SIGNIN = async (credentials: IAuthCredentials) => {
    const reponse = await this.POST_REQUEST(this.routes.signin, credentials);
    return reponse;
  };
  public GET_SIGNOUT = async () => {
    const reponse = await this.GET_REQUEST(this.routes.signout);
    return reponse;
  };
}
