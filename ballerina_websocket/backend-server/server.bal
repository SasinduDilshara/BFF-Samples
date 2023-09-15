import ballerina/lang.runtime;
import ballerina/log;
import ballerina/websocket;

float[] latitudes = [37.7749, 34.0522, 40.7128, 51.5074, -33.8688];
float[] longitudes = [-122.4194, -118.2437, -74.0060, -0.1278, 151.2093];

service /sales on new websocket:Listener(9091) {
    // Connect with websocket client.
    // Example ws://localhost:9091/sales.
    resource function get .() returns websocket:Service {
        // Once the WebSocket upgrade is accepted by the UpgradeService, it returns a websocket:Service.
        return new OrderService();
    }
}

// This service has a fixed set of remote methods that do not have any configs
distinct service class OrderService {
    *websocket:Service;

    // This method will dispatched when the WebSocket connection is established
    remote function onOpen(websocket:Caller caller) {
        float latitude;
        float longitude;
        int i = 0;
        while true {
            latitude = latitudes[i % 5];
            longitude = longitudes[i % 5];
            i = i + 1;
            error? e = caller->writeMessage({latitude, longitude});
            if e is error {
                log:printError("Error while upodating the location details", e);
            }
            runtime:sleep(1);
        }
    }

    // This method will dispatched when the WebSocket connection is closed
    remote function onClose(websocket:Caller caller) {
        log:printInfo("WebSocket connection closed");
    }

    // This method will dispatched when an error occurs in the WebSocket connection.
    remote function onError(websocket:Caller caller, error err) {
        log:printInfo("Error occured", err);
    }
}
