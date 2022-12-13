import 'package:appmable_desktop/application/bloc/login_screen/login_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/mixin/user_mixin.dart';
import 'package:appmable_desktop/ui/common/widgets/change_password_button/change_password_button.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserInfo extends StatefulWidget {

  static const userInformation = 'userInformation';

  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with UserMixin {
  bool showIncorrectLogOutError = false;
  String logOutErrorMessage = '';

  final LoginScreenBloc _loginScreenBloc = GetIt.instance.get<LoginScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return CategoryBox(
      suffix: Container(),
      title: "Información del usuario",
      children: [
        Expanded(
          child: _userInfo(),
        ),
      ],
    );
  }

  Widget _userInfo() {
    final User user = getUser();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Styles.defaultLightWhiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Nombre usuario:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(user.username),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('Nombre y Apellidos:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text('${user.name} ${user.surname}'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(user.email),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('Teléfono de contacto:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(user.phoneNumber),
            ],
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              const ChangePasswordButton(),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primary900),
                  overlayColor: MaterialStateProperty.all<Color>(AppTheme.primary200),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  _loginScreenBloc.add(LogOutEvent(
                    onLogOutSuccess: () {
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    },
                    onLogOutError: (String error) {
                      setState(() {
                        showIncorrectLogOutError = true;
                        logOutErrorMessage = error;
                      });
                    },
                  ));
                },
                child: const Text(
                  'Cerrar Sessión',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          showIncorrectLogOutError
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      logOutErrorMessage,
                      style: const TextStyle(color: AppTheme.error600),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
