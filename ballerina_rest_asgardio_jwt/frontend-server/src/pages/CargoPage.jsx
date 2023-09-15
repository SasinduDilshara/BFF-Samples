import React, { useEffect, useState } from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import { getCargoUrl } from '../api/Constants';
import { getAPI } from '../api/ApiHandler';
import CargoItem from '../components/CargoItem';
import { useAuthContext } from '@asgardeo/auth-react';

export default function CargoPage() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [data, setData] = useState([]);
    const {getAccessToken, getBasicUserInfo, getDecodedIDToken} = useAuthContext();

    useEffect(() => {
        const fetchData = async () => {
            setLoading(true);
            try {
                console.log("User Info: ", await getBasicUserInfo());
                console.log("Decoded User Info: ", await getDecodedIDToken());
                const response = await getAPI(getCargoUrl, { headers: { "Authorization": `Bearer ${await getAccessToken()}` } });
                setLoading(false);
                setError(null);
                setData(response.data);
            } catch (error) {
                setError(error);
                setLoading(false);
            }
        };
        fetchData();
    }, []);

    return (
        loading ? <div>Loading...</div> :
            error != null ? <div>{"Error"}</div> :
                <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 650 }} aria-label="simple table">
                        <TableHead>
                            <TableRow>
                                <TableCell>Cargo Id</TableCell>
                                <TableCell align="right">Estimated Time</TableCell>
                                <TableCell align="right">startFrom</TableCell>
                                <TableCell align="right">volume Time Arrival</TableCell>
                                <TableCell align="right">End From</TableCell>
                                <TableCell align="right">Location</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {data.map((row) => (
                                <CargoItem row={row} />
                            ))}
                        </TableBody>
                    </Table>
                </TableContainer>
    );
}