## Ballerina Persists module with databases

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
