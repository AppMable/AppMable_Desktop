import 'package:appmable_desktop/domain/services/start_up_router_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartUpService {
  final StartUpRouterService _startUpRouterService;

  const StartUpService(
    this._startUpRouterService,
  );

  Future<String> execute() async {
    return _startUpRouterService.execute();
  }
}
