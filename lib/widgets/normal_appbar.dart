import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const CustomAppbar({
    Key? key,
    required this.title,
    this.height = kToolbarHeight, // Default AppBar height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.headlineMedium,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
