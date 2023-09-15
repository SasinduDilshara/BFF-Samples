import ballerina/lang.runtime;
import ballerina/log;
import ballerina/websocket;

service /orders on new websocket:Listener(9091) {
    resource function get .() returns websocket:Service {
        return new OrderService();
    }
}

distinct service class OrderService {
    *websocket:Service;

    remote function onOpen(websocket:Caller caller) {
        float latitude;
        float longitude;
        float[] latitudes = [37.7749, 34.0522, 40.7128, 51.5074, -33.8688];
        float[] longitudes = [-122.4194, -118.2437, -74.0060, -0.1278, 151.2093];
        int i = 0;
        while true {
            latitude = latitudes[i % 5];
            longitude = longitudes[i % 5];
            i = i + 1;
            error? e = caller->writeMessage({latitude, longitude});
            if e is error {
                log:printError("Error", e);
            }
            runtime:sleep(1);
        }
    }
}
