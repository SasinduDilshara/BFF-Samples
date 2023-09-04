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
import { v4 as uuidv4 } from 'uuid';
import { useNavigate} from 'react-router-dom';

const CreateOrderPage = () => {
  const [date, setDate] = useState('');
  const [eta, setEstimationTime] = useState('');
  const [customerId, setUsername] = useState('');
  const [error, setError] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async event => {
    event.preventDefault();
    const response = await postAPI(submitOrderUrl, { date, eta, customerId, totalAmount: 0, status: 'PENDING', shipId: null, orderId: uuidv4()});
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
            label="Date"
            type="date"
            value={date}
            onChange={e => setDate(e.target.value)}
            InputLabelProps={{
              shrink: true,
            }}
          />
          <TextField
            fullWidth
            margin="normal"
            label="Estimation Time Arrival"
            type="time"
            value={eta}
            onChange={e => setEstimationTime(e.target.value)}
            InputLabelProps={{
              shrink: true,
            }}
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
