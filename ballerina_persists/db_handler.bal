import ballerina/persist;

Client sClient = check new ();

public function submitOrder(OrderRecordInsert 'order) returns string[]|error {
    return <string[]> check sClient->/orderrecords.post(['order]);
}

public function getAllOrders() returns stream<OrderRecord, persist:Error?> {
    return sClient->/orderrecords;
}

public function getOrderById(string orderId) returns OrderRecord|error {
    return <OrderRecord> check sClient->/orderrecords/[orderId];
}

public function updateOrder(OrderRecordUpdate 'order, string orderId) returns OrderRecord|error {
    return <OrderRecord> check sClient->/orderrecords/[orderId].put('order);
}

public function deleteOrder(string orderId) returns OrderRecord|error {
    return <OrderRecord> check sClient->/orderrecords/[orderId].delete();
}
