import { TableRow, TableCell } from "@mui/material";
import React from "react";
import { useNavigate } from 'react-router-dom';
import CustomButton from "./CustomButton";

export default function OrderItem({ row }) {
    const navigate = useNavigate();
    return (
        <TableRow
            key={row.orderId}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                {row.orderId}
            </TableCell>
            <TableCell align="right">{row.status}</TableCell>
            <TableCell align="right">{row.shipId == null ? "Not Assigned": row.shipId}</TableCell>
            <TableCell align="right">{row.date}</TableCell>
            <TableCell align="right">{row.eta}</TableCell>
            <CustomButton color="primary" onClick={() => {navigate("/update-order/" + row.orderId)}} disabled={false} label={"Update"} size={'large'}/>
            <TableCell align="right">  </TableCell>
        </TableRow>
    );
}