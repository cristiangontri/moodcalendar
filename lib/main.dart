import 'dart:io';
import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/Model/calendar.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //STATUSBAR COLOR:
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: myBackgroundColor, // navigation bar color
    statusBarColor: myBackgroundColor, // status bar color
  ));

  //STORAGE DIRECTORY:
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  //INIT HIVE:
  await Hive.initFlutter(appDocPath);
  Hive.registerAdapter(DateDaoAdapter());
  Box box = await Hive.openBox('Dates');
  Box userBox = await Hive.openBox('User');
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
    Box userBox = Hive.box("User");
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
            primarySwatch: Colors.teal,
          ),
          home: userBox.length == 0 ? SignIn() : MainPage(),
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
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    String username = Hive.box("User").getAt(Hive.box("User").length - 1);
    return Scaffold(
        backgroundColor: myBackgroundColor,
        body: SafeArea(
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Container(
                    height: maxheight * 0.16,
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
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        //THE FOLLOWING ICONBUTTON NAVIGATES TO THE CURRENT DATE IN THE LISTVIEW
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const InfoView()),
                                );
                              },
                              icon: const Icon(
                                Icons.info_outline_rounded,
                                color: myBackgroundColor,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  int index = (DateTime.now().month - 1) * 2;

                                  myCalendar.itemScrollController.scrollTo(
                                      index: index,
                                      duration: const Duration(seconds: 1),
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
                  ),
                ),
                const Spacer(),
                myCalendar,
                Center(
                  child: SizedBox(
                      height: maxheight * 0.40,
                      child: Image.asset("assets/MoodBG2.png")),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_downward_rounded,
              color: containerColor,
              size: 25,
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
