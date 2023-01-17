import 'dart:io';
import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/Model/calendar.dart';
import 'package:emotionscalendar/db/datedao.dart';
import 'package:emotionscalendar/Model/dayyearcalculator.dart';
import 'package:emotionscalendar/Model/emotion.dart';
import 'package:emotionscalendar/View/calendarview.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //STATUSBAR COLOR:
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:
        Color.fromARGB(255, 49, 44, 70), // navigation bar color
    statusBarColor: Color.fromARGB(255, 49, 44, 70), // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  //STORAGE DIRECTORY:
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  //INIT HIVE:
  await Hive.initFlutter(appDocPath);
  Hive.registerAdapter(DateDaoAdapter());
  Box box = await Hive.openBox('Dates');
  //GET CURRENT DAY:
  DateTime now = DateTime.now();
  int yearDay = DayYearCalculator(now).toYearDay();
  //SET APP STATE:
  if (box.length == 0) {
    //FIRST TIME OPENING THE APP
    box.put(yearDay,
        DateDao(yearDay, now.month, now.year, Emotion.unassigned.getName()));
  } else {
    //THE APP HAS STORED DATA
    List contains = box.values
        .where((element) =>
            element.getDay() == now.day &&
            element.getMonth() == now.month &&
            element.getYear() == now.year)
        .toList();
    if (contains.isEmpty) {
      //CURRENT DATE IS NOT STORED
      box.put(yearDay,
          DateDao(yearDay, now.month, now.year, Emotion.unassigned.getName()));
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        //START CALENDAR PROVIDER
        providers: [
          ChangeNotifierProvider(
              create: (context) => Calendar(
                  Hive.box("Dates").getAt(Hive.box("Dates").length - 1))),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mood.',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home(),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 49, 44, 70),
          title: const Text("CALENDAR"),
          actions: [
            IconButton(
                onPressed: () {
                  CalendarController().changeEmotion(Emotion.happy, context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: const CalendarView(
            myBackgroundColor, myDotsColor, myMonthColor, 200));
  }
}
