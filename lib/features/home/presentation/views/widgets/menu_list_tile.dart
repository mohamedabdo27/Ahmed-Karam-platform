import 'package:flutter/material.dart';

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.titleAlignment,
  });
  final IconData icon;
  final String title;
  final void Function()? onTap;
  final ListTileTitleAlignment? titleAlignment;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      titleAlignment: titleAlignment,
      title: Text(title),
      titleTextStyle: TextStyle(fontSize: 18),

      leading: Icon(icon, size: 30),
    );
  }
}
