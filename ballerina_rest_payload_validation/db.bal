public Order[] orders = [
    {orderId: "61588cd7-9fae-424a-b24d-972fe0000123", customerId: "3d1594ac-be58-4b16-ac5e-03a5fafdff27", totalAmount: 100, shipId: "ee7d0e9e-a9ff-4598-b7a3-dc7fb8b99431", date: "22/11/2023", eta: "31/12/2023", status: PENDING},
    {orderId: "766f0a2d-7bf6-4f19-8585-219f397b08aa", customerId: "149ff802-7ff5-4199-8d90-1b252ef201a5", totalAmount: 150, shipId: "713a014e-04b3-4bb1-982d-25be4b91e47f", date: "12/11/2023", eta: "21/12/2023", status: DELIVERED}
];

public function submitOrder(Order 'order) returns Order {
    orders.push('order);
    return 'order;
}

public function updateOrder(Order 'order) returns Order|error {
    int index = 0;
    foreach Order item in orders {
        if item.orderId == 'order.orderId {
            orders[index] = {
                orderId: 'order.orderId,
                customerId: 'order.customerId,
                totalAmount: 'order.totalAmount,
                shipId: 'order.shipId,
                date: 'order.date,
                eta: 'order.eta,
                status: 'order.status
            };
            return 'order;
        }
        index = index + 1;
    }
    return error("Order not found");
}

public function getAllOrders() returns Order[] {
    return orders;
}

public function getOrder(string id) returns Order|error {
    foreach Order item in orders {
        if item.orderId == id {
            return item;
        }
    }
    return error("Order not found");
}
