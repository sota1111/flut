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
        title: Text("Sign Up"),
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
          ],
        ),
      ),
    );
  }
}
