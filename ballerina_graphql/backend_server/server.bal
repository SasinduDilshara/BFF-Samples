import ballerina/graphql;

type Order record {|
    readonly string orderId;
    string customerId;
    string? shipId;
    Address? shippingAddress;
    string date;
    OrderStatus status;
    int quantity;
    string item;
|};

type Address record {|
    string number;
    string street;
    string city;
    string state;
|};

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
