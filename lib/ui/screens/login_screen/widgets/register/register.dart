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

  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _userMap = {};

  Future<void> _updateUser({
    required String key,
    required String value,
  }) async =>
      setState(() => _userMap[key] = value.isNotEmpty ? value : null);

  final CreateUserScreenBloc _createUserScreenBloc = GetIt.instance.get<CreateUserScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                    'Ya tienes cuenta? Pulsa al botón de debajo',
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
                    onPressed: () => widget.loginScreenBloc.add(const LoadLogInScreenEvent()),
                    child: const Text('LOGIN',
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
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                                callback: (value) => _updateUser(
                                  key: 'identity_number',
                                  value: value.trim(),
                                ),
                              ),
                              const SizedBox(width: 20),
                              TextInput(
                                placeholder: 'e. g TASA1030101002',
                                label: 'Tarjeta Sanitaria',
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
                                callback: (value) => _updateUser(
                                  key: 'username',
                                  value: value.trim(),
                                ),
                              ),
                              const SizedBox(width: 20),
                              TextInput(
                                label: 'Contraseña',
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
                                callback: (value) => _updateUser(
                                  key: 'name',
                                  value: value.trim(),
                                ),
                              ),
                              const SizedBox(width: 20),
                              TextInput(
                                placeholder: 'e. g Doe',
                                label: 'Apellidos',
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
                                callback: (value) => _updateUser(
                                  key: 'email',
                                  value: value.trim(),
                                ),
                              ),
                              const SizedBox(width: 20),
                              TextInput(
                                label: 'Teléfono',
                                callback: (value) => _updateUser(
                                  key: 'phone_number',
                                  value: value.trim(),
                                ),
                              ),
                              const SizedBox(width: 20),
                              TextInput(
                                placeholder: 'Ej: 31-12-1995',
                                label: 'Fecha de nacimiento',
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
                                _createUserScreenBloc.add(CreateUserEvent(
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

                                    widget.loginScreenBloc.add(const LoadLogInScreenEvent());

                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: Color(0xff5cb85c),
                                      content: Text(
                                        'Se ha registrado correctamente',
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
                                'Registrarse',
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
