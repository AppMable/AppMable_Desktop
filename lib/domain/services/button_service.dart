import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/model/objects/button.dart';
import 'package:appmable_desktop/domain/repositories/button_repository.dart';

@injectable
class ButtonService {
  final ButtonRepository _buttonRepository;

  const ButtonService(
    this._buttonRepository,
  );

  Future<List<Button>> readAll() async {
    try {
      return await _buttonRepository.readAll();
    } catch (_) {
      rethrow;
    }
  }
}
