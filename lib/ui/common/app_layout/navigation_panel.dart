import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/widgets/navigation_button.dart';
import 'package:flutter/material.dart';

class NavigationPanel extends StatefulWidget {
  final Axis axis;
  const NavigationPanel({Key? key, required this.axis}) : super(key: key);

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
          : const EdgeInsets.all(10),
      child: widget.axis == Axis.vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/images/splashBranding.png", height: 50),
                Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  NavigationButton(
                    onPressed: () {},
                    icon: Icons.supervised_user_circle_outlined,
                  ),
                  NavigationButton(
                    onPressed: () {},
                    icon: Icons.medical_information_outlined,
                  ),
                  NavigationButton(
                    onPressed: () {},
                    icon: Icons.add_alert_outlined,
                  ),
                  NavigationButton(
                    onPressed: () {},
                    icon: Icons.calendar_month_outlined,
                  ),
                ]),
                Container()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/logo.png", height: 20),
                Row(
                  children: [
                    NavigationButton(
                      onPressed: () {},
                      icon: Icons.supervised_user_circle_outlined,
                    ),
                    NavigationButton(
                      onPressed: () {},
                      icon: Icons.medical_information_outlined,
                    ),
                    NavigationButton(
                      onPressed: () {},
                      icon: Icons.add_alert_outlined,
                    ),
                    NavigationButton(
                      onPressed: () {},
                      icon: Icons.calendar_month_outlined,
                    ),
                  ],
                ),
                Container()
              ],
            ),
    );
  }
}
