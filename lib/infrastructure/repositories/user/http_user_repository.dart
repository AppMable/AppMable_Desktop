import 'dart:convert';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: UserRepository)
class HttpUserRepository implements UserRepository {
  final HttpService _httpService;

  HttpUserRepository(
    this._httpService,
  );

  static const String urlGetAllUsers = 'http://127.0.0.1:8000/users/?c=<userToken>&t=<userType>';
  static const String urlCrud = 'http://127.0.0.1:8000/users/d/?id=<userId>&t=<userType>&c=<userToken>';

  @override
  Future<List<User>> getUsers({
    required int userReferenceId,
    required String userToken,
  }) async {
    final String url = urlCrud
        .replaceAll('<userId>', userReferenceId.toString())
        .replaceAll('<userType>', 'user')
        .replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<User> users = [];

      List<dynamic> usersDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      for (Map<String, dynamic> user in usersDecoded) {
        if(user['id'] != userReferenceId) users.add(User.fromMap(user));
      }

      return users;
    }

    return [];
  }

  @override
  Future<User?> getUser({
    required int userId,
    required String userToken,
  }) async {
    final String url = urlCrud
        .replaceAll('<userId>', userId.toString())
        .replaceAll('<userType>', 'admin')
        .replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {

      List<dynamic> usersDecoded = jsonDecode(response.body);

      for (Map<String, dynamic> user in usersDecoded) {
        if (user['id'] == userId) {
          return User(
            id: user['id'],
            identityNumber: user['identity_number'],
            username: user['username'],
            password: user['password'],
            name: user['name'],
            surname: user['surname'],
            email: user['email'],
            phoneNumber: user['phone_number'],
            dateOfBirth: user['date_of_birth'] != null ? DateTime.parse(user['date_of_birth']) : null,
            dateCreated: user['date_created'] != null ? DateTime.parse(user['date_created']) : null,
            dateLastLogin: user['date_last_login'] != null ? DateTime.parse(user['date_last_login']) : null,
            dateLastLogout: user['date_last_logout'] != null ? DateTime.parse(user['date_last_logout']) : null,
            healthCardIdentifier: user['health_card_identifier'],
            idUserRole: user['id_user_role'],
            idUserReference: user['id_user_reference'],
          );
        }
      }
    }
    return null;
  }

  @override
  Future<bool> deleteUser({
    required int userId,
    required String userType,
    required String userToken,
  }) async {
    final String urlDelete = urlCrud
        .replaceAll('<userId>', userId.toString())
        .replaceAll('<userType>', userType)
        .replaceAll('<userToken>', userToken);

    final Response response = await _httpService.delete(Uri.parse(urlDelete));

    return response.statusCode == 200;
  }

  @override
  Future<bool> createUser({
    required Map<String, dynamic> user,
    required String userType,
    required String userToken,
  }) async {
    final String urlCreateUser = urlGetAllUsers.replaceAll('<userToken>', userToken).replaceAll('<userType>', userType);

    try {
      final Response response = await _httpService.post(
        Uri.parse(urlCreateUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user),
      );
      return response.statusCode == 201;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> updateUser({
    required Map<String, dynamic> user,
    required String userType,
    required String userToken,
  }) async {
    final String urlUpdateUser = urlCrud
        .replaceAll('<userId>', user['id'].toString())
        .replaceAll('<userType>', userType)
        .replaceAll('<userToken>', userToken);

    try {
      final Response response = await _httpService.put(
        Uri.parse(urlUpdateUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user),
      );
      return response.statusCode == 200;
    } catch (_) {
      rethrow;
    }
  }
}
