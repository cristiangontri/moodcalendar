import 'dart:io';
import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/Model/calendar.dart';
import 'package:emotionscalendar/Model/notification_service.dart';

import 'package:emotionscalendar/Model/settingsmodel.dart';
import 'package:emotionscalendar/View/infoview.dart';
import 'package:emotionscalendar/View/mainpage.dart';
import 'package:emotionscalendar/View/signin.dart';
import 'package:emotionscalendar/db/datedao.dart';
import 'package:emotionscalendar/Model/dayyearcalculator.dart';
import 'package:emotionscalendar/Model/emotion.dart';
import 'package:emotionscalendar/View/calendarview.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;

Future<void> main() async {
  //STATUSBAR COLOR:
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: myBackgroundColor, // navigation bar color
    statusBarColor: myBackgroundColor, // status bar color
  ));

  //STORAGE DIRECTORY:
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  //INIT HIVE:
  await Hive.initFlutter(appDocPath);
  Hive.registerAdapter(DateDaoAdapter());
  DateTime now = DateTime.now();
  String year = now.year.toString();
  Box box = await Hive.openBox(year);
  await Hive.openBox('User');
  //GET CURRENT DAY:

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

    //Notification default time
  }

  //Language:

  Box userBox = Hive.box("User");
  if (!userBox.containsKey(1)) {
    await userBox.put(1, "20:00");

    String time = userBox.get(1);
    int hour = int.parse(time.split(":")[0]);

    int minute = int.parse(time.split(":")[1]);
    DateTime myTime = DateTime(now.year, now.month, now.day, hour, minute, 0);
    NotificationService().showNotification(
        title: systemLocales.first.toString() == "es_ES"
            ? "Buenas!"
            : "Hey there!",
        body: systemLocales.first.toString() == "es_ES"
            ? "¿Que tal te ha ido hoy?"
            : "How was your day?",
        mytime: myTime);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String year = DateTime.now().year.toString();
    int yearDay = DayYearCalculator(DateTime.now()).toYearDay();
    DateDao currentDate = Hive.box(year).get(yearDay);
    Box userBox = Hive.box("User");
    return MultiProvider(
        //START CALENDAR PROVIDER
        providers: [
          ChangeNotifierProvider(
              create: (context) => Calendar(currentDate, currentDate)),
          ChangeNotifierProvider(create: (context) => SettingsModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mood.',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: userBox.containsKey(0) ? const MainPage() : const SignIn(),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CalendarView myCalendar =
      CalendarView(myBackgroundColor, myDotsColor, myMonthColor, 200);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    var controller = CalendarController();
    String username = SettingsController().getUserName(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: myBackgroundColor,
        body: SafeArea(
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Container(
                    height:
                        maxheight <= 600 ? maxheight * 0.24 : maxheight * 0.16,
                    width: maxwidth * 0.95,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 245, 234),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(80, 0, 0, 0),
                            blurRadius: 2.0,
                          ),
                        ]),
                    child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Center(
                                      child: Text(username,
                                          style: GoogleFonts.aboreto(
                                            textStyle: const TextStyle(
                                                color: Colors.teal,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 3),
                                          )),
                                    ),
                                  ),
                                  const Spacer(),

                                  //ALLOW THE USER TO CHECK THE COLOR OF EACH EMOTION.
                                  Center(
                                      child: /*Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    myContainer(happyColor, "😊"),
                                    myContainer(calmColor, "😴"),
                                    myContainer(cryingColor, "😭"),
                                    myContainer(angryColor, "😡"),
                                    myContainer(badColor, "😞"),
                                    myContainer(lovedColor, "🥰"),
                                    myContainer(sickColor, "🤒"),
                                    myContainer(unasignedColor, "😐")
                                  ],
                                ),*/
                                          Text(
                                    "---${controller.getRenderedYear(context)}---",
                                    style: GoogleFonts.aboreto(
                                      textStyle: const TextStyle(
                                        color: badColor,
                                        fontSize: 30,
                                        letterSpacing: 3,
                                      ),
                                    ),
                                  )),
                                  const Spacer(),
                                ],
                              ),
                              //THE FOLLOWING ICONBUTTON NAVIGATES TO THE CURRENT DATE IN THE LISTVIEW
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InfoView()),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.settings,
                                      color: myBackgroundColor,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        int index =
                                            (DateTime.now().month - 1) * 2;

                                        myCalendar.itemScrollController
                                            .scrollTo(
                                                index: index,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.easeInOutCubic);
                                      },
                                      icon: const Icon(
                                        Icons.replay_rounded,
                                        color: myBackgroundColor,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.previousRenderedYear(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_left_rounded,
                                  color: myBackgroundColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.nextRenderedYear(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_right_rounded,
                                  color: myBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                maxheight <= 600 ? const Spacer() : const SizedBox.shrink(),
                myCalendar,
                maxheight <= 600
                    ? const SizedBox.shrink()
                    : Center(
                        child: SizedBox(
                            height: maxheight * 0.25,
                            child: Image.asset("assets/MoodBG2.png")),
                      ),
              ],
            ),
          ]),
        ));
  }

  Widget myContainer(Color bg, String emoji) {
    //CUSTOM APPBAR / BANNER:
    return Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: bg,
            borderRadius: BorderRadius.circular(10)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          )
        ]));
  }
}
