import 'package:appmable_desktop/domain/model/objects/button.dart';

abstract class ButtonApiRepository {
  Future<List<Button>> readAll();
}

