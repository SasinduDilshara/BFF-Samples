import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /orders on new http:Listener(9090) {
    resource function post 'submit(OrderRecord 'order) returns http:Ok|http:BadRequest {
        string[]|error submitOrderResult = sClient->/orderrecords.post(['order]);
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

    resource function get getAllOrders() returns OrderRecord[]|error {
        stream<OrderRecord, error?> orders = sClient->/orderrecords;
        return from OrderRecord 'order in orders select 'order;
    };

    resource function get cargoByOrder(string cargoId) returns OrderRecord[]|error {
        return from OrderRecord 'order in sClient->/orderrecords(targetType = OrderRecord)
             where 'order.cargoId == cargoId select 'order;
    };

    resource function get getOrder/[string id]() returns OrderRecord|http:BadRequest {
        OrderRecord|error 'order = sClient->/orderrecords/[id];
        if 'order is OrderRecord {
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
