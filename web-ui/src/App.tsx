import React from 'react';
import Home from './pages/home/Home';
import NotFound from './pages/not_found/NotFound';
import Auth from './pages/auth/Auth';
import {Routes, Route } from "react-router-dom";



function App() {
  return (
  <Routes>
    <Route path="/" element={<Home />} />
    <Route path="/home" element={<Home />} />
    <Route path="/auth" element={<Auth />} />
    <Route path="*" element={<NotFound />} />
  </Routes>
  
  );
}

export default App;
