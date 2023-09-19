import React, { useState } from 'react';
import {
  Typography,
  TextField,
  Button,
  Container,
  Paper,
} from '@mui/material';
import { postAPI } from '../api/ApiHandler';
import { submitOrderUrl } from '../api/Constants';
import { useNavigate } from 'react-router-dom';

const CreateOrderPage = () => {
  const [item, setItem] = useState('');
  const [customerId, setUsername] = useState('');
  const [error, setError] = useState(false);
  const [quantity, setQuantity] = useState(0);
  const navigate = useNavigate();

  const createID = () => {
    const min = 100;
    const max = 999;
    const random = Math.floor(Math.random() * (max - min + 1)) + min;
    return "HM-" + random.toString();
  }

  const createdDate = () => {
    var today = new Date();
    return today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
  }

  const handleSubmit = async event => {
    event.preventDefault();
    const response = await postAPI(submitOrderUrl, { date: createdDate(), item, customerId, status: 'PENDING', cargoId: "Not Assigned", orderId: createID(), quantity: parseInt(quantity) });
    try {
      if (response.error) {
        setError(true);
      } else {
        setError(false);
        navigate('/orders');
      }
    }
    catch (error) {
      setError(true);
    }
  };

  return (
    error ? <div>Something went wrong</div> :
      <Container component="main" maxWidth="xs">
        <Paper elevation={3} style={{ padding: '20px' }}>
          <Typography variant="h5" align="center">
            Register Order
          </Typography>
          <form onSubmit={handleSubmit}>
            <TextField
              fullWidth
              margin="normal"
              label="Item name"
              value={item}
              onChange={e => setItem(e.target.value)}
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
