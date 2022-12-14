import React, { FC } from "react";
import { BsFillArrowRightSquareFill } from "react-icons/bs";
import logo from "../../assets/images/logo.png";

const Navigation: FC<{ soutFunction: (e: React.MouseEvent) => Promise<void> }> = ({ soutFunction }) => {
  return (
    <div className="top-nav row align-items-center">
      <p className="logo text-white col-11 p-1 fs-4 d-flex align-items-center">
        <img src={logo} alt="Logo" className="header-logo" /> TDS-TRACKER
      </p>
      <p onClick={soutFunction} className="log-out-icon text-white col-1 pr-1 fs-3 d-flex justify-content-end">
        <BsFillArrowRightSquareFill />
      </p>
    </div>
  );
};

export default Navigation;
