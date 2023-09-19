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
import { useAuthContext } from '@asgardeo/auth-react';

const CreateOrderPage = () => {
  const [item, setItem] = useState('');
  const [quantity, setQuantity] = useState('');
  const [customerId, setUsername] = useState('');
  const [error, setError] = useState(false);
  const navigate = useNavigate();
  const { getAccessToken } = useAuthContext();

  const createID = () => {
    const min = 100; // Minimum value (inclusive)
    const max = 999; // Maximum value (inclusive)
    const random = Math.floor(Math.random() * (max - min + 1)) + min;
    return "HM-" + random.toString();
  }

  const createdDate = () => {
    var today = new Date();
    return today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
  }

  const handleSubmit = async event => {
    event.preventDefault();
    const response = await postAPI(submitOrderUrl, { item, quantity: parseInt(quantity), customerId, status: 'PENDING', shipId: null, orderId: createID(), date: createdDate() }, { headers: { "Authorization": `Bearer ${await getAccessToken()}` } });
    if (response.error) {
      setError(true);
    } else {
      setError(false);
      navigate('/orders');
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
