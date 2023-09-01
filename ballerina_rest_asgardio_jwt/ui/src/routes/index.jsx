import React from 'react';
import { BrowserRouter, Route, Routes, Router } from 'react-router-dom';
import HomePage from '../pages/HomePage';
import CreateOrderPage from '../pages/CreateOrderPage';
import CargoPage from '../pages/CargoPage';
import CreateCargoPage from '../pages/CreateCargoPage';
import OrderPage from '../pages/OrderPage';

export default function CustomRouter() {
    return (
        <BrowserRouter>
            <Routes>
                <Route exact path="/" element={<HomePage />} />
                <Route path="/orders" element={<OrderPage />} />
                <Route path="/create-order" element={<CreateOrderPage />} />
                <Route path="/cargos" element={<CargoPage />} />
                <Route path="/create-cargo" element={<CreateCargoPage />} />
            </Routes>
        </BrowserRouter>
    );
}