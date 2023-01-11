import 'package:emotionscalendar/Model/calendar.dart';
import 'package:emotionscalendar/Model/month.dart';

import 'package:emotionscalendar/View/calendarview.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:
        Color.fromARGB(255, 49, 44, 70), // navigation bar color
    statusBarColor: Color.fromARGB(255, 49, 44, 70), // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => Calendar(DateTime.now(), DateTime.now(),
                  DateTime.now().subtract(const Duration(days: 400)))),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mood.',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: Home(),
        ));
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromARGB(255, 25, 22, 37),
            child: Column(
              children: const [
                CalendarView(myBackgroundColor, myDotsColor, myMonthColor, 200),
              ],
            )),
      ),
    );
  }
}
