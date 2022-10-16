part of '../../login_screen.dart';

class Register extends StatefulWidget {
  final LoginScreenBloc loginScreenBloc;

  const Register({
    required this.loginScreenBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Register');
  }
}
