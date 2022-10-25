import 'package:appmable_desktop/domain/exceptions/repository_error_exception.dart';

class UserNotFoundException implements RepositoryErrorException {
  const UserNotFoundException();
}
