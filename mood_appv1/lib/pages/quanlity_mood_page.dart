import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuanlityMoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_left),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/homepage',
              (route) => false,
            );
          },
        ),
        title: Text('Overall u Moods'),
      ),
      body: Center(
        child: Text(
          'Overall u Moods',
          textDirection: TextDirection.ltr,
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
        ),
      ),
    );
  }
}
