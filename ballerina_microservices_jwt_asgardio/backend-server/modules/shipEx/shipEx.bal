import ballerina/log;
import ballerina/http;

listener http:Listener shipexListner = check new (9092);

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
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
