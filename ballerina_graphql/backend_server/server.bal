import ballerina/io;
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
service /sales on new graphql:Listener(9090) {

    // Query orders via the GraphQL URL: http://localhost:9090/sales
    // Example query: 
    // query {
    //     orders(customerId:"C-124") { customerId, item, shippingAddress: {city} }
    // }
    resource function get orders(string? customerId) returns Order[]|error {
        io:println("Get orders for customer: " + (customerId?: "Any"));
        if customerId is () {
            return orderTable;
        }
        Order[] customerOrders = [];
        foreach Order 'order in orderTable {
            if ('order.customerId == customerId) {
                customerOrders.push('order);
            }
        }
        return customerOrders;
    }
}
