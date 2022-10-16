import 'package:appmable_desktop/application/bloc/login_screen/login_screen_bloc.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/login/login.dart';
part 'widgets/login/widgets/btn_restore_password.dart';
part 'widgets/login/widgets/btn_log_in.dart';
part 'widgets/login/widgets/custom_text_field.dart';
part 'widgets/register/register.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenBloc _loginScreenBloc =
      GetIt.instance.get<LoginScreenBloc>();

  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginScreenBloc, LoginScreenState>(
        bloc: _loginScreenBloc,
        builder: (context, state) {
          if (state is LoginScreenInitial || state is LoginScreenLoaded) {
            return Login(loginScreenBloc: _loginScreenBloc);
          } else if (state is RegisterScreenLoaded) {
            return Register(loginScreenBloc: _loginScreenBloc);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
