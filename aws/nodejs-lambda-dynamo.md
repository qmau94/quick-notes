# Environment
## SAM Local
SAM dùng để test serverless function trên môi trường local trước khi deploy lên aws lambda

Cài đặt docker: [Hướng dẫn cài đặt và document](https://www.docker.com/)
Cài đặt SAM bằng npm:
```bash
npm install -g aws-sam-local
sam --version
```

## Local dynamo
- serverless-dynanmo-local package
    - Cài đặt [serverless framework](https://serverless.com/)
    ```
    npm install serverless -g
    serverless login
    serverless create --template aws-nodejs
    ```
    - Cài đặt package `serverless-dynamodb-local`
    ```bash
    npm install --save serverless-dynamodb-local
    ```
    `serverless.yml`
    ```yml
    plugins:
        - serverless-dynamodb-local
    custom:
        dynamodb:
            start:
                port: 8000
                inMemory: true
                migrate: true
                seed: true
        resources:
            Resources:
                usersTable:
                Type: AWS::DynamoDB::Table
                Properties:
                    TableName: users
                    AttributeDefinitions:
                    - AttributeName: email
                        AttributeType: S
                    KeySchema:
                    - AttributeName: email
                        KeyType: HASH
                    ProvisionedThroughput:
                    ReadCapacityUnits: 5
                    WriteCapacityUnits: 5
    ```
