import 'package:appmable_desktop/application/bloc/users/update_user_screen/update_user_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/forms/text_input.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class UpdateUserScreen extends StatefulWidget {
  static const String routeName = '/update-user-screen';

  const UpdateUserScreen({Key? key}) : super(key: key);

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> _userMap;

  Future<void> _updateUser({
    required String key,
    required String value,
  }) async =>
      setState(() => _userMap[key] = value.isNotEmpty ? value : null);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final UpdateScreenParams args = ModalRoute.of(context)!.settings.arguments! as UpdateScreenParams;
      _userMap = args.user.toMap();
    });

    super.initState();
  }

  final UpdateUserScreenBloc _updateUserScreenBloc = GetIt.instance.get<UpdateUserScreenBloc>();

  @override
  Widget build(BuildContext context) {
    final UpdateScreenParams args = ModalRoute.of(context)!.settings.arguments! as UpdateScreenParams;

    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          title: 'Modificar tutelado',
          content: Row(
            children: [
              Expanded(
                flex: 5,
                child: CategoryBox(
                  title: '',
                  suffix: TextButton(
                    child: Text(
                      'Volver atrás',
                      style: TextStyle(
                        color: Styles.defaultRedColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 15, top: 40),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  TextInput(
                                    placeholder: 'e.g 123456789A',
                                    label: 'Documento de Identidad',
                                    value: args.user.identityNumber,
                                    callback: (value) => _updateUser(
                                      key: 'identity_number',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    placeholder: 'e. g TASA1030101002',
                                    label: 'Tarjeta Sanitaria',
                                    value: args.user.healthCardIdentifier,
                                    callback: (value) => _updateUser(
                                      key: 'health_card_identifier',
                                      value: value.trim(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Row(
                                children: [
                                  TextInput(
                                    label: 'Usuario',
                                    value: args.user.username,
                                    callback: (value) => _updateUser(
                                      key: 'username',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    label: 'Contraseña',
                                    value: args.user.password,
                                    callback: (value) => _updateUser(
                                      key: 'password',
                                      value: value.trim(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Row(
                                children: [
                                  TextInput(
                                    placeholder: 'e. g Jon',
                                    label: 'Nombre',
                                    value: args.user.name,
                                    callback: (value) => _updateUser(
                                      key: 'name',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    placeholder: 'e. g Doe',
                                    label: 'Apellidos',
                                    value: args.user.surname,
                                    callback: (value) => _updateUser(
                                      key: 'surname',
                                      value: value.trim(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Row(
                                children: [
                                  TextInput(
                                    label: 'Email',
                                    value: args.user.email,
                                    callback: (value) => _updateUser(
                                      key: 'email',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    label: 'Teléfono',
                                    value: args.user.phoneNumber,
                                    callback: (value) => _updateUser(
                                      key: 'phone_number',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    placeholder: 'Ej: 31-12-1995',
                                    label: 'Fecha de nacimiento',
                                    value: args.user.dateOfBirth != null
                                        ? DateFormat('dd-MM-yyyy').format(args.user.dateOfBirth!)
                                        : null,
                                    callback: (value) => _updateUser(
                                      key: 'date_of_birth',
                                      value: value.trim(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primary900),
                                    overlayColor: MaterialStateProperty.all<Color>(AppTheme.primary200),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    _updateUserScreenBloc.add(UpdateUserEvent(
                                      userId: args.user.id.toString(),
                                      user: _userMap,
                                      onError: (String errorMsg) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          backgroundColor: AppTheme.error600,
                                          content: Text(
                                            errorMsg,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ));
                                      },
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
                                    'Guardar cambios',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: Responsive.isDesktop(context),
                child: Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: Styles.defaultPadding),
                    child: Column(
                      children: const [
                        Expanded(
                          child: UserInfo(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateScreenParams {
  final User user;

  const UpdateScreenParams({
    required this.user,
  });
}
