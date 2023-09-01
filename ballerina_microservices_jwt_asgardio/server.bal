import ballerina/log;
import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    },
    auth: [
        {
            jwtValidatorConfig: {
                issuer: getIssuer(),
                audience: getAudience(),
                signatureConfig: {
                    jwksConfig: {
                        url: getJwksUrl()
                    }
                }
            }
        }
    ]
}
service /cargos on new http:Listener(9090) {
    resource function post 'submit(Cargo cargo) returns http:Ok|SubmitFailureResponse {
        Cargo|error result = submitCargo(cargo);
        if result is Cargo {
            error? e = informCargoPartners(cargo.cargoId);
            if e is error {
                log:printError("Error: ", e);
                return <SubmitFailureResponse>{
                    body: {message: string `Error while informing cargo partners ${e.message()}`}
                };
            }
            http:Ok res = {};
            return res;
        }
        log:printError("Error: ", result);
        return <SubmitFailureResponse>{
            body: {
                message: result.message()
            }
        };
    };

    resource function get getAllCargos() returns Cargo[] {
        return getAllCargos();
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
        tokenUrl: getIssuer(),
        clientId: getClientId(),
        clientSecret: getClientSecret(),
        clientConfig: {
            secureSocket: {
                cert: "./resources/public.crt"
            }
        }
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
