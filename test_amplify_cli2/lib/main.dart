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
    final auth = AmplifyAuthCognito();
    final api = AmplifyAPI();

    try {
      await Amplify.addPlugins([api, auth]);
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: const LoggedInScreen(),
      ),
    );
  }
}

class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  Future<void> getTodo() async {
    try {
      final restOperation = Amplify.API.get('todo');
      final response = await restOperation.response;
      print('GET call succeeded: ${response.decodeBody()}');
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You are logged in!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await getTodo();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Button Pressed!')),
                );
              },
              child: Text('GET'),
            ),
          ],
        ),
      ),
    );
  }
}
