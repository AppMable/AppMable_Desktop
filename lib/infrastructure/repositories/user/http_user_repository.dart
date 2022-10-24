import 'dart:convert';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: UserRepository)
class HttpUserRepository implements UserRepository {
  final HttpService _httpService;

  HttpUserRepository(
    this._httpService,
  );

  static const String urlGetAllUsers = 'http://127.0.0.1:8000/users/?c=<userToken>';
  static const String urlCrud = 'http://127.0.0.1:8000/users/d/?id=<userId>&t=<userType>&c=<userToken>';

  @override
  Future<List<User>> readAllUsers({
    required String userToken,
  }) async {
    final String urlAllUsers = urlGetAllUsers.replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(urlAllUsers));

    if (response.statusCode == 200) {
      List<User> users = [];

      List<dynamic> usersDecoded = jsonDecode(response.body);

      for (Map<String, dynamic> user in usersDecoded) {
        users.add(User.fromMap(user));
      }

      return users;
    }

    return [];
  }

  @override
  Future<User?> getUser({
    required String userId,
    required String userType,
    required String userToken,
  }) async {
    final String url = urlCrud
        .replaceAll('<userId>', userId)
        .replaceAll('<userType>', userType)
        .replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> userDecoded = jsonDecode(response.body);

      return User(
        id: userDecoded['id'],
        identityNumber: userDecoded['identity_number'],
        username: userDecoded['username'],
        password: userDecoded['password'],
        name: userDecoded['name'],
        surname: userDecoded['surname'],
        email: userDecoded['email'],
        phoneNumber: userDecoded['phone_number'],
        dateOfBirth: userDecoded['date_of_birth'] != null ? DateUtils.dateOnly(DateTime.parse(userDecoded['date_of_birth'])) : null,
        dateCreated: userDecoded['date_created'] != null ? DateTime.parse(userDecoded['date_created']) : null,
        dateLastLogin: userDecoded['date_last_login'] != null ? DateTime.parse(userDecoded['date_last_login']) : null,
        healthCardIdentifier: userDecoded['health_card_identifier'],
        idUserRole: userDecoded['id_user_role'],
        idUserReference: userDecoded['id_user_reference'],
      );
    }
    return null;
  }

  Future<bool> deleteUser({
    required String userId,
    required String userType,
    required String userToken,
  }) async {
    final String urlDelete = urlCrud
        .replaceAll('<userId>', userToken)
        .replaceAll('<userType>', userType)
        .replaceAll('<userToken>', userToken);

    final Response response = await _httpService.delete(Uri.parse(urlDelete));

    return response.statusCode == 200;
  }
}
