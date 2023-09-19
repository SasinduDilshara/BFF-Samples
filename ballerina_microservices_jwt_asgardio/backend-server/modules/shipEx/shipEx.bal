import ballerina/log;
import ballerina/http;

listener http:Listener shipexListner = check new(9092);

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service / on shipexListner {
    resource function post submit() {
        log:printInfo("New cargo was successfully register to the megaport");
    }
}
