import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:http/http.dart' as http;
import 'amplifyconfiguration.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.addPlugin(AmplifyAPI()); // Add the API plugin
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  Future<void> _callLambda() async {
    print('call Lambda');
    try {
      print('try');
      setState(() {
        _responseText = "try";
      });
      final restOperation = Amplify.API.get('chat-docker');
      print('try2');
      final response = await restOperation.response;
      print('GET call succeeded: ${response.decodeBody()}');

      setState(() {
        _responseText = response.decodeBody();
      });

    } on ApiException catch (e) {
      print('GET call failed');
      setState(() {
        _responseText = "error";
        print('GET call failed: $e');
      });
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
                  onPressed: _callLambda,
                  child: Text('Call Lambda'),
                ),
                SizedBox(height: 20),
                Text('API Result: $_apiResult'), // 新しく追加したAPIのレスポンスを表示
                ElevatedButton(
                  onPressed: _getFleetData,
                  child: Text('Get Fleet Data'), // 新しく追加したボタン
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
