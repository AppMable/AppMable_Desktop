import 'package:appmable_desktop/application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:appmable_desktop/ui/common/app_layout/app_layout.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/styles.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/category_box.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
import 'package:appmable_desktop/ui/screens/contacts/create_contact_screen/create_contact_screen.dart';
import 'package:appmable_desktop/ui/screens/contacts/update_contact_screen/update_contact_screen.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ContactsScreen extends StatelessWidget {
  static const String routeName = '/contacts-screen';

  ContactsScreen({Key? key}) : super(key: key);

  final ContactsScreenBloc _contactsScreenBloc = GetIt.instance.get<ContactsScreenBloc>();

  @override
  Widget build(BuildContext context) {

    final ContactsScreenParams args = ModalRoute.of(context)!.settings.arguments! as ContactsScreenParams;

    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          title: 'Contactos',
          content: Row(
            children: [
              Expanded(
                flex: 5,
                child: BlocBuilder<ContactsScreenBloc, ContactsScreenState>(
                  bloc: _contactsScreenBloc,
                  builder: (context, state) {
                    if (state is ContactsScreenLoaded) {
                      return CategoryBox(
                        title: '',
                        suffix: TextButton(
                          child: Text(
                            'Añadir contacto',
                            style: TextStyle(
                              color: Styles.defaultRedColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pushNamed(
                            CreateContactScreen.routeName,
                            arguments: CreateContactScreenParams(
                              userId: args.userId,
                            ),
                          ),
                        ),
                        children: [
                          const SizedBox(height: 25),
                          (state.contacts.isEmpty)
                              ? const Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Text('No se han encontrado contactos'),
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
                                                  'Dirección',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            DataColumn(label: SizedBox.shrink()),
                                          ],
                                          rows: state.contacts
                                              .map(
                                                ((Contact contact) => DataRow(
                                                      onSelectChanged: (_) {
                                                        Navigator.of(context).pushNamed(
                                                          UpdateContactScreen.routeName,
                                                          arguments: UpdateContactScreenParams(
                                                            contact: contact,
                                                            userId: args.userId,
                                                          ),
                                                        );
                                                      },
                                                      cells: <DataCell>[
                                                        DataCell(Text('${contact.name} ${contact.surname}')),
                                                        DataCell(Text(
                                                          contact.phoneNumber,
                                                        )),
                                                        DataCell(Text(
                                                          contact.email,
                                                        )),
                                                        DataCell(Text(
                                                          contact.address,
                                                        )),
                                                        DataCell(Center(
                                                          child: IconButton(
                                                            onPressed: () {
                                                              _contactsScreenBloc.add(
                                                                ContactsScreenDeleteEvent(
                                                                  contactId: contact.id,
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

                    _contactsScreenBloc.add(ContactsScreenEventLoad(userId: args.userId));

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

class ContactsScreenParams {
  final int userId;

  const ContactsScreenParams({
    required this.userId,
  });
}
