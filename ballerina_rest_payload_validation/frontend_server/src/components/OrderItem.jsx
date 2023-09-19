import { TableRow, TableCell } from "@mui/material";
import React from "react";
import { useNavigate, Link } from 'react-router-dom';

export default function OrderItem({ row }) {
    const navigate = useNavigate();
    return (
        <TableRow
            key={row.orderId}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                <Link to={"/order/" + row.orderId}>{row.orderId}</Link>
            </TableCell>
            <TableCell align="right">{row.status}</TableCell>
            <TableCell align="right">{row.shipId == null ? "Not Assigned": row.shipId}</TableCell>
            <TableCell align="right">{row.date}</TableCell>
            <TableCell align="right">{row.item}</TableCell>
            <TableCell align="right">{row.quantity}</TableCell>
            <TableCell align="right">  </TableCell>
        </TableRow>
    );
}