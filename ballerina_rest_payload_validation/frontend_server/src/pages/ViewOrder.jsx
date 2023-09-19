import React, {useState, useEffect} from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import OrderItem from '../components/OrderItem';
import {getOrderUrl } from '../api/Constants';
import { getAPI } from '../api/ApiHandler';
import { useParams } from 'react-router-dom';

export default function ViewOrder(props) {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [data, setData] = useState([]);
    const params = useParams()

    useEffect (() => {
        const fetchData = async () => {
            setLoading(true);
            try {
              const response = await getAPI(getOrderUrl + "?id=" + params.id);
              setLoading(false);
              if (response.status !== 200) {
                setError(response.message);
              } else {
                setError(null);
                setData(response.data);
              }
            } catch (error) {
              setError(error);
              setLoading(false);
            }
        };
        fetchData();
    }, []);

    return (
        loading ? <div>Loading...</div> :
        error != null ? <div>{error}</div> :
        <TableContainer component={Paper}>
            <Table sx={{ minWidth: 650 }} aria-label="simple table">
                <TableHead>
                    <TableRow>
                        <TableCell>Order Id</TableCell>
                        <TableCell align="right"><b>Status</b></TableCell>
                        <TableCell align="right"><b>ShipId</b></TableCell>
                        <TableCell align="right"><b>Created at</b></TableCell>
                        <TableCell align="right"><b>Item</b></TableCell>
                        <TableCell align="right"><b>Quantity</b></TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                        <OrderItem row={data} />
                </TableBody>
            </Table>
        </TableContainer>
    );
}
