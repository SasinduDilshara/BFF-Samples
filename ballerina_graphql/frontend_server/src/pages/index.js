import { useState, useEffect } from 'react';
import Head from 'next/head';
import { Box, Button, Container, Stack, SvgIcon, Typography } from '@mui/material';
import { OrdersTable } from 'src/sections/order/orders-table';
import { OrdersSearch } from 'src/sections/order/orders-search';
import { getOrdersQuery } from 'src/constants/Constants';
import { useQuery } from '@apollo/client';

const Page = () => {
  const [customer, setCustomer] = useState(null);
  const [search, setSearch] = useState("");

  useEffect(() => {
    
  }, []);

  const { loading, error, data } = useQuery(getOrdersQuery, {
    variables: {customerId: customer}
  });
  if (loading) return <p></p>;
  if (error) return <p>Error: {error.message}</p>;

  const onSearchButtonClick = (e) => {
    e.preventDefault();
    setCustomer(search);
  }
  
  const onSearchChange = (e) => {
    e.preventDefault();
    if (e.target.value == "") {
      setSearch(null);
    } else {
      setSearch(e.target.value);
    }
  }

  return (
    loading ? <div>Loading...</div> : error != null ? <div>{error}</div> :
    <>
      <Head>
        <title>
          orders | MegaPort Kit
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
                  Orders
                </Typography>
              </Stack>
            </Stack>
            <Stack
              direction="row"
              alignContent={'center'}
              >
            <OrdersSearch 
              onChange={onSearchChange} 
              customer={search}
            />
            <Button label="Search" value="Search" onClick={onSearchButtonClick}> Search </Button>
            </Stack>
            <OrdersTable
              items={data}
            />
          </Stack>
        </Container>
      </Box>
    </>
  );
};


export default Page;
