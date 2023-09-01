public Cargo[] cargos = [
    {
        cargoId: "61588cd7-9fae-424a-b24d-972fe0000123",
        eta: "2023/12/12",
        status: DOCKED,
        lat: "1.23444",
        lon: "79.1223",
        'type: CARGO_WAVE,
        startFrom: "Washington",
        endFrom: "Mexico",
        volume: "78.23"
    },
    {
        cargoId: "766f0a2d-7bf6-4f19-8585-219f397b08aa",
        eta: "2023/11/12",
        status: COMPLETED,
        lat: "1.3322",
        lon: "79.1224",
        'type: TRADE_LOGIX,
        startFrom: "California",
        endFrom: "London",
        volume: "203.21"
    }
];

public function submitCargo(Cargo cargo) returns Cargo {
    cargos.push(cargo);
    return cargo;
}

public function getAllCargos() returns Cargo[] {
    return cargos;
}

public function getCargoById(string cargoId) returns Cargo|error {
    foreach Cargo cargo in cargos {
        if (cargo.cargoId == cargoId) {
            return cargo;
        }
    }
    return error("No cargo found for given id: " + cargoId);
}
