import 'package:appmable_desktop/application/bloc/alerts/create_alert_screen/create_alert_screen_bloc.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/forms/text_input.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateAlertScreen extends StatefulWidget {
  static const String routeName = '/create-alert-screen';

  const CreateAlertScreen({Key? key}) : super(key: key);

  @override
  State<CreateAlertScreen> createState() => _CreateAlertScreenState();
}

class _CreateAlertScreenState extends State<CreateAlertScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _alertMap = {};

  Future<void> _updateAlert({
    required String key,
    required String value,
  }) async =>
      setState(() => _alertMap[key] = value.isNotEmpty ? value : null);

  final CreateAlertScreenBloc _createAlertScreenBloc = GetIt.instance.get<CreateAlertScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          title: 'Crear Alerto',
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
                                    placeholder: 'e. g Jon',
                                    label: 'Nombre',
                                    callback: (value) => _updateAlert(
                                      key: 'name',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    placeholder: 'e. g Doe',
                                    label: 'Apellidos',
                                    callback: (value) => _updateAlert(
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
                                    callback: (value) => _updateAlert(
                                      key: 'email',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    label: 'Teléfono',
                                    callback: (value) => _updateAlert(
                                      key: 'phone_number',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    label: 'Dirección',
                                    callback: (value) => _updateAlert(
                                      key: 'address',
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
                                    _createAlertScreenBloc.add(CreateAlertEvent(
                                      alert: _alertMap,
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
                                            'Se ha creado correctamente',
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
                                    'Crear tutelado',
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

class CreateAlertScreenParams {
  final int userId;

  const CreateAlertScreenParams({
    required this.userId,
  });
}

