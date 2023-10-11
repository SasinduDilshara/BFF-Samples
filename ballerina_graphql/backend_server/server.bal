import ballerina/graphql;
import ballerina/log;

@graphql:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
// Get all orders. Example: http://localhost:9090/sales/orders
service /sales on new graphql:Listener(9090) {
    // Query orders via the GraphQL URL: http://localhost:9090/sales
    // Example query: 
    // query {
    //     orders(customerId:"C-124") { customerId, item, shippingAddress: {city} }
    // }
    resource function get orders(string? customerId) returns Order[]|error {
        log:printInfo("Get orders for customer: " + (customerId?: "Any"));
        if customerId is () {
            return orderTable.toArray();
        }
        return from Order 'order in orderTable
            where 'order.customerId == customerId
            select 'order;
    }
}

public type Order record {|
    readonly string orderId;
    string customerId;
    string? shipId;
    Address? shippingAddress;
    string date;
    OrderStatus status;
    int quantity;
    string item;
|};

public type Address record {|
    string number;
    string street;
    string city;
    string state;
|};
