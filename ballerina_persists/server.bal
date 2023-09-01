import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /orders on new http:Listener(9090) {
    resource function post 'submit(OrderRecord 'order) returns http:Ok|SubmitFailureResponse {
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

    resource function get getAllOrders() returns OrderRecord[]|error {
        stream<OrderRecord, error?> orders = getAllOrders();
        return from OrderRecord 'order in orders select 'order;
    };
}
