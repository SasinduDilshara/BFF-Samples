import ballerina_microservices_jwt_asgardio.cargoWave as _;
import ballerina_microservices_jwt_asgardio.shipEx as _;
import ballerina_microservices_jwt_asgardio.tradeLogix as _;

import ballerina/http;

configurable string tokenUrl = ?;
configurable string clientId = ?;
configurable string jwksUrl = ?;
configurable string clientSecret = ?;
configurable string cargoWaveUrl = ?;
configurable string shipExUrl = ?;
configurable string tradeLogixUrl = ?;

public type Cargo record {|
    readonly string cargoId;
    ShipStatus status;
    string lat;
    string lon;
    string startFrom;
    string? endFrom;
    CargoType cargoType;
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

final table<Cargo> cargoTable = table [
    {cargoId: "SP-124", status: DEPARTED, lat: "1.2312", lon: "72.1110", startFrom: "London", endFrom: "Washington", cargoType: SHIPEX},
    {cargoId: "SP-73", status: IN_TRANSIT, lat: "1.1110", lon: "72.1110", startFrom: "Melbourne", endFrom: "Sydney", cargoType: CARGO_WAVE}
];

final http:Client cargoClient = check new (
    cargoWaveUrl, auth = {tokenUrl, clientId, clientSecret, scopes: ["cargo_read"]},
    secureSocket = {
        // key: {certFile: "../path/public.crt", keyFile: "../path/private.key"},
        // cert: "../path/public.crt"
    }
);

final http:Client shipExClient = check new (
    shipExUrl, auth = {tokenUrl, clientId, clientSecret, scopes: ["cargo_read"]},
    secureSocket = {
        // key: {certFile: "../path/public.crt", keyFile: "../path/private.key"},
        // cert: "../path/public.crt"
    }
);

final http:Client tradeLogixClient = check new (
    tradeLogixUrl, auth = {tokenUrl, clientId, clientSecret, scopes: ["cargo_read"]},
    secureSocket = {
        // key: {certFile: "../path/public.crt", keyFile: "../path/private.key"},
        // cert: "../path/public.crt"
    }
);

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /logistics on new http:Listener(9090) {
    resource function post cargos(Cargo cargo) returns http:Ok|http:InternalServerError|http:BadRequest {
        cargoTable.add(cargo);
        do {
            http:Client serviceClient = cargo.cargoType == SHIPEX ?
                shipExClient : cargo.cargoType == CARGO_WAVE ? 
                cargoClient : tradeLogixClient;
            http:Response res = check serviceClient->post("/shipments", cargo);
            if res.statusCode == 202 {
                return <http:Ok>{body: "Successfully submitted the shipment request"};
            }
            return <http:BadRequest>{body: {message: string `Invalid cargo: ${cargo.cargoId}`}};
        } on fail error e {
            return <http:InternalServerError>{
                body: {message: string `Failed to submit the shipment request: ${e.message()}`}
            };
        }
    }

    resource function get cargos() returns Cargo[] {
        return cargoTable.toArray();
    };
}
