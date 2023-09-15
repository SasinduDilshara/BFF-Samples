import { TableRow, TableCell } from "@mui/material";
import React, { useState } from "react";

export default function CargoItem({ row }) {
    const [message, setMessage] = useState("");

    return (
        <TableRow
            key={row.orderId}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                {row.cargoId}
            </TableCell>
            <TableCell align="right">{row.eta == null? "Not Estimated yet!" : row.eta}</TableCell>
            <TableCell align="right">{row.startFrom}</TableCell>
            <TableCell align="right">{row.volume}</TableCell>
            <TableCell align="right">{row.endFrom}</TableCell>
            <TableCell align="right">{message == "" || message == null ? "---" : message}</TableCell>
        </TableRow>
    );
}
