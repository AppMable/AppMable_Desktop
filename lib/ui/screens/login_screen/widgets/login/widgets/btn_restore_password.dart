part of '../../../login_screen.dart';

class BtnRestorePassword extends StatelessWidget {
  const BtnRestorePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF2596be)),
      ),
      onPressed: () {},
      child: const Text(
        'Restablecer contraseña',
        style: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
