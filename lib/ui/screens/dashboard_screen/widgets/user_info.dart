part of '../dashboard_screen.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with UserMixin {
  bool showIncorrectLogOutError = false;
  String logOutErrorMessage = '';

  final DashboardScreenBloc _dashboardScreenBloc = GetIt.instance.get<DashboardScreenBloc>();
  final LoginScreenBloc _loginScreenBloc = GetIt.instance.get<LoginScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardScreenBloc, DashboardScreenState>(
      bloc: _dashboardScreenBloc,
      builder: (context, state) {
        if (state is DashboardScreenLoaded) {
          return CategoryBox(
            suffix: Container(),
            title: "Información del usuario",
            children: [
              Expanded(
                child: _userInfo(),
              ),
            ],
          );
        }

        return Column(
          children: const [
            SizedBox(height: 100),
            CircularProgressIndicator(
              color: AppTheme.primary600,
            )
          ],
        );
      },
    );
  }

  Widget _userInfo() {

    final User user = getUser();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Styles.defaultLightWhiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Nombre usuario:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(user.username),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('Nombre y Apellidos:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text('${user.name} ${user.surname}'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(user.email),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('Teléfono de contacto:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(user.phoneNumber),
            ],
          ),
          const SizedBox(height: 50),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primary900),
              overlayColor: MaterialStateProperty.all<Color>(AppTheme.primary200),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {
              _loginScreenBloc.add(LogOutEvent(
                onLogOutSuccess: () {
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                },
                onLogOutError: (String error) {
                  setState(() {
                    showIncorrectLogOutError = true;
                    logOutErrorMessage = error;
                  });
                },
              ));
            },
            child: const Text(
              'Cerrar Sessión',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          showIncorrectLogOutError
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      logOutErrorMessage,
                      style: const TextStyle(color: AppTheme.error600),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
