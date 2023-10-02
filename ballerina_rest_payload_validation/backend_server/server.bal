import ballerina/http;
import ballerina/mime;
import ballerina/io;
import ballerina/log;
import ballerina/constraint;

public type CustomerRegistrationData record {|
    @constraint:String {
        pattern: {
            value: re `[A-Za-z]+`,
            message: "Invalid first name"
        }
    }
    string firstName;

    @constraint:String {
        pattern: {
            value: re `[A-Za-z]+`,
            message: "Invalid last name"
        }
    }
    string lastName;

    @constraint:String {
        pattern: {
            value: re `\d{1,3},\s*[a-zA-Z]{1,12},\s*[a-zA-Z]{1,12},\s*[a-zA-Z]{1,8}`,
            message: "Invalid Address"
        }
    }
    string address;

    @constraint:Int {
        minValue: {
            value: 0,
            message: "Dependent count should be greater than 0"
        }, 
        maxValue: {
            value: 10,
            message: "Dependent count should be less than 10"
        }
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
            return <http:BadRequest>{body: {message: "Error while parsing the request body parts"}};
        }
        string|error registrationDataString = bodyParts[0].getText();
        if registrationDataString is error {
            return <http:InternalServerError>{body: {message: "Error while registering the customer"}};
        }
        json|error registrationDataJson = registrationDataString.fromJsonString();
        if registrationDataJson is error {
            return <http:InternalServerError>{body: {message: "Error while registering the customer"}};
        }
        CustomerRegistrationData|error registrationDataRec = registrationDataJson.cloneWithType();
        if registrationDataRec is error {
            return <http:InternalServerError>{body: {message: "Error while registering the customer"}};
        }
        CustomerRegistrationData|error registrationData = constraint:validate(registrationDataRec);
        byte[]|error agreemntForm = bodyParts[1].getByteArray();
        if agreemntForm is error {
            log:printError("agreement: ",agreemntForm);
        }
        byte[]|error image = bodyParts[2].getByteArray();
        if image is error {
            log:printError("image: ",image);
        }
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

    resource function get customers() returns  CustomerRegistrationData[] {
        return customerTable;
    }
}

function getAgreementForm(string s) returns byte[]|error {
    string filePath = getAgreementFormPath(s);
    return check io:fileReadBytes(filePath);
}

function registerCustomer(CustomerRegistrationData registrationData, byte[] agreemntForm, byte[] logoImage) returns string|error =>
     registerAndGetId(registrationData, agreemntForm, logoImage);
