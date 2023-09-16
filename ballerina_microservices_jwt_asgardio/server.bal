import ballerina/log;
import ballerina/http;

configurable string cargoWaveUrl = ?;
configurable string issuer = ?;
configurable string audience = ?;
configurable string jwksUrl = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /logistics on new http:Listener(9090) {
    
    resource function post cargo(Cargo cargo) returns http:Ok|http:InternalServerError? {
        cargoTable.push(cargo);
        do {
            http:Client cargoWave = check new (cargoWaveUrl, auth = {
                tokenUrl: issuer,
                clientId: clientId,
                clientSecret: clientSecret
            }, secureSocket = {
                key: {
                    certFile: "../resource/path/to/public.crt",
                    keyFile: "../resource/path/to/private.key"
                },
                cert: "./resources/public.cer"
            });
            http:Response cargoWaveResponse = check cargoWave->post("/shipments", cargo);
            if cargoWaveResponse is http:Response && cargoWaveResponse.statusCode == 202 {
                http:Ok res = {
                    body: "Successfully submitted the shipment request"
                };
                return res;    
            } else {
                fail error ("Shipment processing failed.");   
            }
        } on fail error e {
            string errMsg = "Failed to submit the shipment request. " + e.message();
            log:printError(errMsg);
            http:InternalServerError res = {
                body: {message: errMsg}
            };
            return res;    
        }
    }

    @http:ResourceConfig {
        auth: {
            scopes: ["order_insert", "order_read"]
        }
    }
    resource function get getAllCargos() returns Cargo[] {
        return cargoTable;
    };
}

function informCargoPartners(string insertedCargoId) returns error? {
    string url;
    Cargo cargo = check getCargoById(insertedCargoId);
    if cargo.'type == CARGO_WAVE {
        url = cargowaveListnerUrl;
    } else if cargo.'type == SHIPEX {
        url = shipexListnerUrl;
    } else {
        url = tradelogixListnerUrl;
    }

    http:Client 'client = check new (url, auth = {
        tokenUrl: issuer,
        clientId: clientId,
        clientSecret: clientSecret,
        clientConfig: {
            secureSocket: {
                cert: "./resources/public.cer"
            }
        }
    }, secureSocket = {
        cert: "./resources/public.cer"
    });
    // http:Client 'client = check new (url);
    http:Response|error res = 'client->post("/submit", cargo);
    if res is http:Response {
        if res.statusCode == 202 {
            return ();
        }
        log:printDebug("Error while informing cargo partners" + res.statusCode.toBalString() + res.reasonPhrase.toString());
        return error("Error while informing cargo partners" + res.statusCode.toBalString() + res.reasonPhrase.toString());
    }
}
