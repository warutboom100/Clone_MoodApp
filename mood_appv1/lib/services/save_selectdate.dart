import 'package:flutter/foundation.dart';

class SelectTime with ChangeNotifier {
  DateTime select_time = DateTime.now();

  void Setup(DateTime date) {
    select_time = date;
    notifyListeners();
  }
}

class Note_create with ChangeNotifier {
  List<String> myIcon = [];
  String noteTitle = "";

  void addIcon(String img) {
    myIcon.add(img);
    notifyListeners();
  }

  void addNote(String title) {
    noteTitle = title;
    notifyListeners();
  }

  void set_data(List<String> data, String title) {
    myIcon = data;
    noteTitle = title;
    notifyListeners();
  }

  void reset_data() {
    myIcon = [];
    noteTitle = "";
    notifyListeners();
  }
}
