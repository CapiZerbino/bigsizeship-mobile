import 'dart:convert';

import 'package:bigsizeship_mobile/core/errors/exception.dart';
import 'package:bigsizeship_mobile/core/services/api_request.dart';
import 'package:bigsizeship_mobile/core/utils/constants.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/authentication/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> getMe({
    required String token,
  });
}

class AuthenticationRemoteDataSourceImplementation
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImplementation(this._client);
  final http.Client _client;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.https(kUrl, 'api/auth/local');
      final body = jsonEncode({
        'identifier': email,
        'password': password,
      });
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await _client.post(
        uri,
        body: body,
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body.toString(),
          statusCode: response.statusCode,
        );
      }
      debugPrint('response.body: ${response.body}');
      final data = jsonDecode(response.body);

      await ApiRequest().saveToken(data['jwt'] as String);

      return UserModel.fromMap(data['user'] as DataMap);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<UserModel> getMe({required String token}) async {
    try {
      final uri = Uri.https(kUrl, 'api/users/me');
      final headers = {'Content-Type': 'application'};
      final response = await _client.get(
        uri,
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body.toString(),
          statusCode: response.statusCode,
        );
      }
      final data = jsonDecode(response.body);

      return UserModel.fromMap(data as DataMap);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
