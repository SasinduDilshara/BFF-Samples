import ballerina/log;
import ballerina/http;

listener http:Listener cargowaveListner = check new (9094);

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
                    // secureSocket: {
                    //     cert: "../../resources/console.asgardeo.io.cer"
                    // },
                    auth: {
                        clientId: "s0PYeIeVCb1fVPPVMfBLMde7tNka",
                        clientSecret: "Y1Nl8pxQEybqJ9nT0S48M5gWMbm9C5AD6XHUYDgdrdYa",
                        tokenUrl: "https://api.asgardeo.io/t/orgsd/oauth2/token"
                    }
                }
            }
        }
    ]
}

service / on cargowaveListner {
    resource function post shipments() returns http:Accepted {
        log:printInfo("New cargo was successfully register to the megaport");
        return {
            body: {
                message: "New cargo was successfully register to the megaport"
            }
        };
    }
}
