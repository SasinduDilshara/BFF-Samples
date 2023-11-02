import ballerina/graphql;

public type Order record {|
    readonly string id;
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

public enum OrderStatus {
    PENDING,
    SHIPPED,
    DELIVERED,
    CANCELED,
    RETURNED
};

@graphql:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new graphql:Listener(9090) {
    // GraphQL URL: http://localhost:9090/sales
    // Example query: 
    // query { orders(customerId:"C-124"){ customerId, item, shippingAddress:{ city } } }
    resource function get orders(string? customerId) returns Order[]|error {
        if customerId is () {
            return orders.toArray();
        }
        return from Order entry in orders
            where entry.customerId == customerId
            select entry;
    }
}
