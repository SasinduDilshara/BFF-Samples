import ballerina/persist as _;

public type OrderRecord record {|
    readonly string orderId;
    string customerId;
    float totalAmount;
    string? shipId;
    string date;
    string eta;
    OrderStatus status;
	Cargo cargo;
|};

public type Cargo record {|
    readonly string id;
    string? eta;
    string lat;
    string lon;
    OrderRecord? 'order;
|};

public enum OrderStatus {
    PENDING,
    SHIPPED,
    DELIVERED,
    CANCELED,
    RETURNED
};

public enum CargoType {
    SHIPEX = "ShipEx",
    CARGO_WAVE = "CargoWave",
    TRADE_LOGIX = "TradeLogix"
};
