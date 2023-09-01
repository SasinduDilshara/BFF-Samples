import ballerina/http;

public type SubmitFailureResponse record {|
    *http:BadRequest;
    record {
        string message;
    } body;
|};

public type Order record {|
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

public enum ShipStatus {
    DOCKED,
    DEPARTED,
    IN_TRANSIT,
    COMPLETED,
    CANCELED
};

public type Cargo record {|
    readonly string cargoId;
    string? eta;
    ShipStatus status;
    string lat;
    string lon;
    string startFrom;
    string? endFrom;
    string volume;
    CargoType 'type;
|};

public enum CargoType {
    SHIPEX = "ShipEx",
    CARGO_WAVE = "CargoWave",
    TRADE_LOGIX = "TradeLogix"
};
