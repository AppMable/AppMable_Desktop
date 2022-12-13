import 'package:appmable_desktop/application/bloc/alerts/alerts_screen/alerts_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
import 'package:appmable_desktop/ui/screens/alerts/create_alert_screen/create_alert_screen.dart';
import 'package:appmable_desktop/ui/screens/alerts/update_alert_screen/update_alert_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class AlertsScreen extends StatelessWidget {
  static const String routeName = '/alerts-screen';

  AlertsScreen({Key? key}) : super(key: key);

  final AlertsScreenBloc _alertsScreenBloc = GetIt.instance.get<AlertsScreenBloc>();

  @override
  Widget build(BuildContext context) {

    final AlertsScreenParams args = ModalRoute.of(context)!.settings.arguments! as AlertsScreenParams;

    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          title: 'Alertas',
          content: Row(
            children: [
              Expanded(
                flex: 5,
                child: BlocBuilder<AlertsScreenBloc, AlertsScreenState>(
                  bloc: _alertsScreenBloc,
                  builder: (context, state) {
                    if (state is AlertsScreenLoaded) {
                      return CategoryBox(
                        title: '',
                        suffix: TextButton(
                          child: Text(
                            'Añadir alerta',
                            style: TextStyle(
                              color: Styles.defaultRedColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pushNamed(
                            CreateAlertScreen.routeName,
                            arguments: CreateAlertScreenParams(
                              userId: args.userId,
                            ),
                          ),
                        ),
                        children: [
                          const SizedBox(height: 25),
                          (state.alerts.isEmpty)
                              ? const Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Text('No se han encontrado alertas'),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: DataTable(
                                          showCheckboxColumn: false,
                                          columnSpacing: 0,
                                          columns: const [
                                            DataColumn(
                                              label: Center(
                                                child: Text(
                                                  'Nombre',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                child: Text(
                                                  'Descripción',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                child: Text(
                                                  'Fecha activación',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                child: Text(
                                                  'Fecha desactivación',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(label: SizedBox.shrink()),
                                          ],
                                          rows: state.alerts
                                              .map(
                                                ((Alert alert) => DataRow(
                                                      onSelectChanged: (_) {
                                                        Navigator.of(context).pushNamed(
                                                          UpdateAlertScreen.routeName,
                                                          arguments: UpdateAlertScreenParams(
                                                            alert: alert,
                                                            userId: args.userId,
                                                          ),
                                                        );
                                                      },
                                                      cells: <DataCell>[
                                                        DataCell(Text(
                                                          alert.name,
                                                        )),
                                                        DataCell(Text(
                                                          alert.description ?? 'Sin descripción',
                                                        )),
                                                        DataCell(Text(alert.dateEnabled == null
                                                            ? 'No tiene fecha de activación'
                                                            : DateFormat('dd-MM-yyyy HH:mm')
                                                            .format(alert.dateEnabled!))),
                                                        DataCell(Text(alert.dateDisabled == null
                                                            ? 'No tiene fecha de desactivación'
                                                            : DateFormat('dd-MM-yyyy HH:mm')
                                                            .format(alert.dateDisabled!))),
                                                        DataCell(Center(
                                                          child: IconButton(
                                                            onPressed: () {
                                                              _alertsScreenBloc.add(
                                                                AlertsScreenDeleteEvent(
                                                                  alertId: alert.id,
                                                                  userId: alert.idUser,
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
                                                                    ScaffoldMessenger.of(context)
                                                                        .showSnackBar(const SnackBar(
                                                                      backgroundColor: Color(0xff5cb85c),
                                                                      content: Text(
                                                                        'Se ha eliminado correctamente',
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Colors.white,
                                                                        ),
                                                                      ),
                                                                    ));
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                            icon: const Icon(Icons.remove_circle_rounded),
                                                            color: Colors.red,
                                                          ),
                                                        )),
                                                      ],
                                                    )),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      );
                    }

                    _alertsScreenBloc.add(AlertsScreenEventLoad(userId: args.userId));

                    return Column(
                      children: [
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Cargando...',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(width: 20),
                            Center(child: CircularProgressIndicator(color: AppTheme.primary900)),
                            SizedBox(height: 50),
                          ],
                        ),
                      ],
                    );
                  },
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

class AlertsScreenParams {
  final int userId;

  const AlertsScreenParams({
    required this.userId,
  });
}
