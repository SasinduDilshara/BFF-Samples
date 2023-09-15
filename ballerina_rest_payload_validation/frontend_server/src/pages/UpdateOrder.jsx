import React, { useState } from 'react';
import {
    Typography,
    TextField,
    Button,
    Container,
    Paper,
} from '@mui/material';
import { getAPI, postAPI } from '../api/ApiHandler';
import { getOrderUrl, submitOrderUrl } from '../api/Constants';
import { v4 as uuidv4 } from 'uuid';
import { useNavigate, useParams } from 'react-router-dom';
import { useEffect } from 'react';
import { Children } from 'react';

const UpdateOrderPage = () => {
    const { id } = useParams();

    const [orderId, setId] = useState('');
    const [date, setDate] = useState('');
    const [eta, setEstimationTime] = useState('');
    const [customerId, setUsername] = useState('');
    const [error, setError] = useState(false);
    const [quantity, setQuantity] = useState(false);
    const navigate = useNavigate();

    const [loading, setLoading] = useState(false);
    const [fetchError, setDataFetchError] = useState(null);
    const [data, setData] = useState([]);

    const createdDate = () => {
        var today = new Date();
        return today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
      }

    const handleSubmit = async event => {
        event.preventDefault();
        const response = await postAPI(submitOrderUrl, { date: createdDate(), eta, customerId, totalAmount: 0, status: 'PENDING', shipId: null, orderId: orderId, isUpdate: true, quantity: parseInt(quantity) });
        if (response.error) {
            setError(true);
        } else {
            setError(false);
            navigate('/orders');
        }
    };

    useEffect(() => {
        const fetchData = async () => {
            setLoading(true);
            try {
                const response = await getAPI(getOrderUrl + "?id=" + id);
                setDataFetchError(null);
                setData(response.data);
                setId(response.data.orderId);
                setDate(response.data.date);
                setEstimationTime(response.data.eta);
                setUsername(response.data.customerId);
                setLoading(false);
            } catch (error) {
                setDataFetchError(error);
                setLoading(false);
            }
        };
        fetchData();
    }, []);

    return (
        error || fetchError ? <div>Something went wrong</div> :
            loading ? <div>Loading</div> :
                <Container component="main" maxWidth="xs">
                    <Paper elevation={3} style={{ padding: '20px' }}>
                        <Typography variant="h5" align="center">
                            Register Order
                        </Typography>
                        <form onSubmit={handleSubmit}>
                            <TextField
                                fullWidth
                                margin="normal"
                                label="Order Id"
                                type="text"
                                value={orderId}
                                onChange={e => setId(e.target.value)}
                                InputLabelProps={{
                                    shrink: true,
                                }}
                            />
                            <TextField
                                fullWidth
                                margin="normal"
                                label="Data need for Arrival"
                                type="date"
                                value={eta}
                                onChange={e => setEstimationTime(e.target.value)}
                                InputLabelProps={{
                                    shrink: true,
                                }}
                            />
                            <TextField
                                fullWidth
                                margin="normal"
                                label="Quantity"
                                value={quantity}
                                type='number'
                                onChange={e => setQuantity(e.target.value)}
                            />
                            <TextField
                                fullWidth
                                margin="normal"
                                label="Username"
                                value={customerId}
                                onChange={e => setUsername(e.target.value)}
                            />
                            <Button type="submit" fullWidth variant="contained" color="primary">
                                Update Order
                            </Button>
                        </form>
                    </Paper>
                </Container>
    );
};

export default UpdateOrderPage;
