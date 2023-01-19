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
    systemNavigationBarColor: myBackgroundColor, // navigation bar color
    statusBarColor: myBackgroundColor, // status bar color
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
        DateDao(now.day, now.month, now.year, Emotion.unassigned.getName()));
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
          DateDao(now.day, now.month, now.year, Emotion.unassigned.getName()));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateDao currentDate = Hive.box("Dates").getAt(Hive.box("Dates").length - 1);
    return MultiProvider(
        //START CALENDAR PROVIDER
        providers: [
          ChangeNotifierProvider(
              create: (context) => Calendar(currentDate, currentDate)),
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
    CalendarController controller = CalendarController();
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    Emotion value = EmotionExtension.parse(
        controller.getSelectedDate(context).getEmotion());
    return Scaffold(
        backgroundColor: myBackgroundColor,
        body: Column(
          children: [
            const Spacer(),
            Container(
              height: maxheight * 0.45,
              width: maxwidth * 0.95,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 229, 245, 234),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(80, 0, 0, 0),
                      blurRadius: 2.0,
                    ),
                  ]),
              child: Image.asset("assets/reading-side.png"),
            ),
            const CalendarView(
                myBackgroundColor, myDotsColor, myMonthColor, 200)
          ],
        ));
  }
}
