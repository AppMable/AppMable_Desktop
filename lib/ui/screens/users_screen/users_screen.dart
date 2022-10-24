import 'package:appmable_desktop/application/bloc/users_screen/users_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/userScreens';

  UsersScreen({Key? key}) : super(key: key);

  final UsersScreenBloc _usersScreenBloc = GetIt.instance.get<UsersScreenBloc>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          title: 'Tutelados',
          content: Row(
            children: [
              Expanded(
                flex: 5,
                child: BlocBuilder<UsersScreenBloc, UsersScreenState>(
                  bloc: _usersScreenBloc,
                  builder: (context, state) {
                    if (state is UsersScreenLoaded) {
                      return CategoryBox(
                        title: '',
                        suffix: TextButton(
                          child: Text(
                            'Añadir tutelado',
                            style: TextStyle(
                              color: Styles.defaultRedColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            print('Add tutelado');
                          },
                        ),
                        children: [
                          const SizedBox(height: 25),
                          (state.users.isEmpty)
                              ? const Padding(
                                padding: EdgeInsets.all(25.0),
                                child: Text('No se han encontrado usuarios'),
                              )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: DataTable(
                                          columnSpacing: 0,
                                          columns: const [
                                            DataColumn(
                                              label: Center(
                                                child: Text(
                                                  'Nombre y apellidos',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                child: Text(
                                                  'Teléfono de contacto',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                child: Text(
                                                  'Email',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                child: Text(
                                                  'Última connexión',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(label: SizedBox.shrink()),
                                          ],
                                          rows: state.users
                                              .map(
                                                ((User user) => DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Row(
                                                          children: [
                                                            Stack(
                                                              alignment: Alignment.bottomRight,
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor: AppTheme.primary400,
                                                                  child: Text(
                                                                    user.name[0].toUpperCase(),
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.black),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                              child: Text('${user.name} ${user.surname}'),
                                                            ),
                                                          ],
                                                        )),
                                                        DataCell(Text(
                                                          user.phoneNumber,
                                                        )),
                                                        DataCell(Text(
                                                          user.email,
                                                        )),
                                                        DataCell(Text(
                                                          user.phoneNumber,
                                                        )),
                                                        DataCell(Center(
                                                          child: IconButton(
                                                            onPressed: () {
                                                              print('Tengo que eliminar el usuario: ${user.id}');
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
