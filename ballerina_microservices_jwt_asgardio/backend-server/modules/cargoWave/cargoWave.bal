import ballerina/log;
import ballerina/http;

listener http:Listener cargowaveListner = check new (9094);

// @http:ServiceConfig {
//     cors: {
//         allowOrigins: ["*"]
//     },
//     auth: [
//         {
//             oauth2IntrospectionConfig: {
//                 url: "https://api.asgardeo.io/t/orgsd/oauth2/introspect",
//                 tokenTypeHint: "access_token",
//                 clientConfig: {
//                     secureSocket: {
//                         cert: "/Users/admin/Desktop/Test-Codes/BFF/Repos/BFF-Samples/BFF-Samples/ballerina_microservices_jwt_asgardio/backend-server/resources/api.asgardeo.io.cer"
//                     },
//                     auth: {
//                         clientId: "s0PYeIeVCb1fVPPVMfBLMde7tNka",
//                         clientSecret: "Y1Nl8pxQEybqJ9nT0S48M5gWMbm9C5AD6XHUYDgdrdYa",
//                         tokenUrl: "https://api.asgardeo.io/t/orgsd/oauth2/token"
//                     }
//                 }
//             },
//             scopes: ["cargo_read"]
//         }
//     ]
// }

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
