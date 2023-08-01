import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'env.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // Cognito ユーザープールを設定します
  final userPool = CognitoUserPool(
    AWS_USER_POOL_ID, // Use the imported user pool id
    AWS_APP_CLIENT_ID, // Use the imported app client id
  );

  // ユーザー名とパスワードの入力を管理するためのコントローラーを作成します
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // エラーメッセージを表示するための文字列を用意します
  final errorController = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cognito Sample"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            ValueListenableBuilder(
              valueListenable: errorController,
              builder: (context, String value, _) {
                return Text(value);
              },
            ),
            ElevatedButton(
              child: Text("Sign Up"),
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;

                try {
                  final userAttributes = [
                    new AttributeArg(name: 'email', value: 'example@example.com'),
                    // email attribute is often necessary, replace it with user's email
                  ];

                  final signUpResult = await userPool.signUp(
                    username,
                    password,
                    userAttributes: userAttributes,
                  );

                  if (signUpResult.userConfirmed != null && signUpResult.userConfirmed!) {
                    print('Sign up confirmed');
                  } else {
                    print('Please confirm sign up');
                  }
                } on CognitoUserException catch (e) {
                  // エラーメッセージを表示します
                  errorController.value = e.message!;
                } catch (e) {
                  print(e);
                }
              },
            ),
            ElevatedButton(
              child: Text("Sign In"),
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;

                try {
                  final cognitoUser = new CognitoUser(username, userPool);
                  final authDetails = new AuthenticationDetails(
                      username: username, password: password);
                  await cognitoUser.authenticateUser(authDetails);
                  print('Sign in successful');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                } on CognitoUserNewPasswordRequiredException catch (e) {
                  // New password required, redirect to set new password screen.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPasswordScreen(username, userPool)),
                  );
                } on CognitoClientException catch (e) {
                  if (e.code == 'NotAuthorizedException') {
                    errorController.value = 'NotAuthorizedException';
                  } else {
                    errorController.value = e.message!;
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Text('Login Successful'),
      ),
    );
  }
}

class NewPasswordScreen extends StatefulWidget {
  final String username;
  final CognitoUserPool userPool;

  NewPasswordScreen(this.username, this.userPool);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final newPasswordController = TextEditingController();
  final errorController = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set New Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: "New Password",
              ),
              obscureText: true,
            ),
            ValueListenableBuilder(
              valueListenable: errorController,
              builder: (context, String value, _) {
                return Text(value);
              },
            ),
            ElevatedButton(
              child: Text("Set New Password"),
              onPressed: () async {
                String newPassword = newPasswordController.text;

                try {
                  final cognitoUser = new CognitoUser(widget.username, widget.userPool);
                  final authDetails = new AuthenticationDetails(
                      username: widget.username, password: newPassword);
                  await cognitoUser.authenticateUser(authDetails);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
