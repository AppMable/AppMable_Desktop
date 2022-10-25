part of '../dashboard_screen.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;

  const DashboardButton({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: Styles.defaultBorderRadius,
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(Styles.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Icon(icon, size: 50),
        ],
      ),
    );
  }
}
