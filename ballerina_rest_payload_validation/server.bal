import ballerina/io;
import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /orders on new http:Listener(9090) {
    resource function post 'submit(Order 'order) returns http:Ok|SubmitFailureResponse {
        Order|error submitOrderResult;
        if 'order["isUpdate"] == true {
            io:println("update order", 'order);
            submitOrderResult = updateOrder('order);
        } else {
            submitOrderResult = submitOrder('order);
        }
        if submitOrderResult is Order {
            http:Ok res = {};
            return res;
        }
        return <SubmitFailureResponse>{
            body: {
                message: submitOrderResult.message()
            }
        };
    };

    resource function get getOrders(string? id) returns Order[]|Order|error {
        if id is string {
            return getOrder(id);
        }
        return getAllOrders();
    };
}
