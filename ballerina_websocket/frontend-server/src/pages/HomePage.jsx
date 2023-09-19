import React from "react";
import { useState } from "react";
import { TableRow, TableCell, TableHead, TableContainer, Paper, Table } from "@mui/material";
import { useEffect } from "react";

export default function HomePage() {
    const [location1, setLocation1] = useState(null);
    const [location2, setLocation2] = useState(null);
    const socket1 = new WebSocket("ws://localhost:9091/logistics/vehicles/V120");
    const socket2 = new WebSocket("ws://localhost:9091/logistics/vehicles/V121");

    useEffect(() => {
        socket1.addEventListener('message', event => {
            setLocation1(JSON.parse(event.data));
        });

        socket2.addEventListener('message', event => {
            setLocation2(JSON.parse(event.data));
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
                        <TableCell align="right">Item</TableCell>
                        <TableCell align="right">Quantity</TableCell>
                    </TableRow>
        </TableHead>
        <TableRow
            key={1}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                {1}
            </TableCell>
            <TableCell align="right">{location1 != null ? location1.latitude+", " + location1.longitude : "Not calculated"}</TableCell>
            <TableCell align="right">{"Shipped"}</TableCell>
            <TableCell align="right">{"S-90"}</TableCell>
            <TableCell align="right">{"TV"}</TableCell>
            <TableCell align="right">{"3"}</TableCell>
        </TableRow>
        <TableRow
            key={2}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                {2}
            </TableCell>
            <TableCell align="right">{location2 != null ? location2.latitude+", " + location2.longitude : "Not calculated"}</TableCell>
            <TableCell align="right">{"Delivered"}</TableCell>
            <TableCell align="right">{"S-234"}</TableCell>
            <TableCell align="right">{"IPhone 14"}</TableCell>
            <TableCell align="right">{"12"}</TableCell>
        </TableRow>
        </TableContainer>
    );
}