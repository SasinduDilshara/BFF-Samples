import ballerina/log;
import ballerina/http;

listener http:Listener shipexListner = check new (9092);

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    },
    auth: [
        {
            oauth2IntrospectionConfig: {
                url: "https://api.asgardeo.io/t/orgsd/oauth2/introspect",
                tokenTypeHint: "access_token",
                clientConfig: {
                    secureSocket: {
                        cert: "../../resources/public.crt"
                    },
                    auth: {
                        clientId: "<Client_id>",
                        clientSecret: "<client_secret>",
                        tokenUrl: "https://api.asgardeo.io/t/orgsd/oauth2/token"
                    }
                }
            }
        }
    ]
}
service / on shipexListner {
    resource function post shipments() returns http:Accepted {
        log:printInfo("New cargo was successfully register to the megaport");
        return {
            body: {
                message: "New cargo was successfully register to the megaport"
            }
        };
    }
}
