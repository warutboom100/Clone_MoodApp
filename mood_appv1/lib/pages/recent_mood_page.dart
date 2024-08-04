import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/appbar.dart';
import '../services/setup_notes.dart';

class RecentMoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/homepage',
                (route) => false,
              );
            },
          ),
        ],
        title: Text('History your diary'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: context.read<NotesProvider>().notes.length,
                itemBuilder: (context, index) {
                  var item = context.read<NotesProvider>().notes[index];

                  return Container(
                    height: MediaQuery.of(context).size.width * 0.35,
                    child: Card(
                      color: Color.fromARGB(255, 255, 224, 248),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 8,
                      child: Column(
                        children: [
                          Container(
                            height: item.icon.length == 0 ? 10 : 60,
                            child: new ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: item.icon.length ?? 0,
                              itemBuilder: (context, index) {
                                var icon = item.icon[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(icon),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Center(
                            child: Text(
                              '${formate_time(item.time)}',
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.black45),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${item.note}',
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formate_time(String inputDate) {
  DateTime dateTime = DateTime.parse(inputDate);
  DateFormat formatter = DateFormat('EEEE, MMMM d, y');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}
