const amplifyconfig = '''{
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "api": {
    "plugins": {
      "awsAPIPlugin": {
        "api": {
          "endpointType": "REST",
          "endpoint": "https://c34lfewxic.execute-api.ap-northeast-1.amazonaws.com/dev",
          "region": "ap-northeast-1",
          "authorizationType": "AWS_IAM"
        }
      }
    }
  },
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "CognitoUserPool": {
          "Default": {
            "PoolId": "ap-northeast-1_hvrlhTL9X",
            "AppClientId": "db45ulgkpq59deqhq5ikvvqlr",
            "Region": "ap-northeast-1"
          }
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "USER_SRP_AUTH",
            "socialProviders": [],
            "usernameAttributes": [],
            "signupAttributes": [
              "email"
            ],
            "passwordProtectionSettings": {
              "passwordPolicyMinLength": 8,
              "passwordPolicyCharacters": []
            },
            "mfaConfiguration": "OFF",
            "mfaTypes": [
              "SMS"
            ],
            "verificationMechanisms": [
              "EMAIL"
            ]
          }
        }
      }
    }
  }
}''';
