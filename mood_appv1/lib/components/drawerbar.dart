import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.only(top: 20),
            children: <Widget>[
              ListTile(
                  leading: Icon(CupertinoIcons.chevron_left),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              buildListTile(Icons.storefront, 'Moodie Store'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 1, thickness: 1),
              ),
              buildListTile(
                  Icons.notifications_none_outlined, 'Diary notifications'),
              buildListTile(Icons.color_lens_outlined, 'Theme settings'),
              buildListTile(Icons.format_color_text, 'Font Styles'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 1, thickness: 1),
              ),
              buildListTile(Icons.lock_outline, 'Screen lock'),
              buildListTile(Icons.cloud_outlined, 'iCloud sync'),
              buildListTile(CupertinoIcons.tray, 'Backup/Restore'),
              buildListTile(Icons.language, 'Language'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 1, thickness: 1),
              ),
              buildListTile(Icons.sentiment_satisfied_outlined, 'Rate an app'),
            ],
          )),
    );
  }
}

Widget buildListTile(IconData leadingIcon, String title) {
  return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Daisy',
          fontSize: 24,
        ),
      ),
      onTap: () {});
}
