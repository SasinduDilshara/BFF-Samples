import React, { useState, useEffect } from 'react';
import {
  Typography,
  TextField,
  Button,
  Container,
  Paper,
} from '@mui/material';
import { postAPI } from '../api/ApiHandler';
import { submitOrderUrl } from '../api/Constants';
import { v4 as uuidv4 } from 'uuid';
import { useNavigate } from 'react-router-dom';

const CreateOrderPage = () => {
  const [eta, setEstimationTime] = useState('');
  const [customerId, setUsername] = useState('');
  const [error, setError] = useState(false);
  const [quantity, setQuantity] = useState(0);
  const navigate = useNavigate();

  const getTotalAmount = () => {
    return 100;
  }

  const createdDate = () => {
    var today = new Date();
    return today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
  }

  const handleSubmit = async event => {
    event.preventDefault();
    const response = await postAPI(submitOrderUrl, { date: createdDate(), eta, customerId, totalAmount: getTotalAmount(), status: 'PENDING', shipId: null, orderId: uuidv4(), quantity: parseInt(quantity)}, {
      headers: {
        message: "Calling the create order api /order/submit/"
      }
    });
    if (response.error) {
      setError(true);
    } else {
      setError(false);
      navigate('/orders');
    }
  };  

  return (
    error? <div>Something went wrong</div> :
    <Container component="main" maxWidth="xs">
      <Paper elevation={3} style={{ padding: '20px' }}>
        <Typography variant="h5" align="center">
          Register Order
        </Typography>
        <form onSubmit={handleSubmit}>
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
            Register Order
          </Button>
        </form>
      </Paper>
    </Container>
  );
};

export default CreateOrderPage;
