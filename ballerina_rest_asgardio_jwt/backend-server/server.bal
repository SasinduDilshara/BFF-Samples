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
            scopes: ["order_insert", "order_read", "cargo_insert", "cargo_read"]
        }
    ]
}
service /sales on new http:Listener(9090) {
    // "order_insert" scope is required to invoke this resource
    @http:ResourceConfig {
        auth: {
            scopes: ["order_insert"]
        }
    }
    // Add a new order by posting a JSON payload
    resource function post orders(Order 'orders) returns http:Ok {
        orderTable.push('orders);
        http:Ok res = {
            body: {
                message: "Order submitted successfully"
            }
        };
        return res;
    };

    @http:ResourceConfig {
        // Either "order_insert" or "order_read" scope is required to invoke this resource
        auth: {
            scopes: ["order_read", "order_insert"]
        }
    }
    // Get all orders. Example: http://localhost:9090/sales/orders
    resource function get orders() returns Order[] {
        return orderTable;
    };

    @http:ResourceConfig {
        auth: {
            scopes: ["cargo_insert"]
        }
    }
    // Add a new cargo by posting a JSON payload
    resource function post cargos(Cargo 'cargos) returns http:Ok {
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
            scopes: ["cargo_read", "cargo_insert"]
        }
    }
    // Get all cargos. Example: http://localhost:9090/sales/cargos
    resource function get cargos() returns Cargo[] {
        return cargoTable;
    };

    @http:ResourceConfig {
        auth: {
            scopes: ["cargo_read", "cargo_insert"]
        }
    }
    // Get cargo by ID. Example: http://localhost:9090/sales/cargos/SP-124
    resource function get cargos/[string id]() returns Cargo[] {
        return cargoTable;
    };
}
