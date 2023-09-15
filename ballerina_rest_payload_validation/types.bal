import ballerina/constraint;

public type Order record {
    @constraint:String {
        pattern: re `^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$`
    }
    readonly string orderId;
    string customerId;

    @constraint:Float {
        minValue: 0
    }
    float totalAmount;
    string? shipId;
    @constraint:String {
        pattern: re `^[0-9]{4}-[0-9]{2}-[0-9]{2}$`
    }
    string date;
    string eta?;
    OrderStatus status;
};

public enum OrderStatus {
    PENDING,
    SHIPPED,
    DELIVERED,
    CANCELED,
    RETURNED
};
