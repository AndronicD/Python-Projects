import React from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import HomePage from './pages/HomePage';
import NotFound from './pages/NotFound';
import LoginPage from './pages/LoginPage';
import SignupPage from './pages/SignupPage';
import RecoveryPassword from './pages/RecoveryPassword';
import PasswordChange from './pages/PasswordChange';
import MainPage from './pages/MainPage';

const Router = () => {
  return (
    <BrowserRouter>
        <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/login" element={<LoginPage />} />
            <Route path="/main" element={<MainPage />} />
            <Route path="/signup" element={<SignupPage />} />
            <Route path="/recovery" element={<RecoveryPassword />} />
            <Route path="/password_change/:url_extension" element={<PasswordChange />} />
            <Route path="*" element={<NotFound />} />
        </Routes>
    </BrowserRouter>
  );
}

export default Router;