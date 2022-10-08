import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/model/objects/button.dart';
import 'package:appmable_desktop/domain/repositories/button_api_repository.dart';

@injectable
class ButtonService {
  final ButtonApiRepository _buttonApiRepository;

  const ButtonService(
    this._buttonApiRepository,
  );

  Future<List<Button>> readAll() async {
    try {
      return await _buttonApiRepository.readAll();
    } catch (_) {
      rethrow;
    }
  }
}
