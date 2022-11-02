import 'package:faker/faker.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';

UserLoginInformation userLoginInformationMockGenerator({
  String? userId,
  String? userRole,
  String? userName,
  String? userToken,
}) {
  return UserLoginInformation(
    userId: userId ?? faker.randomGenerator.integer(5).toString(),
    userRole: userRole ?? faker.lorem.words(1).first,
    userName: userName ?? faker.lorem.words(1).first,
    userToken: userToken ?? faker.lorem.words(5).join(),
  );
}

String getUserLoginHttpStringFromUserLoginInformation(UserLoginInformation userLoginInformation) {
  return '["${userLoginInformation.userId}:${userLoginInformation.userName}:${userLoginInformation.userRole}:${userLoginInformation.userToken}"]';
}
