public Order[] orderTable = [
    {orderId: "61588cd7-9fae-424a-b24d-972fe0000123", customerId: "3d1594ac-be58-4b16-ac5e-03a5fafdff27", totalAmount: 100, shipId: "ee7d0e9e-a9ff-4598-b7a3-dc7fb8b99431", date: "22/11/2023", eta: "31/12/2023", status: PENDING},
    {orderId: "766f0a2d-7bf6-4f19-8585-219f397b08aa", customerId: "149ff802-7ff5-4199-8d90-1b252ef201a5", totalAmount: 150, shipId: "713a014e-04b3-4bb1-982d-25be4b91e47f", date: "12/11/2023", eta: "21/12/2023", status: DELIVERED}
];

public Cargo[] cargoTable = [
    {cargoId: "ee7d0e9e-a9ff-4598-b7a3-dc7fb8b99431", 'type: CARGO_WAVE, volume: "1000", status: COMPLETED, startFrom: "Washington", endFrom: "New York", eta: "2023-12-11 12:23pm", lat: "1.1234", lon: "79.1212"},
    {cargoId: "347d0e9a-f9ff-4438-b433-dc7f8bb99431", 'type: SHIPEX, volume: "1000", status: DEPARTED, startFrom: "London", endFrom: "Sydney", eta: "2023-11-15 03:23pm", lat: "1.1267", lon: "79.1298"}
];
