// These values are set in `Config.toml` file.
configurable string issuer = ?;
configurable string audience = ?;
configurable string jwksUrl = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

public function getIssuer() returns string {
    return issuer;
}

public function getAudience() returns string {
    return audience;
}

public function getJwksUrl() returns string {
    return jwksUrl;
}

public function getClientId() returns string {
    return clientId;
}

public function getClientSecret() returns string {
    return clientSecret;
}
