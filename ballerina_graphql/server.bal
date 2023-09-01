import ballerina/graphql;

@graphql:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /get on new graphql:Listener(9090) {
    resource function get orders() returns Order[]|error {
        Order[]|error 'orders = getAllOrders();
        return 'orders;
    }
}
