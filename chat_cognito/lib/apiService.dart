import 'package:amplify_auth_cognito/amplify_auth_cognito.dart' as auth;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class ApiService {
  String? _identityId;
  String? get getIdentityId => _identityId;

  Future<AwsSigV4Client> _createSigV4Client() async {
    return AwsSigV4Client(
      credentials.accessKeyId!,
      credentials.secretAccessKey!,
      'https://baf4kq3w1d.execute-api.ap-northeast-1.amazonaws.com/Prod/',
      sessionToken: credentials.sessionToken,
      region: 'ap-northeast-1',
    );
  }

  Future<Map<String, dynamic>> performAuthorizedGet() async {
    try {
      final jwtToken = await _fetchIdToken();
      await credentials.getAwsCredentials(jwtToken);
      final awsSigV4Client = await _createSigV4Client();

      final SigV4Request sigV4Request = SigV4Request(
        awsSigV4Client,
        method: 'GET',
        path: 'ask',
      );

      try {
        http.Response response = await http.get(
          Uri.parse(sigV4Request.url!),
          headers: Map<String, String>.from({
            'Authorization': jwtToken,
            'header': 'head',
          }),
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          return jsonResponse;
        } else {
          return {'status': 'Failed', 'reason': 'Non-200 response'};
        }
      } catch (e) {
        return {'status': 'Error', 'reason': e.toString()};
      }
    } catch (e) {
      return {'status': 'Error', 'reason': e.toString()};
    }
  }


  Future<Map<String, dynamic>> performAuthorizedPost(String inputText) async {
    try {
      final jwtToken = await _fetchIdToken();
      await credentials.getAwsCredentials(jwtToken);
      final awsSigV4Client = await _createSigV4Client();
      String characterName = "tetris_cat";

      final SigV4Request sigV4Request = SigV4Request(
        awsSigV4Client,
        method: 'POST',
        path: 'ask',
        body: Map<String, dynamic>.from({
          'input_text': inputText,
          'identity_id': _identityId,
          'character_name': characterName
        }),
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

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print("jsonResponse:$jsonResponse");
          return jsonResponse;
        } else {
          return {'status': 'Failed', 'reason': 'Non-200 response'};
        }
      } catch (e) {
        print(e);
        return {'status': 'Error', 'reason': e.toString()};
      }
    } catch (e) {
      print(e);
      return {'status': 'Error', 'reason': e.toString()};
    }
  }

  Future<String> _fetchIdToken() async {
    final result = await Amplify.Auth.fetchAuthSession() as auth.CognitoAuthSession;
    _identityId = result.userSubResult.value;
    if (result.userPoolTokensResult.value != null) {
      return result.userPoolTokensResult.value!.idToken.raw;
    }
    throw Exception('Failed to fetch user pool tokens');
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      print('Successfully signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
