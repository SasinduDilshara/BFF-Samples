import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /orders on new http:Listener(9090) {
    resource function post 'submit(Order 'order) returns http:Ok|http:BadRequest {
        if 'order["isUpdate"] == true {
            Order|error updatedOrderResult = updateOrder('order);
            if updatedOrderResult is error {
                return <http:BadRequest>{
                    body: {
                        message: updatedOrderResult.message()
                    }
                };
            }
        } else {
            orderTable.push('order);
        }
        return <http:Ok>{
            body: {
                message: "Order submitted successfully"
            }
        };
    };

    resource function get getOrders(string? id) returns Order[]|Order|http:BadRequest {
        if id is string {
            foreach Order item in orderTable {
                if item.orderId == id {
                    return item;
                }
            }
            return {
                body: {
                    message: "Order not found"
                }
            };
        }
        return orderTable;
    };
}
