import 'package:appmable_desktop/application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart';
import 'package:appmable_desktop/application/bloc/users/users_screen/users_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
import 'package:appmable_desktop/ui/screens/contacts/contacts_screen/contacts_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ContactsUsersScreen extends StatelessWidget {
  static const String routeName = '/contacts-users-screen';

  ContactsUsersScreen({Key? key}) : super(key: key);

  final UsersScreenBloc _usersScreenBloc = GetIt.instance.get<UsersScreenBloc>();
  final ContactsScreenBloc _contactsScreenBloc = GetIt.instance.get<ContactsScreenBloc>();

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
                                          showCheckboxColumn: false,
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
                                          ],
                                          rows: state.users
                                              .map(
                                                ((User user) => DataRow(
                                                      onSelectChanged: (_) {
                                                        _contactsScreenBloc.add(const ContactsScreenEventReset());

                                                        Navigator.of(context).pushNamed(
                                                          ContactsScreen.routeName,
                                                          arguments: ContactsScreenParams(
                                                            userId: user.id,
                                                          ),
                                                        );
                                                      },
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
                                                                      color: Colors.black,
                                                                    ),
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
                                                        DataCell(Text(user.dateLastLogin == null
                                                            ? 'No se ha connectado aún'
                                                            : DateFormat('dd-MM-yyyy HH:mm')
                                                                .format(user.dateLastLogin!))),
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
