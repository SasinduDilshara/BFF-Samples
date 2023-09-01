import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /orders on new http:Listener(9090) {
    resource function post 'submit(Order 'order) returns http:Ok|SubmitFailureResponse {
        string[]|error submitOrderResult = submitOrder('order);
        if submitOrderResult is string[] {
            http:Ok res = {};
            return res;
        }
        return <SubmitFailureResponse> {
            body: {
                message: submitOrderResult.message()
            }
        };
    };

    resource function get getAllOrders() returns Order[]|error {
        stream<Order, error?> orders = getAllOrders();
        return from Order 'order in orders select 'order;
    };
}
