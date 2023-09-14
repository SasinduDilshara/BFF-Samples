import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /orders on new http:Listener(9090) {
    resource function post 'submit(Order 'orders) returns http:Ok {
        orderTable.push('orders);
        http:Ok res = {
            body: "Order submitted successfully"
        };
        return res;
    };

    resource function get getOrders(string? id) returns Order[]|Order|http:BadRequest {
        if id is string {
            foreach Order item in orderTable {
                if item.orderId == id {
                    return item;
                }
            }
            http:BadRequest res = {
                body: "Order submitted successfully"
            };
            return res;
        }
        return orderTable;
    };
}
