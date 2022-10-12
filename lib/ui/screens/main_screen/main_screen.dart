import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:appmable_desktop/application/bloc/main_screen/main_screen_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appmable_desktop/domain/model/objects/button.dart';
import 'package:appmable_desktop/ui/common/widgets/footer.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';

part 'widgets/buttons_list.dart';
part 'widgets/header.dart';
part 'widgets/navigation.dart';
part 'widgets/nav_drawer.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';

  final MainScreenBloc _mainScreenBloc = GetIt.instance.get<MainScreenBloc>();

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: NavDrawer(),
      body: Builder(builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value:
              SystemUiOverlayStyle.light.copyWith(statusBarColor: (Platform.isAndroid) ? Colors.black : Colors.white),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                BlocBuilder<MainScreenBloc, MainScreenState>(
                    bloc: _mainScreenBloc,
                    builder: (context, state) {
                      if (state is MainScreenLoaded) {
                        return Text(state.message);
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
                const Footer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
