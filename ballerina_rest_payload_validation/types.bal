import ballerina/constraint;
import ballerina/http;

public type SubmitFailureResponse record {|
    *http:BadRequest;
    record {
        string message;
    } body;
|};

public type Order record {
    readonly string orderId;
    string customerId;

    @constraint:Float {
        minValue: 0
    }
    float totalAmount;
    
    string? shipId;
    string date;
    string eta;
    OrderStatus status;
};

public enum OrderStatus {
    PENDING,
    SHIPPED,
    DELIVERED,
    CANCELED,
    RETURNED
};
