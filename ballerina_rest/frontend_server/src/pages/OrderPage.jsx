import React, {useState, useEffect} from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import OrderItem from '../components/OrderItem';
import { getCustomerOrderUrl, getOrderUrl } from '../api/Constants';
import { getAPI } from '../api/ApiHandler';
import {
    TextField
  } from '@mui/material';

export default function OrderPage() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [data, setData] = useState([]);

    const [option1, setOption1] = useState('');
    const [option2, setOption2] = useState('');
    const [filter, setFilter] = useState(false);
    
    const handleOption1Change = (e) => {
      setOption1(e.target.value);
    };
  
    const handleOption2Change = (e) => {
      setOption2(e.target.value);
    };

    const changeFilter = () => {
        setFilter(!filter)
    }

    useEffect (() => {
        const fetchData = async () => {
            setLoading(true);
            try {
              const response = await getAPI(option1 != '' && option2 != '' ? getCustomerOrderUrl + "?customer=" + option1 + "&status="+option2: getOrderUrl);
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

    return (
        loading ? <div>Loading...</div> :
        error != null ? <div>{"Error"}</div> :
        <React.Fragment>
        <p> filter your results</p>
        <div className="dropdown-container">
        <TextField
            label="Customer"
            value={option1}
            onChange={handleOption1Change}
          />
        <select value={option2} onChange={handleOption2Change}>
          <option value="">Status</option>
          <option value="PENDING">PENDING</option>
          <option value="SHIPPED">SHIPPED</option>
          <option value="DELIVERED">DELIVERED</option>
          <option value="CANCELED">CANCELED</option>
          <option value="RETURNED">RETURNED</option>
        </select>
        <button onClick={changeFilter}>Filter</button>
      </div>
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
                    {data.map((row) => (
                        <OrderItem row={row} />
                    ))}
                </TableBody>
            </Table>
        </TableContainer>
        </React.Fragment>
    );
}
