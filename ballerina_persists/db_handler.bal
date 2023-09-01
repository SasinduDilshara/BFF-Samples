import ballerina/persist;

Client sClient = check new ();

public function submitOrder(OrderRecordInsert 'order) returns string[]|error {
    return <string[]> check sClient->/orderrecords.post(['order]);
}

public function getAllOrders() returns stream<OrderRecord, persist:Error?> {
    return sClient->/orderrecords;
}
