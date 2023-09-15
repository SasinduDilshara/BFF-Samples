import gql from 'graphql-tag';

export const serverUrl = "http://localhost:9090";

// POST requests
export const submitOrderUrl = serverUrl + "/orders/submit";

// GET requests
export const graphQlUrl = serverUrl + "/get";

export const getOrdersQuery =
    gql`query {
            orders {
                orderId
                status
                shipId
                eta
            }
    }`;
