import 'package:appmable_desktop/application/bloc/contacts/update_contact_screen/update_contact_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/forms/text_input.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UpdateContactScreen extends StatefulWidget {
  static const String routeName = '/update-contact-screen';

  const UpdateContactScreen({Key? key}) : super(key: key);

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  final _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> _contactMap;

  Future<void> _updateContact({
    required String key,
    required String value,
  }) async =>
      setState(() => _contactMap[key] = value.isNotEmpty ? value : null);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final UpdateContactScreenParams args = ModalRoute.of(context)!.settings.arguments! as UpdateContactScreenParams;
      _contactMap = args.contact.toMap();
    });

    super.initState();
  }

  final UpdateContactScreenBloc _updateContactScreenBloc = GetIt.instance.get<UpdateContactScreenBloc>();

  @override
  Widget build(BuildContext context) {
    final UpdateContactScreenParams args = ModalRoute.of(context)!.settings.arguments! as UpdateContactScreenParams;

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
                                    placeholder: 'e. g Jon',
                                    label: 'Nombre',
                                    value: args.contact.name,
                                    callback: (value) => _updateContact(
                                      key: 'name',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    placeholder: 'e. g Doe',
                                    label: 'Apellidos',
                                    value: args.contact.surname,
                                    callback: (value) => _updateContact(
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
                                    value: args.contact.email,
                                    callback: (value) => _updateContact(
                                      key: 'email',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    label: 'Teléfono',
                                    value: args.contact.phoneNumber,
                                    callback: (value) => _updateContact(
                                      key: 'phone_number',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    label: 'Dirección',
                                    value: args.contact.address,
                                    callback: (value) => _updateContact(
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
                                    _updateContactScreenBloc.add(UpdateContactEvent(
                                      contact: _contactMap,
                                      userId: args.userId,
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

class UpdateContactScreenParams {
  final Contact contact;
  final int userId;

  const UpdateContactScreenParams({
    required this.contact,
    required this.userId,
  });
}
