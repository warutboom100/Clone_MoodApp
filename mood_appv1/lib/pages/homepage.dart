import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/appbar.dart';
import '../components/drawerbar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../services/save_selectdate.dart';
import '../services/setup_notes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  String data = "";
  bool intl = false;

  Widget _eventIcon(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  static Widget _eventIcon2 = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 1.0)),
    child: new Icon(
      Icons.note,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      data = prefs.getString('mood_data') ?? '';

      intldata();
      for (var item in context.read<NotesProvider>().notes) {
        String dateString = item.time.substring(0, 10);
        _markedDateMap.add(
          DateTime(
              int.parse(dateString.substring(0, 4)),
              int.parse(dateString.substring(5, 7)),
              int.parse(dateString.substring(8, 10))),
          Event(
            date: DateTime(
                int.parse(dateString.substring(0, 4)),
                int.parse(dateString.substring(5, 7)),
                int.parse(dateString.substring(8, 10))),
            title: 'Event 1',
            icon: item.icon.length != 0
                ? _eventIcon(item.icon[0])
                : _eventIcon2, // ใช้ _eventIcon เพื่อรับรูปภาพและสร้างไอคอน
          ),
        );
      }
    });
  }

  void intldata() async {
    context.read<NotesProvider>().intlnotes(data);
    print(context.read<NotesProvider>().notes.length);
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: const Color.fromARGB(255, 0, 0, 0),
      todayTextStyle: TextStyle(
        fontFamily: 'Daisy',
        color: Colors.black87,
        fontSize: 22,
      ),
      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
        context.read<SelectTime>().Setup(date);
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: true,
      weekendTextStyle:
          TextStyle(fontFamily: 'Daisy', color: Colors.black87, fontSize: 22),
      weekdayTextStyle:
          TextStyle(fontFamily: 'Daisy', color: Colors.black26, fontSize: 22),
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      // targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,

      daysTextStyle:
          TextStyle(fontFamily: 'Daisy', color: Colors.black87, fontSize: 22),

      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      markedDateMoreShowTotal: true,
      todayButtonColor: Color.fromARGB(255, 255, 255, 255),
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),

      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      // onDayLongPressed: (DateTime date) {
      //   // context.read<SelectTime>().Setup(date);
      //   print(context.read<SelectTime>().select_time);
      // },
    );

    return new Scaffold(
      appBar: MyAppBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 30.0,
                bottom: 36.0,
                left: 16.0,
                right: 16.0,
              ),
              child: new Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    _currentMonth,
                    style: TextStyle(
                      fontSize: 32.0,
                    ),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: _calendarCarouselNoHeader,
            ), //
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SelectTime>().Setup(_currentDate2);
          final existingNoteIndex = context
              .read<NotesProvider>()
              .notes
              .indexWhere((note) =>
                  note.time.substring(0, 10) ==
                  '${context.read<SelectTime>().select_time}'.substring(0, 10));

          if (existingNoteIndex == -1) {
            context.read<Note_create>().reset_data();
          }
          if (existingNoteIndex != -1) {
            context.read<Note_create>().set_data(
                context.read<NotesProvider>().notes[existingNoteIndex].icon,
                context.read<NotesProvider>().notes[existingNoteIndex].note);
          }

          Navigator.pushNamedAndRemoveUntil(
            context,
            '/createmoodpage',
            (route) => false,
          );
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }
}
