import 'package:appmable_desktop/application/bloc/alerts/create_alert_screen/create_alert_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/forms/datetime_picker_input.dart';
import 'package:appmable_desktop/ui/common/forms/text_input.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
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

  final Map<String, dynamic> _alertMap = {
    'sound_level': Alert.defaultLevel,
    'vibration_level': Alert.defaultLevel,
  };

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final CreateAlertScreenParams args = ModalRoute.of(context)!.settings.arguments! as CreateAlertScreenParams;
      _alertMap['id_user'] = args.userId;
    });

    super.initState();
  }

  Future<void> _updateAlert({
    required String key,
    required String value,
  }) async =>
      setState(() => _alertMap[key] = value.isNotEmpty ? value : null);

  Future<void> _updateDate({
    required String key,
    required DateTime value,
  }) async =>
      setState(() => _alertMap[key] = value);

  final CreateAlertScreenBloc _createAlertScreenBloc = GetIt.instance.get<CreateAlertScreenBloc>();

  @override
  Widget build(BuildContext context) {

    final CreateAlertScreenParams args = ModalRoute.of(context)!.settings.arguments! as CreateAlertScreenParams;

    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          title: 'Crear Alerta',
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
                                    label: 'Nombre',
                                    callback: (value) => _updateAlert(
                                      key: 'name',
                                      value: value.trim(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    label: 'Descripción',
                                    callback: (value) => _updateAlert(
                                      key: 'description',
                                      value: value.trim(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Volumen: ${_alertMap['sound_level'].round().toString()}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            color: AppTheme.neutral800,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            trackHeight: 2,
                                            minThumbSeparation: 20,
                                            thumbColor: AppTheme.primary900,
                                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                            overlayColor: AppTheme.primary200,
                                            inactiveTickMarkColor: Colors.amber,
                                            inactiveTrackColor: AppTheme.neutral400,
                                            activeTickMarkColor: Colors.red,
                                            activeTrackColor: AppTheme.success600,
                                          ),
                                          child: Slider(
                                            value: _alertMap['sound_level'].toDouble(),
                                            min: Alert.minLevel.toDouble(),
                                            max: Alert.maxLevel.toDouble(),
                                            label: _alertMap['sound_level'].round().toString(),
                                            divisions: Alert.maxLevel,
                                            onChanged: (double value) {
                                              setState(() {
                                                _alertMap['sound_level'] = value.toInt();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Vibración: ${_alertMap['vibration_level'].round().toString()}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            color: AppTheme.neutral800,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            trackHeight: 2,
                                            minThumbSeparation: 20,
                                            thumbColor: AppTheme.primary900,
                                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                            overlayColor: AppTheme.primary200,
                                            inactiveTickMarkColor: Colors.amber,
                                            inactiveTrackColor: AppTheme.neutral400,
                                            activeTickMarkColor: Colors.red,
                                            activeTrackColor: AppTheme.success600,
                                          ),
                                          child: Slider(
                                            value: _alertMap['vibration_level'].toDouble(),
                                            min: Alert.minLevel.toDouble(),
                                            max: Alert.maxLevel.toDouble(),
                                            label: _alertMap['vibration_level'].round().toString(),
                                            divisions: Alert.maxLevel,
                                            onChanged: (double value) {
                                              setState(() {
                                                _alertMap['vibration_level'] = value.toInt();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Row(
                                children: [
                                  DateTimePickerInput(
                                    value: _alertMap['date_enabled'],
                                    label: 'Fecha Activación',
                                    callback: (value) {
                                      _updateDate(
                                        key: 'date_enabled',
                                        value: value,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  DateTimePickerInput(
                                    value: _alertMap['date_disabled'],
                                    label: 'Fecha Desactivación',
                                    callback: (value) {
                                      _updateDate(
                                        key: 'date_disabled',
                                        value: value,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  TextInput(
                                    label: 'Periocidad en Milisegundos',
                                    callback: (value) => _updateAlert(
                                      key: 'time_length',
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
                                    'Crear alerta',
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
