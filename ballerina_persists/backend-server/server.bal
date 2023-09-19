import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9090) {

    // Add a new order to the database
    resource function post orders(Order 'order) returns http:Ok|http:BadRequest {
        'order.cargoId = assignCargo();
        string[]|error submitOrderResult = odersDatabase->/orders.post(['order]);
        if submitOrderResult is string[] {
            http:Ok res = {};
            return res;
        }
        http:BadRequest res = {
            body: {
                message: submitOrderResult.message()
            }
        };
        return res;
    };

    // Get all orders from the database
    resource function get orders() returns Order[]|error {
        stream<Order, error?> orders = odersDatabase->/orders;
        return from Order 'order in orders
            select 'order;
    };

    // Get the order with the given 'orderId'
    resource function get orders/[string orderId]() returns Order|http:BadRequest {
        Order|error 'order = odersDatabase->/orders/[orderId];
        if 'order is Order {
            return 'order;
        }
        http:BadRequest res = {
            body: {
                message: 'order.message()
            }
        };
        return res;
    };

    // Get all orders with the given 'cargoId' sorted by 'quantity'

    resource function get cargoOrders(string cargoId) returns Order[]|error {
        return from Order 'order in odersDatabase->/orders(targetType = Order)
            where 'order.cargoId == cargoId
            order by 'order.quantity descending
            select 'order;
    };
}

function assignCargo() returns string {
    return "S-458";
}
