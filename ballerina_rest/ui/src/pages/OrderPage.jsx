import React, {useState, useEffect} from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import OrderItem from '../components/OrderItem';
import { getOrderUrl } from '../api/Constants';
import { getAPI } from '../api/ApiHandler';

export default function OrderPage() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [data, setData] = useState([]);

    useEffect (() => {
        const fetchData = async () => {
            setLoading(true);
            try {
              const response = await getAPI(getOrderUrl);
              setLoading(false);
              setError(null);
              setData(response.data);
            } catch (error) {
              setError(error);
              setLoading(false);
            }
        };
        fetchData();
    }, []);

    return (
        loading ? <div>Loading...</div> :
        error != null ? <div>{"Error"}</div> :
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
                    {data.map((row) => (
                        <OrderItem row={row} />
                    ))}
                </TableBody>
            </Table>
        </TableContainer>
    );
}
