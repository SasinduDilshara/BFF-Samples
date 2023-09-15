import ballerina/persist;

Client sClient = check new ();

public function submitOrder(OrderInsert 'order) returns string[]|error {
    return <string[]> check sClient->/orders.post(['order]);
}

public function getAllOrders() returns stream<Order, persist:Error?> {
    return sClient->/orders;
}

public function getOrderById(string orderId) returns Order|error {
    return <Order> check sClient->/orders/[orderId];
}

public function updateOrder(OrderUpdate 'order, string orderId) returns Order|error {
    return <Order> check sClient->/orders/[orderId].put('order);
}

public function deleteOrder(string orderId) returns Order|error {
    return <Order> check sClient->/orders/[orderId].delete();
}
