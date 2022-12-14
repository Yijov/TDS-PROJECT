import Axios, { AxiosError } from "axios";
import IAPIResponse from "./IAPIReaponse";
import APP_CONSTANTS from "../../constants/consts";

//include credentieals in every axious call

Axios.defaults.withCredentials = true;

//Api routes

export default class Connection {
  protected API_DOMAIN = APP_CONSTANTS.TRACk_API_URI;

  protected GET_REQUEST = async <T>(route: string) => {
    try {
      const response = await Axios.get<IAPIResponse<T>>(route);
      return response.data;
    } catch (error) {
      const err = error as AxiosError<IAPIResponse<T>>;
      return err.response!!.data;
    }
  };
  protected POST_REQUEST = async <T>(route: string, DTO: {}) => {
    try {
      const response = await Axios.post<IAPIResponse<T>>(route, DTO);
      return response.data;
    } catch (error) {
      const err = error as AxiosError<IAPIResponse<T>>;
      return err.response!!.data;
    }
  };
  protected PUT_REQUEST = async <T>(route: string, DTO: {}) => {
    try {
      const response = await Axios.put<IAPIResponse<T>>(route, DTO);
      return response.data;
    } catch (error) {
      const err = error as AxiosError<IAPIResponse<T>>;
      return err.response!!.data;
    }
  };

  protected DELETE_REQUEST = async <T>(route: string, DTO?: {}) => {
    try {
      const response = await Axios.delete<IAPIResponse<T>>(route, DTO);
      return response.data;
    } catch (error) {
      const err = error as AxiosError<IAPIResponse<T>>;
      return err.response!!.data;
    }
  };
}
