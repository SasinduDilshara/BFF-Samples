import React, {useState, useEffect} from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import OrderItem from '../components/OrderItem';
import { getOrdersQuery } from '../api/Constants';
import { useQuery } from '@apollo/client';

export default function OrderPage() {
    const { loading, error, data } = useQuery(getOrdersQuery);
    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;

    return (
        <TableContainer component={Paper}>
            <Table sx={{ minWidth: 650 }} aria-label="simple table">
                <TableHead>
                    <TableRow>
                        <TableCell>Order Id</TableCell>
                        <TableCell align="right">Status</TableCell>
                        <TableCell align="right">ShipId</TableCell>
                        <TableCell align="right">Estimated Time Arrival</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {data.orders.map((row) => (
                        <OrderItem row={row} />
                    ))}
                </TableBody>
            </Table>
        </TableContainer>
    );
}
