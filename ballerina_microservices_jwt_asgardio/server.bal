import ballerina/log;
import ballerina/http;
import ballerina_microservices_jwt_asgardio.cargoWave as _;

configurable string issuer = ?;
configurable string audience = ?;
configurable string jwksUrl = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    },
    auth: [
        {
            jwtValidatorConfig: {
                issuer: issuer,
                audience: audience,
                signatureConfig: {
                    jwksConfig: {
                        url: jwksUrl
                    }
                }
            },
            scopes: ["cargo_insert", "cargo_read"]
        }
    ]
}
service /cargos on new http:Listener(9090) {
    @http:ResourceConfig {
        auth: {
            scopes: ["order_insert"]
        }
    }
    resource function post 'submit(Cargo cargo) returns http:Ok|http:BadRequest {
        cargoTable.push(cargo);
        error? e = informCargoPartners(cargo.cargoId);
        if e is error {
            log:printError("Error message: " + e.message(), e);
            http:BadRequest res = {
                body: {message: string `Error while informing cargo partners ${e.message()}`}
            };
            return res;
        }
        http:Ok res = {
            body: "Successfully submitted the cargo"
        };
        return res;
    };

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
