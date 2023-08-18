import 'package:amplify_auth_cognito/amplify_auth_cognito.dart' as auth;
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:http/http.dart' as http;
import 'amplifyconfiguration.dart';
import 'dart:convert';
import 'config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CognitoUserSession? session;

  String _responseText = "";
  String _apiResult = "";
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _getFleetData() async {
    var url = Uri.parse('https://aelmwouyzf.execute-api.ap-northeast-1.amazonaws.com/default/getFleetDDB');
    print("debug");
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Date': "2023-06-01",
      }),
    );
    debugPrint('Response status code: ${response.statusCode}');
  }

  void _configureAmplify() async {
    try {
      final authPlugin = auth.AmplifyAuthCognito();
      Amplify.addPlugin(authPlugin);
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  Future<String> fetchIdToken() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession() as auth.CognitoAuthSession;

      if (result.userPoolTokensResult.value != null) {
        return result.userPoolTokensResult.value!.idToken.raw;
      } else {
        throw Exception('Failed to fetch user pool tokens');
      }
    } catch (e) {
      print('Error fetching auth session: $e');
      throw e;
    }
  }


  Future<void> _performAuthorizedGet() async {
    String? jwtToken;
    AuthSession session = await Amplify.Auth.fetchAuthSession();
    final result = await Amplify.Auth.fetchAuthSession() as auth.CognitoAuthSession;
    jwtToken = result.userPoolTokensResult.value.idToken.raw;
    await credentials.getAwsCredentials(jwtToken);

    final localSession = session;

    if (localSession != null) {
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
  }

  Future<void> _signOut() async {
    try {
      await Amplify.Auth.signOut();
      safePrint('Successfully signed out');
    } on Exception catch (e) {
      safePrint('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You are logged in!'),
                SizedBox(height: 20),
                Text('Response: $_responseText'),
                ElevatedButton(
                  onPressed: _performAuthorizedGet,
                  child: Text('Call Lambda'),
                ),
                SizedBox(height: 20),
                Text('API Result: $_apiResult'),
                ElevatedButton(
                  onPressed: _getFleetData,
                  child: Text('Get Fleet Data'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signOut,
                  child: Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
