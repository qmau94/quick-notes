# graphql-nodejs-serverless-dynamodb

## Require
- Simple Nodejs API using graphql serverless and dynamodb.
- Perform create, read, update, and delete operations on the table.
- Run simple queries with graphql.
- [Sample movies data json file](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/samples/moviedata.zip)

## Envinronment
- [Nodejs](https://nodejs.org/en/)
- [Local DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html)
- [SAM local](https://github.com/awslabs/aws-sam-local)
- [awscli](https://aws.amazon.com/cli/)
- GraphQL, express, apollo-server-express, graphql-tools, apollo-server-lambda, aws-sdk plugins for nodejs project
```bash
npm init
npm install -s graphql
npm install -s aws-sdk
npm install -s apollo-server-lambda
npm install -s express
```

## Local developement

### Import moviedata
`importMovies.js`

```javascript
var AWS = require("aws-sdk");
var fs = require('fs');

AWS.config.update({
    region: "ap-northeast-1",
    endpoint: "http://localhost:8000"
});

var dynamodb = new AWS.DynamoDB();
var docClient = new AWS.DynamoDB.DocumentClient();
var allMovies = JSON.parse(fs.readFileSync('moviedata.json', 'utf8'));

var params = {
    TableName : "Movies",
    KeySchema: [
        { AttributeName: "year", KeyType: "HASH"},  //Partition key
        { AttributeName: "title", KeyType: "RANGE" }  //Sort key
    ],
    AttributeDefinitions: [
        { AttributeName: "year", AttributeType: "N" },
        { AttributeName: "title", AttributeType: "S" }
    ],
    ProvisionedThroughput: {
        ReadCapacityUnits: 10,
        WriteCapacityUnits: 10
    }
};

dynamodb.createTable(params, function(err, data) {
    if (err) {
        console.error("Unable to create table. Error JSON:", JSON.stringify(err, null, 2));
    } else {
        console.log("Created table. Table description JSON:", JSON.stringify(data, null, 2));
    }
});

console.log("Importing movies into DynamoDB. Please wait.");

allMovies.forEach(function(movie) {
    var params = {
        TableName: "Movies",
        Item: {
            "year":  movie.year,
            "title": movie.title,
            "info":  movie.info
        }
    };

    docClient.put(params, function(err, data) {
        if (err) {
            console.error("Unable to add movie", movie.title, ". Error JSON:", JSON.stringify(err, null, 2));
        } else {
            console.log("PutItem succeeded:", movie.title);
        }
    });
});

```

```bash
node importMovies.js
```

### Handler function

`handler.js`

```javascript
const {
    graphql,
    GraphQLSchema,
    GraphQLObjectType,
    GraphQLString,
    GraphQLNonNull
} = require('graphql');
const AWS = require('aws-sdk');
const dynamoDb = new AWS.DynamoDB.DocumentClient();


```

## Serverless - AWS Lambda

## Refs
- [Designing a GraphQL API](https://docs.aws.amazon.com/appsync/latest/devguide/designing-a-graphql-api.html)
- [Running a scalable & reliable GraphQL endpoint with Serverless](https://serverless.com/blog/running-scalable-reliable-graphql-endpoint-with-serverless/)
- [GraphQL query endpoint in NodeJS on AWS with DynamoDB](https://github.com/serverless/examples/tree/master/aws-node-graphql-api-with-dynamodb)
-
