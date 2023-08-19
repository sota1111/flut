import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart' as auth;
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:http/http.dart' as http;
import 'amplifyconfiguration.dart';
import 'dart:convert';
import 'config.dart';
import 'chat_tetris.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _responseText = "";
  String _apiResult = "";

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      final authPlugin = auth.AmplifyAuthCognito();
      Amplify.addPlugin(authPlugin);
      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  Future<AwsSigV4Client> _createSigV4Client() async {
    return AwsSigV4Client(
      credentials.accessKeyId!,
      credentials.secretAccessKey!,
      'https://baf4kq3w1d.execute-api.ap-northeast-1.amazonaws.com/Prod/',
      sessionToken: credentials.sessionToken,
      region: 'ap-northeast-1',
    );
  }

  Future<void> _performAuthorizedGet() async {
    try {
      final jwtToken = await fetchIdToken();
      await credentials.getAwsCredentials(jwtToken);
      final awsSigV4Client = await _createSigV4Client();

      final SigV4Request sigV4Request = SigV4Request(
        awsSigV4Client,
        method: 'GET',
        path: 'ask',
        //headers: Map<String, String>.from({'header-1': 'one', 'header-2': 'two'}),
        //queryParams: Map<String, String>.from({'tracking': 'x123'}),
        //body: jsonEncode(Map<String, dynamic>.from({'input_text': 'none'})),
      );

      try {
        http.Response response = await http.get(
          Uri.parse(sigV4Request.url!),
          headers: Map<String, String>.from({
            'Authorization': jwtToken,
            'header': 'head',
          }),
        );
        print(response.body);
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _performAuthorizedPost() async {
    try {
      final jwtToken = await fetchIdToken();
      await credentials.getAwsCredentials(jwtToken);
      final awsSigV4Client = await _createSigV4Client();

      final SigV4Request sigV4Request = SigV4Request(
        awsSigV4Client,
        method: 'POST',
        path: 'ask',
        //headers: Map<String, String>.from({'header-1': 'one', 'header-2': 'two'}),
        //queryParams: Map<String, String>.from({'tracking': 'x123'}),
        body: Map<String, dynamic>.from({'input_text': '列を消した時の点数を教えて'}),
      );

      try {
        http.Response response = await http.post(
          Uri.parse(sigV4Request.url!),
          headers: Map<String, String>.from({
            'Authorization': jwtToken,
            'header': 'head',
          }),
          body: sigV4Request.body,
        );
        print(response.body);
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> fetchIdToken() async {
    final result = await Amplify.Auth.fetchAuthSession() as auth.CognitoAuthSession;
    if (result.userPoolTokensResult.value != null) {
      return result.userPoolTokensResult.value!.idToken.raw;
    }
    throw Exception('Failed to fetch user pool tokens');
  }

  Future<void> _signOut() async {
    try {
      await Amplify.Auth.signOut();
      print('Successfully signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: ChatRoomTetris(), // ここを変更しました
      ),
    );
  }
}

Future<void> _getFleetData() async {
  var url = Uri.parse('https://aelmwouyzf.execute-api.ap-northeast-1.amazonaws.com/default/getFleetDDB');
  try {
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
  } catch (e) {
    print(e);
  }
}
