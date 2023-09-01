import ballerina/persist;

Client sClient = check new ();

public function submitOrder(OrderInsert 'order) returns string[]|error {
    return <string[]> check sClient->/orders.post(['order]);
}

public function getAllOrders() returns stream<Order, persist:Error?> {
    return check sClient->/orders;
}
