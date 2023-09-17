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

let i = 228;

const CreateOrderPage = () => {
  const [item, setItem] = useState('');
  const [customerId, setUsername] = useState('');
  const [error, setError] = useState(false);
  const [quantity, setQuantity] = useState(0);

  const [option1, setOption1] = useState('');
  const [option2, setOption2] = useState('');

  const navigate = useNavigate();

  const handleOption1Change = (e) => {
    setOption1(e.target.value);
  };

  const handleOption2Change = (e) => {
    setOption2(e.target.value);
  };

  const createID = () => {
    i = i + 1;
    return "HM-" + i.toString();
  }

  const createdDate = () => {
    var today = new Date();
    return today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
  }

  const handleSubmit = async event => {
    event.preventDefault();
    const response = await postAPI(submitOrderUrl, { date: createdDate(), item, customerId, status: 'PENDING', shipId: null, orderId: createID(), quantity: parseInt(quantity) }, {
      headers: {
        requestId: "Calling the create order api /order/submit/"
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
