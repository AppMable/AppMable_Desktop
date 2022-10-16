import 'package:appmable_desktop/domain/model/objects/button.dart';

abstract class ButtonRepository {
  Future<List<Button>> readAll();
}

