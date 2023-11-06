public type Order record {|
    readonly string orderId;
    string customerId;
    string? shipId;
    string date;
    OrderStatus status;
    int quantity;
    string item;
|};

public type Cargo record {|
    readonly string cargoId;
    ShipStatus status;
    string lat;
    string lon;
    string startFrom;
    string? endFrom;
    CargoType 'type;
|};

public enum CargoType {
    SHIPEX = "ShipEx",
    CARGO_WAVE = "CargoWave",
    TRADE_LOGIX = "TradeLogix"
};

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
