import ballerina/log;
import ballerina/http;

listener http:Listener cargowaveListner = check new (9094);

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
//     auth: [
//         {
//             oauth2IntrospectionConfig: {
//                 url: "https://api.asgardeo.io/t/orgsd/oauth2/introspect",
//                 tokenTypeHint: "access_token"
//                 // clientConfig: {
//                 //     secureSocket: {
//                 //         cert: "https://api.asgardeo.io/t/orgsd/oauth2/jwks"
//                 //     }
//                 // }
//             }
//         }
//     ]
}

service / on cargowaveListner {
    resource function post submit() returns error? {
        log:printInfo("New cargo was successfully register to the megaport");
    }
}
