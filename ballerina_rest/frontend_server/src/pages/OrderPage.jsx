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
    const [orderId, setOrder] = useState('');
    const [filter, setFilter] = useState(false);
    
    const handleOption1Change = (e) => {
      setOption1(e.target.value);
    };
  
    const handleOption2Change = (e) => {
      setOption2(e.target.value);
    };

    const handleOrderId = (e) => {
        setOrder(e.target.value);
    };

    const changeFilter = () => {
        setFilter(!filter)
    }

    useEffect (() => {
        const fetchData = async () => {
            setLoading(true);
            try {
              const response = await getAPI(option1 != '' && option2 != '' ? getCustomerOrderUrl + "?customer=" + option1 + "&status="+option2: orderId != ''? getOrderUrl+"/"+orderId: getOrderUrl);
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
    }, [filter]);

    return (
        loading ? <div>Loading...</div> :
        error != null ? <div>{error}</div> :
        <React.Fragment>
        <p> filter your results based on customer and status</p>
        <div className="dropdown-container">
        <TextField
            label="Customer"
            value={option1}
            onChange={handleOption1Change}
          />
        <select value={option2} onChange={handleOption2Change}>
          <option defaultValue="PENDING">Status</option>
          <option value="PENDING">PENDING</option>
          <option value="SHIPPED">SHIPPED</option>
          <option value="DELIVERED">DELIVERED</option>
          <option value="CANCELED">CANCELED</option>
          <option value="RETURNED">RETURNED</option>
        </select>
        <button onClick={changeFilter}>Filter</button>
        <p> filter your results based on order id</p>
        <div className="dropdown-container">
        <TextField
            label="Order ID"
            value={orderId}
            onChange={handleOrderId}
          />
        </div>
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
                    { orderId==''?
                    data.map((row) => (
                        <OrderItem row={row} />
                    )):
                    <OrderItem row={data} />
                    }
                </TableBody>
            </Table>
        </TableContainer>
        </React.Fragment>
    );
}
