import 'package:appmable_desktop/domain/model/objects/alert.dart';

abstract class AlertRepository {
  Future<List<Alert>> getAlerts({
    required int userId,
    required String userToken,
  });

  Future<Alert?> getAlert({
    required int alertId,
    required String userToken,
  });

  Future<bool> deleteAlert({
    required int alertId,
    required String userToken,
  });

  Future<bool> createAlert({
    required Map<String, dynamic> alert,
    required String userToken,
  });

  Future<bool> updateAlert({
    required Map<String, dynamic> alert,
    required String userToken,
  });
}
