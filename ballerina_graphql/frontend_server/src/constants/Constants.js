import gql from 'graphql-tag';

export const serverUrl = "http://localhost:9090";

// POST requests
export const submitOrderUrl = serverUrl + "/sales/order";

// GET requests
export const graphQlUrl = serverUrl + "/sales";

export const getOrdersQuery =
    gql`query {
            orders {
                orderId
                status
                customerId
                item
                quantity
                shippingAddress {
                    city
                }
            }
    }`;