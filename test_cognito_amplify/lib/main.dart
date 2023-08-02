import 'dart:convert';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AuthenticationApp());
}

class AuthenticationApp extends StatefulWidget {
  const AuthenticationApp({Key? key}) : super(key: key);

  @override
  State<AuthenticationApp> createState() => _AuthenticationAppState();
}

class _AuthenticationAppState extends State<AuthenticationApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      final jsonString = await rootBundle.loadString('assets/amplify_configuration.json');
      await Amplify.configure(jsonString);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  void _signOut() async {
    try {
      await Amplify.Auth.signOut();
      print('User successfully signed out');
    } on AuthException catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> _callApi() async {
    const String url = 'https://aelmwouyzf.execute-api.ap-northeast-1.amazonaws.com/default/getFleetDDB';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"Date": "2023-06-01"}),
    );

    if (response.statusCode == 200) {
      print('API Response: ${response.body}');
    } else {
      print('Error calling API: ${response.statusCode}');
    }
  }

  Future<void> _callAuthApi() async {
    const String url = 'https://oann6llonk.execute-api.ap-northeast-1.amazonaws.com/Prod/ask';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('API Response: ${response.body}');
    } else {
      print('Error calling API: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: Scaffold(
          appBar: AppBar(title: const Text('ホーム')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('ログイン成功！', style: TextStyle(fontSize: 32.0)),
                ElevatedButton(
                  onPressed: _signOut,
                  child: const Text('ログアウト'),
                ),
                ElevatedButton(
                  onPressed: _callApi,
                  child: const Text('API呼び出し'),
                ),
                ElevatedButton(
                  onPressed: _callAuthApi,
                  child: const Text('認証API呼び出し'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
