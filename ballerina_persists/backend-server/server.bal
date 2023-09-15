import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9090) {
    resource function post orders(Order 'order) returns http:Ok|http:BadRequest {
        string[]|error submitOrderResult = sClient->/orders.post(['order]);
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

    resource function get orders() returns Order[]|error {
        stream<Order, error?> orders = sClient->/orders;
        return from Order 'order in orders select 'order;
    };

    resource function get cargoOrders(string cargoId) returns Order[]|error {
        return from Order 'order in sClient->/orders(targetType = Order)
             where 'order.cargoId == cargoId select 'order;
    };

    resource function get orders/[string id]() returns Order|http:BadRequest {
        Order|error 'order = sClient->/orders/[id];
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
}
