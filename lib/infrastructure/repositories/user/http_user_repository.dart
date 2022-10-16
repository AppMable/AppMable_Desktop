import 'package:appmable_desktop/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: UserRepository)
class HttpButtonRepository implements UserRepository {
  final HttpService _httpService;

  HttpButtonRepository(
    this._httpService,
  );

  @override
  Future<bool> logIn({
    required String username,
    required String password,
  }) async =>
      Future.value(true);
}
