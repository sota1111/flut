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
      await Amplify.addPlugin(AmplifyAPI());
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  Future<void> fetchTokenAndCallApi() async {
    try {
      CognitoAuthSession res = (await Amplify.Auth.fetchAuthSession(
          options: const FetchAuthSessionOptions())) as CognitoAuthSession;

      String? accessToken = res.userPoolTokensResult.value.accessToken.toString();
      // Use this access token to authenticate with API Gateway
      // Implement your API Gateway call here
      debugPrint('Access Token: $accessToken');
    } catch (e) {
      debugPrint('Fetching token failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => fetchTokenAndCallApi(),
              child: const Text('Fetch Token and Call API'),
            ),
          ),
        ),
      ),
    );
  }
}
