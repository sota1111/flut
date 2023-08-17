import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cognito Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CognitoUserSession? session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cognito Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: session == null ? _login : null, // null to disable the button if already logged in
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: session != null ? _performAuthorizedGet : null, // null to disable the button if not logged in
              child: Text('Authorized Get'),
            ),
            ElevatedButton(
              onPressed: session != null ? _logout : null, // null to disable the button if not logged in
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    final CognitoUser cognitoUser = CognitoUser(email, cognitoUserPool);
    final AuthenticationDetails authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );

    try {
      print("Authentication starting...");
      session = await cognitoUser.authenticateUser(authDetails);
      print("Authentication finished.");
      if (session != null) {
        print("Login successful!");  // ログイン成功時のメッセージ
      } else {
        print("Login failed. Session is null.");  // ログイン失敗時のメッセージ
      }
      setState(() {});  // 更新UI
    } catch (e) {
      print("Error during authentication: $e");
    }
  }

  Future<void> _performAuthorizedGet() async {
    if (session == null) {
      print("Not logged in");
      return;
    }

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

    final jwtToken = session!.getIdToken().getJwtToken();
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

  void _logout() {
    session = null;
    setState(() {}); // 更新UI
  }
}
