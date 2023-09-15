public Order[] orderTable = [
    {orderId: "HM-278", quantity: 5, item: "TV", customerId: "C-124", shipId: "S-8", date: "22-11-2023", status: PENDING},
    {orderId: "HM-340", quantity: 3, item: "IPhone 14", customerId: "C-73", shipId: "S-32", date: "12-11-2023", status: DELIVERED}
];


public function updateOrder(Order 'order) returns Order|error {
    int index = 0;
    foreach Order item in orderTable {
        if item.orderId == 'order.orderId {
            orderTable[index] = {
                orderId: 'order.orderId,
                customerId: 'order.customerId,
                shipId: 'order.shipId,
                date: 'order.date,
                status: 'order.status,
                quantity: 'order.quantity,
                item: 'order.item
            };
            return 'order;
        }
        index = index + 1;
    }
    return error("Order not found");
}
