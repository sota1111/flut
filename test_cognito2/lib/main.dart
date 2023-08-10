import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
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
    try {
      print('Lambda response:');
    } on Exception catch (e) {
      print('Error calling Lambda: $e');
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
                ElevatedButton(
                  onPressed: _callLambda,
                  child: Text('Call Lambda'),
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
