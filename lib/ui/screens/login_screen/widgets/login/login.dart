part of '../../login_screen.dart';

class Login extends StatefulWidget {
  final LoginScreenBloc loginScreenBloc;

  const Login({
    required this.loginScreenBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showUsernameMessageError = false;
  bool showPasswordMessageError = false;
  bool showIncorrectLoginError = false;
  String loginErrorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 42, color: Colors.black, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  textEditingController: _usernameController,
                  labelText: 'Usuario',
                  showError: showUsernameMessageError,
                  errorMessage: 'El campo de usuario debe estar rellenado',
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  textEditingController: _passwordController,
                  labelText: 'Contraseña',
                  showError: showPasswordMessageError,
                  errorMessage: 'El campo de contraseña debe estar rellenado',
                  isPasswordField: true,
                ),
                const SizedBox(height: 50),
                const BtnRestorePassword(),
                const SizedBox(height: 20),
                BtnLogIn(
                  passwordController: _passwordController,
                  usernameController: _usernameController,
                  loginScreenBloc: widget.loginScreenBloc,
                  onUserNameError: () => setState(() => showUsernameMessageError = true),
                  onUserNameSuccess: () => setState(() => showUsernameMessageError = false),
                  onPasswordError: () => setState(() => showPasswordMessageError = true),
                  onPasswordSuccess: () => setState(() => showPasswordMessageError = false),
                  onLoginError: (String errorMsg) => setState(() {
                    showIncorrectLoginError = true;
                    loginErrorMessage = errorMsg;
                  }),
                ),
                showIncorrectLoginError
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            loginErrorMessage,
                            style: const TextStyle(color: AppTheme.error600),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: SizedBox(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppTheme.primary400,
                    AppTheme.primary200,
                    AppTheme.primary200,
                    AppTheme.primary200,
                    AppTheme.primary400,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Hola!!!',
                    style: TextStyle(fontSize: 42, color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Para crear tu cuenta, pulsa al botón de debajo',
                    style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 50),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                      overlayColor: MaterialStateProperty.all<Color>(AppTheme.primary900),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(width: 1, color: Colors.black),
                        ),
                      ),
                    ),
                    onPressed: () => widget.loginScreenBloc.add(const LoadRegisterScreenEvent()),
                    child: const Text('REGISTRAR',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
