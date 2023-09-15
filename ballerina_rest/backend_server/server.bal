import ballerina/log;
import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /orders on new http:Listener(9090) {
    resource function post 'submit(@http:Header string message, Order 'orders) returns http:Ok {
        log:printInfo(message);
        orderTable.push('orders);
        http:Ok res = {
            body: "Order submitted successfully"
        };
        return res;
    };

    resource function get getOrders() returns Order[] {
        return orderTable;
    };

    // Here the id parameter will be used as a query parameter
    resource function get getOrderById(string id) returns Order|http:BadRequest {
        foreach Order item in orderTable {
            if item.orderId == id {
                return item;
            }
        }
        http:BadRequest res = {
            body: "Order not found"
        };
        return res;
    };

    // Here the id parameter will be used as a path parameter and the date parameter will be used as a query parameter
    resource function get getOrderByIdAndDate/[string id](string date) returns Order|http:BadRequest {
        foreach Order item in orderTable {
            if item.orderId == id && item.date == date {
                return item;
            }
        }
        http:BadRequest res = {
            body: "Order not found"
        };
        return res;
    };
}
