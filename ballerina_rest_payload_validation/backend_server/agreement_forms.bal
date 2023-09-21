int customerIndex = 100;

function getAgreementFormPath(string id) returns string {
    return "./resources/agreements/agreement_form.txt";
}

function registerAndGetId(CustomerRegistrationData registrationData, byte[] agreemntForm, byte[] logoImage) returns string {
    customerIndex = customerIndex + 1;
    customerTable.push(registrationData);
    return "C - " + customerIndex.toString();
}
