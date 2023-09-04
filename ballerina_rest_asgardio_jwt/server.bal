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
            }, 
            scopes: ["read_data", "write_data"]
        }
    ]
}
service / on new http:Listener(9090) {
    @http:ResourceConfig {
        auth: {
            scopes: ["read_data", "write_data"]
        }
    }
    resource function post orders/submit(Order 'orders) returns http:Ok|SubmitFailureResponse {
        Order|error submitOrderResult = submitOrder('orders);
        if submitOrderResult is Order {
            http:Ok res = {};
            return res;
        }
        return <SubmitFailureResponse>{
            body: {
                message: submitOrderResult.message()
            }
        };
    };

    @http:ResourceConfig {
        auth: {
            scopes: ["read_data", "write_data"]
        }
    }
    resource function get orders/getAllOrders() returns Order[] {
        return getAllOrders();
    };


    @http:ResourceConfig {
        auth: {
            scopes: ["write_data"]
        }
    }
    resource function post cargos/submit(Cargo 'cargos) returns http:Ok|SubmitFailureResponse {
        Cargo|error submitCargoResult = submitCargo('cargos);
        if submitCargoResult is Cargo {
            http:Ok res = {};
            return res;
        }
        return <SubmitFailureResponse>{
            body: {
                message: submitCargoResult.message()
            }
        };
    };


    @http:ResourceConfig {
        auth: {
            scopes: ["write_data"]
        }
    }
    resource function get cargos/getAllCargos() returns Cargo[] {
        return getAllCargos();
    };
}
