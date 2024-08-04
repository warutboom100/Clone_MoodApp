import 'package:flutter/material.dart';
import 'dart:convert';

import '../schemas/usernotes_data.dart'; // Import this for decoding JSON

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void intlnotes(String data) {
    if (data.isNotEmpty) {
      List<dynamic> jsonData = json.decode(data);

      _notes = jsonData.map((json) {
        final time = json['time'] as String;
        final icon = (json['icon'] as List).cast<String>();
        final note = json['note'] as String;
        return Note(
          time: time,
          icon: icon,
          note: note,
        );
      }).toList();
    }

    Future.microtask(() {
      notifyListeners();
    });
  }

  void addOrUpdateNote(String datetime, String note) {
    final existingNoteIndex = _notes.indexWhere(
        (note) => note.time.substring(0, 10) == datetime.substring(0, 10));

    if (existingNoteIndex != -1) {
      _notes[existingNoteIndex] = Note(
        time: datetime,
        icon: _notes[existingNoteIndex].icon,
        note: note,
      );
    } else {
      _notes.add(
        Note(
          time: datetime,
          icon: [],
          note: note,
        ),
      );
    }

    notifyListeners();
  }

  void deleteNote(int index) {
    if (index != -1) {
      print(_notes[index].note);
      _notes.removeAt(index);
    }

    notifyListeners();
  }

  void addOrUpdateIcons(String datetime, List<String> icons, String note) {
    final existingNoteIndex = _notes.indexWhere(
        (note) => note.time.substring(0, 10) == datetime.substring(0, 10));

    if (existingNoteIndex != -1) {
      _notes[existingNoteIndex] = Note(
        time: datetime,
        icon: icons,
        note: note,
      );
    } else {
      _notes.add(
        Note(
          time: datetime,
          icon: icons,
          note: note,
        ),
      );
    }

    notifyListeners();
  }
}
