import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/ui/common/app_layout/responsive.dart';
import 'package:appmable_desktop/ui/common/mixin/user_mixin.dart';
import 'package:appmable_desktop/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget with UserMixin {
  final String title;

  TopAppBar({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = getUser();

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Visibility(
            visible: Responsive.isDesktop(context),
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          Expanded(
            child: _nameAndProfilePicture(
              context,
              '${user.name} ${user.surname}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameAndProfilePicture(BuildContext context, String username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 6),
        Visibility(
          visible: !Responsive.isMobile(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundColor: AppTheme.primary400,
              child: Text(
                username[0].toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
