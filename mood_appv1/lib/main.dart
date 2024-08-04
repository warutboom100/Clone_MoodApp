import 'package:flutter/material.dart';
import 'package:mood_appv1/pages/quanlity_mood_page.dart';
import 'package:provider/provider.dart';
import 'pages/create_mood.dart';
import 'pages/homepage.dart';
import 'pages/recent_mood_page.dart';
import 'services/save_selectdate.dart';
import 'services/setup_notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectTime()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => Note_create()),
      ],
      child: MaterialApp(
        initialRoute: '/homepage',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            fontFamily: 'Daisy'),
        routes: {
          '/homepage': (context) => MyHomePage(),
          '/recentmoodpage': (context) => RecentMoodPage(),
          '/quanlitymoodpage': (context) => QuanlityMoodPage(),
          '/createmoodpage': (context) => CreateMoodPage()
        },
      ),
    ),
  );
}
