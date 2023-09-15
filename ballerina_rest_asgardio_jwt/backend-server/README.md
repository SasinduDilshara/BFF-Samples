## Ballerina with Asgardeo to enable user authentication and authorization

Authenticating users and authorizing access are critical necessities for any front-end application. Today's digital landscape demands much more than simple username-password based authentications. Instead, enterprise-grade apps now require integration with identity providers to offer advanced security features like centralized user management, multi-factor authentication, social logins, and role-based access control. 

Ballerina simplifies this integration process by allowing seamless connection to any OAuth2-compatible identity provider. With a simple set of annotations added to any service, Ballerina automatically handles authentication and authorization based on tokens issued by the identity provider.

### Set up

1. Clone the project 

```
$ git clone https://github.com/SasinduDilshara/BFF-Samples.git
```

2. Create a new Asgardeo Application and configure it into the `ballerina_rest_asgardeo_jwt/Config.toml`. Please refer this to get more details.

3. Open a Terminal and run the Ballerina Server

```
$ cd BFF-Samples
$ cd ballerina_rest_asgardeo_jwt
$ bal run
```

4. Then open a new terminal in the project path and run the React server

```
$ cd BFF-Samples
$ cd ballerina_rest_asgardeo_jwt/ui
$ npm start
```
