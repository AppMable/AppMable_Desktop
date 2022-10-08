import 'package:appmable_desktop/domain/repositories/api_test_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApiTestService {
  final ApiTestRepository _apiTestRepository;

  const ApiTestService(
    this._apiTestRepository,
  );

  Future<String> readMessage() async {
    try {
      return await _apiTestRepository.readMessage();
    } catch (_) {
      rethrow;
    }
  }
}
