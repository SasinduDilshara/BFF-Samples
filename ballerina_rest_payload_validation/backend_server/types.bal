import ballerina/constraint;

// Order is an open record. Front-ends can send JSON data with additional fields.

public type Order record {
    @constraint:String {
        pattern: re `^HM-\d{1,8}$`
    }
    readonly string orderId;
    @constraint:String {
        pattern: re `^C-\d{1,4}$`
    }
    string customerId;
    @constraint:Int {
        minValue: 0, maxValue: 10
    }
    int quantity;
    @constraint:String {
        pattern: re `^[0-9]{4}-[0-9]{2}-[0-9]{2}$`
    }
    string date; 
    string? shipId; // ShipId is optional, so that input JSON may not contain a ship ID   
    OrderStatus status;
    string item;
};

public enum OrderStatus {
    PENDING,
    SHIPPED,
    DELIVERED,
    CANCELED,
    RETURNED
};
