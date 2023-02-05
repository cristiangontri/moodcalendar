import 'package:emotionscalendar/View/colors.dart';
import 'package:emotionscalendar/View/statsview.dart';
import 'package:emotionscalendar/main.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  //USED FOR THE PAGINATION BETWEEN HOME AND STATS:
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var pages = [Home(), StatsView()];

  @override
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: myBackgroundColor,
      body: SafeArea(
          child: SizedBox(
        width: maxwidth,
        height: maxheight,
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[index];
            }),
      )),
    );
  }
}
