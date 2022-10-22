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

  static const String urlGetAllUsers = 'http://127.0.0.1:8000/users/?c=<userToken>';

  @override
  Future<List<User>> readAllUsers({
    required String userToken,
  }) async {
    final String urlAllUsers = urlGetAllUsers.replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(urlAllUsers));

    if (response.statusCode == 200) {
      List<User> users = [];

      List<dynamic> usersDecoded = jsonDecode(response.body);

      for(Map<String, dynamic> user in usersDecoded){
        users.add(User.fromMap(user));
      }


      return users;
    }

    return [];
  }
}
