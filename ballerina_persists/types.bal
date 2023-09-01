import ballerina/http;

public type SubmitFailureResponse record {|
    *http:BadRequest;
    record {
        string message;
    } body;
|};
