import 'package:appmable_desktop/ui/common/app_layout/navigation_panel.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/app_layout/top_app_bar.dart';
import 'package:flutter/cupertino.dart';

class AppLayout extends StatelessWidget {
  final String title;
  final Widget content;

  const AppLayout({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: content,
            ),
          ),
          const NavigationPanel(
            axis: Axis.horizontal,
          ),
        ],
      ),
      desktop: Row(
        children: [
          const NavigationPanel(
            axis: Axis.vertical,
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 100,
                    child: TopAppBar(title: title),
                  ),
                  Expanded(child: content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
