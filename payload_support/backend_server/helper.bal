import ballerina/http;

int customerIndex = 100;

function getAgreementFormPath(string id) returns string {
    return "./resources/agreements/sample_agreement_form.txt";
}

function registerAndGetId(CustomerRegistrationData registrationData, byte[] agreemntForm, byte[] logoImage) returns string {
    customerIndex = customerIndex + 1;
    customerTable.add(registrationData);
    return "C - " + customerIndex.toString();
}

function handleErrorRequests(json|error registrationData, byte[]|error agreemntForm,
         byte[]|error image) returns http:BadRequest|http:InternalServerError {
    if registrationData is error {
        return <http:BadRequest>{body: {message: registrationData.message()}};
    } else if agreemntForm is error {
        return <http:InternalServerError>{body: {message: "Agreement form is invalid"}};
    } else {
        return <http:InternalServerError>{body: {message: "Image is invalid"}};
    }
}
