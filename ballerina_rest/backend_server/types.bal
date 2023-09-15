public type Order record {|
    readonly string orderId;
    string customerId;
    string? shipId;
    string date;
    OrderStatus status;
    int quantity;
    string item;
|};

public enum OrderStatus {
    PENDING,
    SHIPPED,
    DELIVERED,
    CANCELED,
    RETURNED
};
