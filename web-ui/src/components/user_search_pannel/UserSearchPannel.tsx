import React, { useState } from "react";
import ActiveTripsList from "./components/ActiveTripsList";
import ITripUpdateResponse from "../../models/ITripUpdateResponse";

interface ISocetAPI {
  HandleEndTrip: (tripID: string | number) => void;
  HandlePing: (data?: any) => void;
  HandSetError: (error: string) => void;
}

const UserSearchPannel: React.FC<{ trips: ITripUpdateResponse[]; socketAPI: ISocetAPI }> = ({ trips, socketAPI }) => {
  const [panelInputs, setPanelInputs] = useState({ pingValue: "", enTripIdValue: "" });

  const handlePingSend = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    socketAPI.HandlePing(panelInputs.pingValue || undefined);
  };

  const handleEndTripSend = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!panelInputs.enTripIdValue) return;
    socketAPI.HandleEndTrip(panelInputs.enTripIdValue);
  };

  const HANDLE_INPUT = (e: React.ChangeEvent<HTMLInputElement>) => {
    e.preventDefault();
    const { name, value } = e.target;
    setPanelInputs({ ...panelInputs, [name]: value });
  };
  return (
    <div className="userSearchPannel card m-1 mt-4 bg-light p-4 col">
      <form className="form-inline border row mb-5 p-2" onSubmit={handlePingSend}>
        <label htmlFor="pingValue">
          <strong>PING</strong>
        </label>
        <input
          name="pingValue"
          className="form-control"
          type="search"
          placeholder="Any value dato ej: juam"
          aria-label="Search"
          autoComplete="off"
          value={panelInputs.pingValue}
          onChange={HANDLE_INPUT}
        />
        <button className="btn btn-success btn-sm mt-2" type="submit">
          ENVIAR
        </button>
      </form>

      <form className="form-inline row p-2" onSubmit={handleEndTripSend}>
        <label htmlFor="enTripIdValue">
          <strong>TERMINAR VIAJE</strong>
        </label>
        <input
          name="enTripIdValue"
          className="form-control"
          type="search"
          placeholder="Trip ID"
          aria-label="Search"
          autoComplete="off"
          value={panelInputs.enTripIdValue}
          onChange={HANDLE_INPUT}
          required
        />
        <button className="btn btn-success btn-sm mt-2" type="submit">
          ENVIAR
        </button>
      </form>
      <ActiveTripsList trips={trips} />
    </div>
  );
};

export default UserSearchPannel;
