import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;
import ballerina/random;

final table<CustomerRegistrationData> customerTable = table [
    {firstName: "James", lastName: "Clerk", address: "456, ElmAvenue, Suite-7, Willowville", dependents: 2},
    {firstName: "John", lastName: "Doe", address: "789, OakLane, Unit-C12, Pineville", dependents: 6},
    {firstName: "Anna", lastName: "Watson", address: "101, Maple-Road, OfficeD, Birchwood", dependents: 7}
];

public type CustomerRegistrationData record {|
    string firstName;
    string lastName;
    string address;
    int dependents;
|};

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /crm on new http:Listener(9090) {

    @http:ResourceConfig {
        consumes: ["multipart/form-data"],
        produces: ["application/json"]
    }
    // Example: http://localhost:9090/crm/customers
    resource function post customers(http:Request request) returns http:Created|http:InternalServerError {
        do {
            mime:Entity[] bodyParts = check request.getBodyParts();
            string registrationDataString = check bodyParts[0].getText();
            json registrationDataJson = check registrationDataString.fromJsonString();
            CustomerRegistrationData registrationData = check registrationDataJson.cloneWithType();
            byte[] agreemntForm = check bodyParts[1].getByteArray();
            byte[] image = check bodyParts[2].getByteArray();
            string customerId = check registerCustomer(registrationData, agreemntForm, image);
            return <http:Created>{body: {status: "Customer registered successfully.", customerId}};
        } on fail error e {
            return <http:InternalServerError>{body: {message: string `Error while parsing the request: ${e.message()}`}};
        }
    }

    @http:ResourceConfig {
        produces: ["application/pdf"]
    }
    // Example: http://localhost:9090/crm/customers/C-123/agreement
    resource function get customers/[string customerId]/agreement() returns @http:Cache {maxAge: 15} byte[]|http:NotFound {
        byte[]|error agreementForm = getAgreementForm(customerId);
        if agreementForm is error {
            return <http:NotFound>{body: {message: "Agreement form not found for the customer ID: " + customerId}};
        }
        return agreementForm;
    }

    // Example: http://localhost:9090/crm/customers
    resource function get customers() returns CustomerRegistrationData[] {
        return customerTable.toArray();
    }
}

function getAgreementForm(string id) returns byte[]|error {
    log:printInfo("Agreement form requested for customer ID: " + id);
    string filePath = getAgreementFormPath();
    return check io:fileReadBytes(filePath);
}

function registerCustomer(CustomerRegistrationData registrationData, byte[] agreemntForm, byte[] image) returns string|error {
    customerTable.add(registrationData);
    return "C - " + (check random:createIntInRange(100, 1000)).toString();
}

function getAgreementFormPath() returns string {
    return "./resources/agreements/sample_agreement_form.txt";
}
