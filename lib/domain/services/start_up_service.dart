import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/start_up_router_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartUpService {
  final StartUpRouterService _startUpRouterService;
  final LocalStorageService _localStorageService;

  const StartUpService(
    this._startUpRouterService,
    this._localStorageService,
  );

  Future<String> execute() async {
    await _localStorageService.init();
    return _startUpRouterService.execute();
  }
}
