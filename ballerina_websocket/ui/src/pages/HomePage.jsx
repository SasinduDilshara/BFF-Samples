import React from "react";
import { useState } from "react";
import { TableRow, TableCell, TableHead, TableContainer, Paper, Table } from "@mui/material";
import { useEffect } from "react";

export default function HomePage() {
    const [location, setLocation] = useState("");
    const socket = new WebSocket("ws://localhost:9091/orders");

    useEffect(() => {
        socket.addEventListener('message', event => {
            setLocation(event.data);
        });
    }, []);
    return (
        <TableContainer component={Paper}>
            <Table sx={{ minWidth: 650 }} aria-label="simple table"></Table>
        <TableHead>
                    <TableRow>
                        <TableCell>Order Id</TableCell>
                        <TableCell>Location</TableCell>
                        <TableCell align="right">Status</TableCell>
                        <TableCell align="right">ShipId</TableCell>
                        <TableCell align="right">Estimated Time Arrival</TableCell>
                    </TableRow>
        </TableHead>
        <TableRow
            key={1}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                {1}
            </TableCell>
            <TableCell align="right">{location != "" ? location : "Not calculated"}</TableCell>
            <TableCell align="right">{"Shipped"}</TableCell>
            <TableCell align="right">{123}</TableCell>
            <TableCell align="right">{"11-12-2023 11:23pm"}</TableCell>
        </TableRow>
        </TableContainer>
    );
}