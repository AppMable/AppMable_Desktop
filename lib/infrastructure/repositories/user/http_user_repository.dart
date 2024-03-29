import 'dart:convert';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:appmable_desktop/domain/services/encrypter_service.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:intl/intl.dart';

@Injectable(as: UserRepository)
class HttpUserRepository implements UserRepository {
  final HttpService _httpService;
  final EncrypterService _encrypterService;

  HttpUserRepository(
    this._httpService,
    this._encrypterService,
  );

  static const String urlGetAllUsers = '${const String.fromEnvironment("server")}users/?c=<userToken>&t=<userType>';
  static const String urlCreateUser = '${const String.fromEnvironment("server")}users/?c=register&t=<userType>';
  static const String urlCrud =
      '${const String.fromEnvironment("server")}users/d/?id=<userId>&t=<userType>&c=<userToken>';
  static const String urlCreateAdminUser = '${const String.fromEnvironment("server")}users/';

  @override
  Future<List<User>> getAllUsers({
    required String userToken,
    required int userId,
  }) async {
    List<User> users = await _getListUsers(
      userToken: userToken,
      userType: 'admin',
      userIdToExclude: userId,
    );

    users.addAll(await _getListUsers(userToken: userToken, userType: 'user'));

    return users;
  }

  Future<List<User>> _getListUsers({
    required String userToken,
    required String userType,
    int? userIdToExclude,
  }) async {
    List<User> users = [];

    final String url = urlGetAllUsers.replaceAll('<userType>', userType).replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> usersDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      for (Map<String, dynamic> user in usersDecoded) {
        user['password'] = _encrypterService.decrypt(user['password']);
        if (userIdToExclude != user['id']) users.add(User.fromMap(user));
      }
    }

    return users;
  }

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
        if (user['id_user_reference'] == userReferenceId) {
          user['password'] = _encrypterService.decrypt(user['password']);
          users.add(User.fromMap(user));
        }
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
            password: _encrypterService.decrypt(user['password']),
            name: user['name'],
            surname: user['surname'],
            email: user['email'],
            phoneNumber: user['phone_number'],
            isActive: user['active'],
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
  Future<bool> disableUser({
    required Map<String, dynamic> user,
    required String userType,
    required String userToken,
  }) async {

    DateTime dateOfBirth = DateTime.parse(user['date_of_birth']);
    user['date_of_birth'] = DateFormat('yyyy-MM-dd').format(dateOfBirth);

    user['active'] = false;
    user['password'] = _encrypterService.encrypt(user['password']);
    user.remove('id_user_role');

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
  }) async {
    final String urlCreateUserReplaced = urlCreateUser.replaceAll('<userType>', 'user');

    try {
      final Response response = await _httpService.post(
        Uri.parse(urlCreateUserReplaced),
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
  Future<bool> createAdminUser({
    required Map<String, dynamic> user,
  }) async {
    final String urlCreateUserReplaced = urlCreateUser.replaceAll('<userType>', 'admin');

    try {
      final Response response = await _httpService.post(
        Uri.parse(urlCreateUserReplaced),
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
