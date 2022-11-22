import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:appmable_desktop/domain/repositories/alert_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AlertService {
  final AlertRepository _alertRepository;

  const AlertService(
    this._alertRepository,
  );

  Future<List<Alert>> getAlerts({
    required int userId,
    required String userToken,
  }) async {
    return _alertRepository.getAlerts(
      userId: userId,
      userToken: userToken,
    );
  }

  Future<Alert?> getAlert({
    required int alertId,
    required userToken,
  }) async {
    return _alertRepository.getAlert(
      alertId: alertId,
      userToken: userToken,
    );
  }

  Future<bool> deleteAlert({
    required int alertId,
    required userToken,
  }) async {
    return _alertRepository.deleteAlert(
      alertId: alertId,
      userToken: userToken,
    );
  }

  Future<bool> createAlert({
    required Map<String, dynamic> alert,
    required userToken,
  }) async {
    return _alertRepository.createAlert(
      alert: alert,
      userToken: userToken,
    );
  }

  Future<bool> updateAlert({
    required Map<String, dynamic> alert,
    required userToken,
  }) async {
    return _alertRepository.updateAlert(
      alert: alert,
      userToken: userToken,
    );
  }
}
