import ballerina/persist;
import ballerina/log;
Cargo[] cargoArray = [
    {
        id: "S-224",
        lat: "1.2312",
        lon: "72.1110",
        startFrom: "London",
        endFrom: "Washington",
        'type: SHIPEX
    },
    {
        id: "S-225",
        lat: "1.2542",
        lon: "72.1650",
        startFrom: "Sydney",
        endFrom: "New York",
        'type: TRADE_LOGIX
    },
    {
        id: "S-226",
        lat: "1.2992",
        lon: "72.6550",
        startFrom: "Sydney",
        endFrom: "London",
        'type: CARGO_WAVE
    }
];
int index = 0;

function assignCargoId() returns string {
    index = index + 1;
    return cargoArray[index % cargoArray.length()].id;
}

function addCargos() {
    string[]|persist:Error results = ordersDatabase->/cargos.post(cargoArray);
    if results is persist:Error {
        log:printError("Error occurred while adding cargos", results);
    }
}
