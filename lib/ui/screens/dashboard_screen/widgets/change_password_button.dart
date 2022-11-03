import 'package:appmable_desktop/application/bloc/users/change_password/change_password_bloc.dart';
import 'package:appmable_desktop/ui/common/forms/text_input.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChangePasswordButton extends StatefulWidget {
  const ChangePasswordButton({Key? key}) : super(key: key);

  @override
  State<ChangePasswordButton> createState() => _ChangePasswordButtonState();
}

class _ChangePasswordButtonState extends State<ChangePasswordButton> {
  final Map<String, dynamic> _userMap = {};

  final ChangePasswordBloc _changePasswordBloc = GetIt.instance.get<ChangePasswordBloc>();

  Future<void> _updateUser({
    required String key,
    required String value,
  }) async =>
      setState(() => _userMap[key] = value.isNotEmpty ? value : null);

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
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(AppTheme.secondary900),
        overlayColor: MaterialStateProperty.all<Color>(AppTheme.secondary200),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: () => _changePasswordDialogBuilder(context),
      child: const Text(
        'Cambiar contraseña',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _changePasswordDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextInput(
                mainAxisSize: MainAxisSize.min,
                placeholder: 'Nueva contraseña',
                label: 'Contraseña',
                isPasswordField: true,
                withExpanded: false,
                callback: (value) => _updateUser(
                  key: 'password',
                  value: value.trim(),
                ),
              ),
              BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                bloc: _changePasswordBloc,
                builder: (context, state) {
                  if (state is PasswordNotUpdated) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          state.error,
                          style: const TextStyle(color: AppTheme.error600),
                        ),
                      ],
                    );
                  } else if (state is PasswordUpdating) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(height: 25),
                        CircularProgressIndicator(
                          color: AppTheme.primary600,
                        )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          actions: [
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.all<Color>(AppTheme.error600),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _changePasswordBloc.add(const ClosePopupChangePassword());
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primary900),
                overlayColor: MaterialStateProperty.all<Color>(AppTheme.primary200),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              onPressed: () {
                _changePasswordBloc.add(ChangePassword(
                  password: _userMap['password'],
                  onSuccess: () {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xff5cb85c),
                      content: Text(
                        'Se han guardado los cambios correctamente',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ));
                  },
                ));
              },
              child: const Text(
                'Cambiar contraseña',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    ).then((_) => _changePasswordBloc.add(const ClosePopupChangePassword()));
  }
}
