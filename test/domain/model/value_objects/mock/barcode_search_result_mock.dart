import 'package:faker/faker.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';

UserLoginInformation userLoginInformationMockGenerator({
  String? loginType,
  String? userRole,
  String? userName,
  String? userToken,
}) {
  return UserLoginInformation(
    loginType: loginType ?? faker.lorem.words(1).first,
    userRole: userRole ?? faker.lorem.words(1).first,
    userName: userName ?? faker.lorem.words(1).first,
    userToken: userToken ?? faker.lorem.words(5).join(),
  );
}

String getUserLoginHttpStringFromUserLoginInformation(UserLoginInformation userLoginInformation){
  return '[\"login:${userLoginInformation.loginType}:${userLoginInformation.userRole}:${userLoginInformation.userName}:${userLoginInformation.userToken}\"]';
}
