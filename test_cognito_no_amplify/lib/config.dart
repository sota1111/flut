import 'package:amazon_cognito_identity_dart_2/cognito.dart';

const String email = 'sota.moro@gmail.com';
const String password = 'morohasH4_';

const String cognitoDomain = 'chat';
const String cognitoUserPoolId = 'ap-northeast-1_hvrlhTL9X';
const String cognitoClientId = 'db45ulgkpq59deqhq5ikvvqlr';
const String cognitoFedIdPoolId = 'ap-northeast-1:b39199c7-8bd9-4568-be2d-7eee202d49e3';

final CognitoUserPool cognitoUserPool = CognitoUserPool(
  cognitoUserPoolId,
  cognitoClientId,
);

final CognitoCredentials credentials = CognitoCredentials(
  cognitoFedIdPoolId,
  cognitoUserPool,
);
