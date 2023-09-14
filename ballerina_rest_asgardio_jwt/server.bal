import ballerina/http;

configurable string issuer = ?;
configurable string audience = ?;
configurable string jwksUrl = ?;

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
    resource function post orders/submit(Order 'orders) returns http:Ok {
        orderTable.push('orders);
        http:Ok res = {
            body: {
                message: "Order submitted successfully"
            }
        };
        return res;
    };

    @http:ResourceConfig {
        auth: {
            scopes: ["read_data", "write_data"]
        }
    }
    resource function get orders/getAllOrders() returns Order[] {
        return orderTable;
    };


    @http:ResourceConfig {
        auth: {
            scopes: ["write_data"]
        }
    }
    resource function post cargos/submit(Cargo 'cargos) returns http:Ok {
        cargoTable.push('cargos);
        http:Ok res = {
            body: {
                message: "Cargo submitted successfully"
            }
        };
        return res;
    };


    @http:ResourceConfig {
        auth: {
            scopes: ["write_data"]
        }
    }
    resource function get cargos/getAllCargos() returns Cargo[] {
        return cargoTable;
    };
}
