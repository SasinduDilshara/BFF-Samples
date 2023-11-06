import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:3000", "http://www.hmart-dev.com", "http://www.hmart.com"],
        allowCredentials: false,
        allowHeaders: ["REQUEST_ID"],
        exposeHeaders: ["RESPONSE_ID"],
        maxAge: 84900
    }
}
// service /sales on new http:Listener(9090, 
        // secureSocket = {
        //     key: {
        //         certFile: "../resources/public.crt",
        //         keyFile: "../resources/private.key"
        //     }
        // }) {
service /sales on new http:Listener(9090) {

    @http:ResourceConfig {
        cors: {
            allowOrigins: ["http://localhost:3000", "http://www.hmart-dev.com", "http://www.hmart.com"],
            allowCredentials: true
        }
    }
    resource function post orders(Order 'order) returns http:Ok {
        orderTable.add('order);
        return <http:Ok> { body: { message: "Order submitted successfully" }};
    };

    resource function get orders() returns Order[] {
        return orderTable.toArray();
    };
}
