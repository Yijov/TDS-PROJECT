import React from "react";

const UserSearchPannel = () => {
  return (
    <div className="userSearchPannel card m-1 bg-light p-4 col">
       <form className="form-inline row">
         <label htmlFor="matricula">Buscar usuario</label>
          <input 
          name="matricula" 
          className= "form-control" 
          type="search" 
          placeholder="Matrícula ej: 2020-0000" 
          aria-label="Search"/>

          <button className= "btn btn-success btn-sm mt-2" type="submit">Buscar</button>
       </form>
    </div>
  );
};

export default UserSearchPannel;
