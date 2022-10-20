part of '../../../login_screen.dart';

class BtnLogIn extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final LoginScreenBloc loginScreenBloc;
  final Function onUserNameError;
  final Function onUserNameSuccess;
  final Function onPasswordError;
  final Function onPasswordSuccess;
  final Function(String error) onLoginError;

  const BtnLogIn({
    required this.usernameController,
    required this.passwordController,
    required this.loginScreenBloc,
    required this.onUserNameError,
    required this.onUserNameSuccess,
    required this.onPasswordError,
    required this.onPasswordSuccess,
    required this.onLoginError,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
        if (usernameController.value.text.isNotEmpty && passwordController.value.text.isNotEmpty) {

          onUserNameSuccess();
          onPasswordSuccess();

          loginScreenBloc.add(LogInEvent(
            username: usernameController.value.text,
            password: passwordController.value.text,
            onLogInSuccess: () {
              Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
            },
            onLogInError: (String error) {
              onLoginError(error);
            },
          ));

        } else {
          usernameController.value.text.isEmpty ? onUserNameError() : onUserNameSuccess();
          passwordController.value.text.isEmpty ? onPasswordError() : onPasswordSuccess();
        }
      },
      child: const Text(
        'INICIAR SESIÓN',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
