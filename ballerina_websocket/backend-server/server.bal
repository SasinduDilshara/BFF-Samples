import ballerina/lang.runtime;
import ballerina/log;
import ballerina/websocket;

// Expose websocker server over port 9091.
// Example ws://localhost:9091/sales.
service /logistics on new websocket:Listener(9091) {
    resource function get vehicles/[string vehicleId]() returns websocket:Service {
        return new OrderService(vehicleId);
    }
}

distinct service class OrderService {
    *websocket:Service;

    string vehicleId;
    function init(string vehicleId) {
        self.vehicleId = vehicleId;        
    }

    remote function onOpen(websocket:Caller caller) returns error? {
        Location[]? locations = vehicleLocations[self.vehicleId];
        if locations is () {
            return error("Invalid vehicle id");
        }
        int i = 0;
        while true {
            Location currentLocation = {
                latitude: locations[i % locations.length()].latitude,
                longitude: locations[i % locations.length()].longitude
            };
            i = i + 1;
            error? e = caller->writeMessage(currentLocation);
            if e is error {
                log:printError("Error while upodating the location details", e);
            }
            runtime:sleep(1);
        }
    }

    remote function onClose(websocket:Caller caller) {
        log:printInfo("WebSocket connection closed");
    }

    remote function onError(websocket:Caller caller, error err) {
        log:printInfo("Error occured", err);
    }
}

