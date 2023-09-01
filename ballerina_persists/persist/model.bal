import ballerina/persist as _;

public type OrderRecord record {|
    readonly string orderId;
    string customerId;
    float totalAmount;
    string? shipId;
    string date;
    string eta;
    OrderStatus status;
|};

public enum OrderStatus {
    PENDING,
    SHIPPED,
    DELIVERED,
    CANCELED,
    RETURNED
};
