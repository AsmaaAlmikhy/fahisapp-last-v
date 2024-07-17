import 'package:flutter/material.dart';

class DropDownMenuFb1 extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Color color;
  final Widget icon;
  const DropDownMenuFb1({
    required this.menuList,
    this.color = Colors.white,
    this.icon = const Icon(
      Icons.more_vert,
      size: 30,
      color: Colors.black,
    ),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => menuList,
    );
  }
}
