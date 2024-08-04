import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/addmood_widget.dart';

import '../services/save_selectdate.dart';
import '../services/setup_notes.dart';

class CreateMoodPage extends StatelessWidget {
  TextEditingController textarea = TextEditingController();

// Initialize shared preferences

  @override
  Widget build(BuildContext context) {
    // List<Note>? notesList =
    //     context.read<NotesProvider>().notesResponse?.notesData;
    SharedPreferences prefs;
    List<Map<String, String>> newData = [
      {
        "time": "2024-05-20 00:00:00.000",
        "icon": "assets/icons/2.png",
        "note": "test2"
      },
    ];
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
        actions: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.trash),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(
                    'Do you really want to delete your diary',
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () async {
                        final existingNoteIndex = context
                            .read<NotesProvider>()
                            .notes
                            .indexWhere((note) =>
                                note.time.substring(0, 10) ==
                                '${context.read<SelectTime>().select_time}'
                                    .substring(0, 10));
                        context
                            .read<NotesProvider>()
                            .deleteNote(existingNoteIndex);
                        prefs = await SharedPreferences.getInstance();
                        var notesList = context.read<NotesProvider>().notes;
                        var jsonList = notesList
                            .map((note) => {
                                  'time': note.time,
                                  'icon': note.icon,
                                  'note': note.note,
                                })
                            .toList();
                        var jsonString = json.encode(jsonList);
                        prefs.setString('mood_data', jsonString);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/homepage',
                          (route) => false,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // context.read<NotesProvider>().fetchNotesData(newData);
                showModalBottomSheet(
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  isScrollControlled: true,
                  isDismissible: true,
                  context: context,
                  builder: (context) {
                    return Icons_ModalSheet();
                  },
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 26,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Center(
            child: Consumer<Note_create>(
              builder: (context, notesProvider, _) {
                return Container(
                  height:
                      context.read<Note_create>().myIcon.length == 0 ? 10 : 60,
                  child: new ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: notesProvider.myIcon.length ?? 0,
                    itemBuilder: (context, index) {
                      var item = notesProvider.myIcon[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(item),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Center(
            child: Text(
              '${formate_time(context.read<SelectTime>().select_time)}',
              style: new TextStyle(fontSize: 18.0, color: Colors.black45),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: TextField(
                controller: textarea,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                maxLines: 16,
                decoration: InputDecoration(
                  hintText: context.read<Note_create>().noteTitle != ""
                      ? context.read<Note_create>().noteTitle
                      : "Enter Remarks",
                  hintStyle: context.read<Note_create>().noteTitle != ""
                      ? TextStyle(fontSize: 20.0, color: Colors.black)
                      : TextStyle(fontSize: 20.0, color: Colors.black26),
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (context.read<Note_create>().myIcon.length != 0 ||
              textarea.text != "") {
            context.read<NotesProvider>().addOrUpdateIcons(
                  "${context.read<SelectTime>().select_time}",
                  context.read<Note_create>().myIcon,
                  textarea.text,
                );
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text('Save diary Completed'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      prefs = await SharedPreferences.getInstance();
                      var notesList = context.read<NotesProvider>().notes;
                      var jsonList = notesList
                          .map((note) => {
                                'time': note.time,
                                'icon': note.icon,
                                'note': note.note,
                              })
                          .toList();
                      var jsonString = json.encode(jsonList);
                      prefs.setString('mood_data', jsonString);
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        label: Text('SAVE'),
        icon: Icon(Icons.check),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}

String formate_time(DateTime inputDate) {
  DateFormat formatter = DateFormat('EEEE, MMMM d, y');
  String formattedDate = formatter.format(inputDate);
  return formattedDate;
}
