// These values are set in `Config.toml` file.
configurable string issuer = ?;
configurable string audience = ?;
configurable string jwksUrl = ?;

public function getIssuer() returns string {
    return issuer;
}

public function getAudience() returns string {
    return audience;
}

public function getJwksUrl() returns string {
    return jwksUrl;
}
