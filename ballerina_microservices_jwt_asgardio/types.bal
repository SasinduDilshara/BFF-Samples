import ballerina/http;

public type SubmitFailureResponse record {|
    *http:BadRequest;
    record {
        string message;
    } body;
|};

public enum CargoStatus {
    DOCKED,
    DEPARTED,
    IN_TRANSIT,
    COMPLETED,
    CANCELED
};

public enum CargoType {
    SHIPEX = "ShipEx",
    CARGO_WAVE = "CargoWave",
    TRADE_LOGIX = "TradeLogix"
};

public type Cargo record {|
    readonly string cargoId;
    string? eta;
    CargoStatus status;
    string lat;
    string lon;
    CargoType 'type;
    string startFrom;
    string? endFrom;
    string volume;
|};
