import 'package:appmable_desktop/application/bloc/users_screen/users_screen_bloc.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/userScreens';

  UsersScreen({Key? key}) : super(key: key);

  final UsersScreenBloc _usersScreenBloc = GetIt.instance.get<UsersScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersScreenBloc, UsersScreenState>(
          bloc: _usersScreenBloc,
          builder: (context, state) {
            if (state is UsersScreenLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(state.users[index].name),
                      const SizedBox(width: 50),
                      IconButton(
                        onPressed: () {
                          print('Tengo que eliminar el usuario: ${state.users[index].name}');
                        },
                        icon: const Icon(Icons.remove_circle_rounded),
                        color: Colors.red,
                      )
                    ],
                  );
                },
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
          }),
    );
  }
}
