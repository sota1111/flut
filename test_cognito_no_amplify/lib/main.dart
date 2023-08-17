import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

Future<void> main() async {
  final CognitoUser cognitoUser = CognitoUser(email, cognitoUserPool);
  final AuthenticationDetails authDetails = AuthenticationDetails(
    username: email,
    password: password,
  );

  CognitoUserSession? session = await cognitoUser.authenticateUser(authDetails);
  await credentials.getAwsCredentials(session!.getIdToken().getJwtToken());

  final AwsSigV4Client awsSigV4Client = AwsSigV4Client(
    credentials.accessKeyId!,
    credentials.secretAccessKey!,
    'https://baf4kq3w1d.execute-api.ap-northeast-1.amazonaws.com/Prod/ask',
    sessionToken: credentials.sessionToken,
    region: 'ap-northeast-1',
  );

  final SigV4Request sigV4Request = SigV4Request(
    awsSigV4Client,
    method: 'GET',
    path: '',
    headers: {'header-1': 'one', 'header-2': 'two'},
    queryParams: {'tracking': 'x123'},
    body: {'color': 'blue'},
  );

  final jwtToken = session.getIdToken().getJwtToken();
  final headers = {
    if (jwtToken != null) 'Authorization': jwtToken,
    'header-2': 'two',
  };

  try {
    http.Response response = await http.get(
      Uri.parse(sigV4Request.url!),
      headers: headers,
    );
    print(response.body);
  } catch (e) {
    print(e);
  }
}
