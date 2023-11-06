public table<Order> key(orderId) orderTable = table [
    {orderId: "HM-278", quantity: 5, item: "TV", customerId: "C-124", shipId: "S-8", date: "22-11-2023", status: PENDING},
    {orderId: "HM-340", quantity: 3, item: "IPhone 14", customerId: "C-73", shipId: "S-32", date: "12-11-2023", status: DELIVERED}
];

public table<Cargo> key(cargoId) cargoTable = table [
    {cargoId: "SP-124", status: DEPARTED, lat: "1.2312", lon: "72.1110", startFrom: "London", endFrom: "Washington", 'type: SHIPEX},
    {cargoId: "SP-73", status: IN_TRANSIT, lat: "1.1110", lon: "72.1110", startFrom: "Melbourne", endFrom: "Sydney", 'type: CARGO_WAVE}
];
