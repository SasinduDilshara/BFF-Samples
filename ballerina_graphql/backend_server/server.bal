import ballerina/graphql;

@graphql:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
// Get all orders. Example: http://localhost:9090/sales/orders
service /sales on new graphql:Listener(9090) {
    resource function get orders() returns Order[]|error {
        return orderTable;
    }
}
