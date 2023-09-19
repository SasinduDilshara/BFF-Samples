import ballerina/http;
import ballerina/mime;
import ballerina/constraint;

type CustomerRegistrationData record {|
    @constraint:String {
        pattern: re `[A-Za-z]+`
    }
    string firstName;

    @constraint:String {
        pattern: re `[A-Za-z]+`
    }
    string lastName;

    @constraint:String {
        pattern: re `\d{3},0\s*,[a-zA-Z]{12},0\s*,[a-zA-Z]{12},,0\s*,[a-zA-Z]{8}`
    }
    string address;

    @constraint:Int {
        minValue: 0, maxValue: 10
    }
    int dependents;
|};

@http:ServiceConfig {
    chunking: "ALWAYS",
    compression: {
        enable: http:COMPRESSION_ALWAYS,
        contentTypes: ["application/json", "text/plain"]
    },
    cors: {
        allowOrigins: ["*"]
    }
}
service /crm on new http:Listener(9090) {

    @http:ResourceConfig {
        consumes: ["multipart/form-data"],
        produces: ["application/json"]
    }

    resource function post customers(http:Request request) returns 
            http:BadRequest|http:InternalServerError|http:Created {
        mime:Entity[]|error bodyParts = request.getBodyParts();
        if bodyParts is error {
            return <http:BadRequest>{body: {message: "Error while parsing the request body"}};
        }
        CustomerRegistrationData|error registrationData = bodyParts[0].getJson().ensureType();
        byte[]|error agreemntForm = bodyParts[1].getByteArray();
        byte[]|error image = bodyParts[2].getByteArray();
        if registrationData is error || agreemntForm is error || image is error {
            return <http:BadRequest>{body: {message: "Error while parsing the request body"}};
        }
        string|error customerId = registerCustomer(
            registrationData, agreemntForm, image);
        if customerId is error {
            return <http:InternalServerError>{body: {message: "Error while registering the customer"}};
        }
        return <http:Created>{body: {status: "Customer registered successfully.", customerId: customerId}};
    }
    
    @http:ResourceConfig {
        produces: ["application/pdf"]
    }
    resource function get customers/[string customerId]/agreement() returns @http:Cache {maxAge: 15} byte[]|http:NotFound {
        byte[]|error agreementForm = getAgreementForm(customerId);
        if agreementForm is error {
            return <http:NotFound>{body: {message: "Agreement form not found for the customer ID: " + customerId}};
        }
        return agreementForm;   
    }
}

function getAgreementForm(string s) returns byte[]|error {
    return [];
}

function registerCustomer(CustomerRegistrationData registrationData, byte[] agreemntForm, byte[] logoImage) returns string|error {
    return "C-401";
}
