import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
        style: TextStyle(color: Colors.black),
      ),
      automaticallyImplyLeading: false,
      shape: Border(bottom: BorderSide(color: Colors.black12)),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
