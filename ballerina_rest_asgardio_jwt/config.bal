// These values are set in `Config.toml` file.


public function getIssuer() returns string {
    return issuer;
}

public function getAudience() returns string {
    return audience;
}

public function getJwksUrl() returns string {
    return jwksUrl;
}
