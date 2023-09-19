import React from 'react';
import { BrowserRouter, Route, Routes, Router } from 'react-router-dom';
import HomePage from '../pages/HomePage';
import CreateOrderPage from '../pages/CreateOrderPage';
import OrderPage from '../pages/OrderPage';
import ViewOrder from '../pages/ViewOrder';

export default function CustomRouter() {
    return (
        <BrowserRouter>
            <Routes>
                <Route exact path="/" element={<HomePage />} />
                <Route path="/orders" element={<OrderPage />} />
                <Route path="/create-order" element={<CreateOrderPage />} />
                <Route path="/order/:id" element={<ViewOrder />} />
            </Routes>
        </BrowserRouter>
    );
}