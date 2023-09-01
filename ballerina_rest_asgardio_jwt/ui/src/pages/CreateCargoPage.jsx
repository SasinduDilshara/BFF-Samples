import React, { useState } from 'react';
import {
  Typography,
  TextField,
  Button,
  Container,
  Paper,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
} from '@mui/material';
import { v4 as uuidv4 } from 'uuid';
import { useNavigate } from 'react-router-dom';
import { useAuthContext } from "@asgardeo/auth-react";
import { submitCargoUrl } from '../api/Constants';
import { postAPI } from '../api/ApiHandler';


const CreateCargoPage = () => {
  const [volume, setVolume] = useState('');
  const [type, setType] = useState('');
  const [startFrom, setStartFrom] = useState('');
  const [endFrom, setEndFrom] = useState('');
  const [lon, setLon] = useState('');
  const [lat, setLat] = useState('');
  const navigate = useNavigate();
  const [error, setError] = useState(false);
  const { getAccessToken } = useAuthContext();

  const handleSubmit = async event => {
    event.preventDefault();
    const response = await postAPI(submitCargoUrl, { volume, type, startFrom, endFrom, cargoId: uuidv4(), eta: null, status: 'DOCKED', lat, lon}, {headers: {"Authorization" : `Bearer ${await getAccessToken()}`}}
    );
    if (response.error) {
      setError(true);
    } else {
      setError(false);
      navigate('/cargos');
    }
  };

  return (
    error? <div>Something went wrong</div> :
    <Container component="main" maxWidth="xs">
      <Paper elevation={3} style={{ padding: '20px' }}>
        <Typography variant="h5" align="center">
          Create New Cargo
        </Typography>
        <form onSubmit={handleSubmit}>
          <TextField
            fullWidth
            margin="normal"
            label="Volume"
            value={volume}
            onChange={e => setVolume(e.target.value)}
            required
          />
          <FormControl fullWidth margin="normal" required>
            <InputLabel>Type</InputLabel>
            <Select
              value={type}
              onChange={e => setType(e.target.value)}
            >
              <MenuItem value="ShipEx">ShipEx</MenuItem>
              <MenuItem value="CargoWave">CargoWave</MenuItem>
              <MenuItem value="TradeLogix">TradeLogix</MenuItem>
            </Select>
          </FormControl>
          <TextField
            fullWidth
            margin="normal"
            label="Start From"
            value={startFrom}
            onChange={e => setStartFrom(e.target.value)}
            required
          />
          <TextField
            fullWidth
            margin="normal"
            label="End From"
            value={endFrom}
            onChange={e => setEndFrom(e.target.value)}
          />
          <TextField
            fullWidth
            margin="normal"
            label="Longitude"
            value={lon}
            onChange={e => setLon(e.target.value)}
          />
          <TextField
            fullWidth
            margin="normal"
            label="Latitude"
            value={lat}
            onChange={e => setLat(e.target.value)}
          />
          <Button type="submit" fullWidth variant="contained" color="primary">
            Create Cargo
          </Button>
        </form>
      </Paper>
    </Container>
  );
};

export default CreateCargoPage;
