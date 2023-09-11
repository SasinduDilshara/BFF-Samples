# Backend to Frontend Sample Codes with Ballerina

Web apps and mobile apps serve as the primary interface for digital organizations, making it crucial for these apps to be highly responsive, secure, and capable of handling real-time data. Therefore, the backends powering these apps have the complex task of aggregating data from a wide range of source systems, transforming data as necessary, and transmitting it to the frontends over the required protocol. 

Ballerina stands out as an ideal choice for developing such backends, thanks to its native capabilities for data exposure over multiple protocols, a comprehensive collection of connectors to source systems, built-in authentication and authorization features, and advanced data transformation capabilities.

## Ballerina with REST features

Most web apps rely on REST APIs, with JSON serving as the predominant data exchange format. Handling REST API elements like path parameters, query parameters, HTTP headers, status codes, and complex JSON structures is crucial for web app backends. Ballerina addresses these needs effectively by incorporating all these REST features as first-class citizens within the language itself, simplifying the backend development process and making it more intuitive and efficient.

### Set up

1. Clone the project

```
$ git clone https://github.com/SasinduDilshara/BFF-Samples.git
```

2. Open a Terminal and run the Ballerina Server

```
$ cd BFF-Samples
$ cd ballerina_rest
$ bal run
```

3. Then open a new terminal in the project path and run the React server

```
$ cd BFF-Samples
$ cd ballerina_rest/ui
$ npm start
```

## Ballerina with advanced payload validations

Web and mobile apps often transmit users' input as JSON payloads, requiring backends to handle JSON data extensively. Ballerina simplifies this by seamlessly mapping JSON data to its native records, enabling easier data manipulation. Additionally, Ballerina records offer features like constraint validation, optional fields, and open records, providing enhanced flexibility and control when working with dynamic frontends.

### Set up

1. Clone the project 

```
$ git clone https://github.com/SasinduDilshara/BFF-Samples.git
```

2. Open a Terminal and run the Ballerina Server

```
$ cd BFF-Samples
$ cd ballerina_rest_payload_validation
$ bal run
```

3. Then open a new terminal in the project path and run the React server

```
$ cd BFF-Samples
$ cd ballerina_rest_payload_validation/ui
$ npm start
```

## Ballerina with GraphQL features

Web and mobile apps act as the interface for vast amounts of consolidated data, often requiring users to perform complex queries. With Ballerina's built-in GraphQL functionality, backend developers can simply expose Ballerina records via GraphQL services, facilitating advanced querying and targeted data fetching. This avoids over-fetching and under-fetching of data and reduces the number of network calls, resulting in better response times and lesser resource usage.

### Set up

1. Clone the project 

```
$ git clone https://github.com/SasinduDilshara/BFF-Samples.git
```

2. Open a Terminal and run the Ballerina Server

```
$ cd BFF-Samples
$ cd ballerina_graphql
$ bal run
```

3. Then open a new terminal in the project path and run the React server

```
$ cd BFF-Samples
$ cd ballerina_graphql/ui
$ npm start
```

## Ballerina with Websockets

Modern web and mobile app users expect real-time updates, whether it's tracking a cab's live location or viewing up-to-the-minute inventory levels. In-app chat functionality with sales agents or colleagues has also become a common feature. WebSockets emerge as the ideal technology for these real-time data transfers between front-end and back-end systems. 

Ballerina offers robust support for WebSockets, allowing services to be easily exposed over WebSocket connections. JSON-based WebSocket data is automatically mapped to Ballerina records, enabling simplified data processing. This comes with enterprise-ready security features like TLS, mutual MTLS, and OAuth2, ensuring authenticated and authorized streaming data transfers.

### Set up

1. Clone the project 

```
$ git clone https://github.com/SasinduDilshara/BFF-Samples.git
```

2. Open a Terminal and run the Ballerina Server

```
$ cd BFF-Samples
$ cd ballerina_websocket
$ bal run
```

3. Then open a new terminal in the project path and run the React server

```
$ cd BFF-Samples
$ cd ballerina_websocket/ui
$ npm start
```

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

## Ballerina for securely consume services from backends

In today's IT environments where services are scattered across on-premises and cloud, no link is guaranteed to be secure. Strict security measures need to be enforced on all links. There is no exception for web or mobile app backends. Ballerina-powered backends can securely call services - whether on-premise, in a private cloud, or SaaS - with the necessary security features such as client-side OAuth2, mutual TLS, and JWT-encapsulated user data.

### Set up

1. Clone the project 

```
$ git clone https://github.com/SasinduDilshara/BFF-Samples.git
```

2. Create a new Asgardeo Application and configure it into the `ballerina_rest_asgardeo_jwt/Config.toml`. Please refer this to get more details.

3. Open a Terminal and run the Ballerina Server

```
$ cd BFF-Samples
$ cd ballerina_microservices_jwt_asgardeo
$ bal run
```

4. Then open a new terminal in the project path and run the React server

```
$ cd BFF-Samples
$ cd ballerina_microservices_jwt_asgardeo/ui
$ npm start
```

## Let Ballerina write the data access code for your apps

Ballerina's persistence features offer a straightforward way to work with data sources, making it easier to build an application's data access layer. By simply defining the required Ballerina records, the persistence package auto-generates all data access functions. This eliminates repetitive code, providing a simplified interface for inserting, updating and querying data with data tables directly mapped to Ballerina records.

1. Clone the project 

```
$ git clone https://github.com/SasinduDilshara/BFF-Samples.git
```

2. Create a new Asgardeo Application and configure it into the `ballerina_rest_asgardeo_jwt/Config.toml`. Please refer this to get more details.

3. Open a Terminal and run the Ballerina Server

```
$ cd BFF-Samples
$ cd ballerina_persists
$ bal run
```

4. Then open a new terminal in the project path and run the React server

```
$ cd BFF-Samples
$ cd ballerina_persists/ui
$ npm start
```
