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

public enum ShipStatus {
    DOCKED,
    DEPARTED,
    IN_TRANSIT,
    COMPLETED,
    CANCELED
};
