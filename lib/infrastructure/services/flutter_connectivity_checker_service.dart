import 'package:appmable_desktop/domain/services/connectivity_checker_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ConnectivityCheckerService)
class FlutterConnectivityCheckerService implements ConnectivityCheckerService {
  final Connectivity _connectivity;

  const FlutterConnectivityCheckerService(this._connectivity);

  @override
  Future<bool> hasConnection() async {
    final connectivity = await _connectivity.checkConnectivity();
    switch (connectivity) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
        return true;
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.bluetooth:
        return false;
    }
    return false;
  }
}
