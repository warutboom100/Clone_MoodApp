import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.notes_outlined),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.bar_chart),
          onPressed: () {
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   '/quanlitymoodpage',
            //   (route) => false,
            // );
          },
        ),
        IconButton(
          icon: Icon(Icons.folder_open_outlined),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/recentmoodpage',
              (route) => false,
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
