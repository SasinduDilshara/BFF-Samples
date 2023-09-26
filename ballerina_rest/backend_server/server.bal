import ballerina/log;
import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9090) {

    // Get all orders. Example: http://localhost:9090/sales/orders
    resource function get orders() returns Order[] {
        return orderTable;
    };

    // Get order by ID. Example: http://localhost:9090/sales/orders/HM-238
    resource function get orders/[string id]() returns Order|http:NotFound {
        foreach Order item in orderTable {
            if item.orderId == id {
                return item;
            }
        }
        http:NotFound res = {
            body: "Order not found. Order ID: " + id
        };
        return res;
    };

    // Query orders by customer ID and order status
    // Example: http://localhost:9090/sales/customerOrders?customer=C-124&status=PENDING
    resource function get customerOrders(string customer, string status) returns Order[] {
        Order[] customerOrders = [];
        foreach Order item in orderTable {
            if item.customerId == customer && item.status == status {
                customerOrders.push(item);
            }
        }
        return customerOrders;
    };

    // Add a new order by posting a JSON payload
    // Request ID is passed as a header for logging purposes
    resource function post orders(@http:Header string requestId, Order 'order) returns http:Ok {
        log:printInfo("Order received: " + requestId);
        orderTable.push('order);
        http:Ok res = {
            body: "Order submitted successfully"
        };
        return res;
    };
}
