import { useEffect, useState } from 'react';
import Head from 'next/head';
import PlusIcon from '@heroicons/react/24/solid/PlusIcon';
import { Box, Button, Container, Stack, SvgIcon, Typography } from '@mui/material';
import { CargosTable } from 'src/sections/cargo/cargos-table';
import { getCargoUrl } from 'src/constants/Constants';
import { getAPI } from 'src/api/ApiHandler';
import SimpleDialog from 'src/sections/cargo/view-cargo';
import {Layout as DashboardLayout} from 'src/layouts/dashboard/layout';

const Page = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [data, setData] = useState([]);
  const [open, setOpen] = useState(false);
  const [id, setId] = useState('');
  const [cargo, setCargo] = useState('');

  const fetchCargoData = async (cargoId) => {
    try {
      const response = await getAPI(getCargoUrl + "/" + cargoId);
      if (response.status !== 200) {
        setError(response.message);
      } else {
        setError(null);
        setCargo(response.data);
      }
    } catch (error) {
      setError(error);
    }
  };

  const handleClickOpen = async (id) => {
    setId(id);
    await fetchCargoData(id);
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const fetchData = async () => {
    setLoading(true);
    try {
      const response = await getAPI(getCargoUrl);
      if (response.status !== 200) {
        setError(response.message);
      } else {
        setError(null);
        const d = await response.data;
        setData(d);
        setLoading(false);
      }
    } catch (error) {
      setError(error.message);
      setLoading(false);
    }
};

  useEffect(() => {
    fetchData();
    console.log(data)
  }, []);

  return (
    loading ? <div>Loading...</div> : error != null ? <div>{error}</div> :
    <>
      <Head>
        <title>
          cargos | MegaPort Kit
        </title>
      </Head>
      <Box
        component="main"
        sx={{
          flexGrow: 1,
          py: 8
        }}
      >
        <Container maxWidth="xl">
          <Stack spacing={3}>
            <Stack
              direction="row"
              justifyContent="space-between"
              spacing={4}
            >
              <Stack spacing={1}>
                <Typography variant="h4">
                  Cargos
                </Typography>
              </Stack>
              <div>
                <Button
                  startIcon={(
                    <SvgIcon fontSize="small">
                      <PlusIcon />
                    </SvgIcon>
                  )}
                  variant="contained"
                  href='/create-cargo'
                >
                  Add
                </Button>
              </div>
            </Stack>
            <CargosTable
              count={data.length}
              items={data}
              handleClick={handleClickOpen}
              open={open}
            />
          </Stack>
        </Container>
        <SimpleDialog
          open={open}
          onClose={handleClose}
          id={id}
          cargo={cargo}
      />
      </Box>
    </>
  );
};

Page.getLayout = (page) => (
  <DashboardLayout>
    {page}
  </DashboardLayout>
);

export default Page;
