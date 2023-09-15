import ballerina/http;
import ballerina/log;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9090) {

    // Add a new order by posting a JSON payload
    resource function post orders(Order 'order) returns http:Ok {
        // Order type is a Open record. So if the request body contains additional fields,
        //  we can access those optional fields like this
        if 'order["isTemporary"] is true {
            log:printInfo("Order is temporary");
        } else {
            orderTable.push('order);
        }
        http:Ok res = {
            body: "Order submitted successfully"
        };
        return res;
    };

    // Get order by ID. If the is is nil, then return all the orders as a list.
    // Example: http://localhost:9090/sales/orders?id=HM-238 - return the order that contains ID as HM-238 if exists, otherwise http:NotFound.
    // Example: http://localhost:9090/sales/orders - return all the orders as a list.
    resource function get orders(string? id) returns Order|Order[]|http:NotFound {
        if id is string {
            foreach Order item in orderTable {
                if item.orderId == id {
                    return item;
                }
            }
            http:NotFound res = {
                body: "Order not found. Order ID: " + id
            };
            return res;
        }
        return orderTable;
    };
}
