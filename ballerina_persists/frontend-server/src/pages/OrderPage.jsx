import React, { useState, useEffect } from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import TextField from '@mui/material/TextField';
import OrderItem from '../components/OrderItem';
import { getCargoUrl, getOrderUrl } from '../api/Constants';
import { getAPI } from '../api/ApiHandler';

export default function OrderPage() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [data, setData] = useState([]);
    const [cargo, setCargo] = useState("");
    const [filter, setFilter] = useState(false);

    useEffect(() => {
        const fetchData = async () => {
            setLoading(true);
            try {
                const response = cargo != "" ? await getAPI(getCargoUrl + "?cargoId=" + cargo) : await getAPI(getOrderUrl);
                setLoading(false);
                setError(null);
                setData(response.data);
            } catch (error) {
                setError(error);
                setLoading(false);
            }
        };
        fetchData();
    }, [filter]);

    const handleFilter = (e) => {
        e.preventDefault();
        console.log(cargo)
        setFilter(!filter);
    }

    return (
        loading ? <div>Loading...</div> :
            error != null ? <div>{"Error"}</div> :
                <React.Fragment>
                    <p>Filter results based on cargo</p>
                    <TextField
                        label="Cargo"
                        value={cargo}
                        onChange={e => setCargo(e.target.value)}
                    />
                    <button onClick={handleFilter}>Filter</button>
                    <TableContainer component={Paper}>
                        <Table sx={{ minWidth: 650 }} aria-label="simple table">
                            <TableHead>
                                <TableRow>
                                    <TableCell>Order Id</TableCell>
                                    <TableCell align="right">Status</TableCell>
                                    <TableCell align="right">ShipId</TableCell>
                                    <TableCell align="right">Item</TableCell>
                                    <TableCell align="right">Quantity</TableCell>
                                    <TableCell align="right"><b>Cargo ID</b></TableCell>
                                </TableRow>
                            </TableHead>
                            <TableBody>
                                {data.map((row) => (
                                    <OrderItem row={row} />
                                ))}
                            </TableBody>
                        </Table>
                    </TableContainer>
                </React.Fragment>
    );
}
