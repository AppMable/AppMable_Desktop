part of '../main_screen.dart';

class NavDrawer extends StatelessWidget {

  final MainScreenBloc _mainScreenBloc = GetIt.instance.get<MainScreenBloc>();

  NavDrawer({Key? key}) : super(key: key);

  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: AppTheme.primaryButton,
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'All',
                    iconText: '👥',
                    onClicked: () => _mainScreenBloc.add(const MainScreenEventLoad()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required String iconText,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Text(iconText, style: const TextStyle(color: color, fontSize: 25)),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}