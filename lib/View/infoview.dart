import 'dart:async';

import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../main.dart';

const String testID = 'cristian';

class InfoView extends StatefulWidget {
  final TextEditingController myEditingController = TextEditingController();
  InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  final _iap = IAPConnection.instance;
  final List<PurchaseDetails> _purchases = [];
  List<ProductDetails> _products = [];
  StreamSubscription? _subscription;

  // ALL METHODS RELATED TO THE MATCHA PURCHASE

  void _initialize() async {
    // CHECK IF THE SHOP IS AVAILABLE
    var _available = await _iap.isAvailable();

    if (_available) {
      await _getProducts();
    }
  }

  checkPurchaseUpdates() {
    final purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(_onPurchaseUpdate);
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(_handlePurchase);
  }

  void _handlePurchase(PurchaseDetails purchaseDetails) {
    if (purchaseDetails.pendingCompletePurchase) {
      _iap.completePurchase(purchaseDetails);
    }
  }

  void _buyProduct(ProductDetails prod) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);

    await _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
    checkPurchaseUpdates();
  }

  Future<void> _getProducts() async {
    Set<String> ids = {testID};
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
    });
  }

  //----------------------------------------------------------------------
  @override
  void initState() {
    _initialize();

    super.initState();
  }

  bool changedTime = false;
  @override
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);

    SettingsController sc = SettingsController();
    String notificationTime = sc.getCurrentNotificationTime(context);
    String userName = sc.getUserName(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: myBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            systemLocales.first.toString() == "es_ES"
                ? "Configuración"
                : "Configuration",
            style: GoogleFonts.aboreto(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          backgroundColor: myBackgroundColor,
          bottom: TabBar(
              unselectedLabelColor: containerColor,
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                  icon: const Icon(Icons.settings),
                  text: systemLocales.first.toString() == "es_ES"
                      ? "Ajustes"
                      : "Settings",
                ),
                Tab(
                  icon: const Icon(Icons.person_2_rounded),
                  text: systemLocales.first.toString() == "es_ES"
                      ? "Autor"
                      : "Author",
                )
              ]),
        ),
        body: TabBarView(children: [
          //SETTINGS
          Container(
            height: maxheight,
            width: maxwidth,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
            ),
            child: ListView(
              padding: const EdgeInsets.all(25.0),
              children: [
                Text(
                  systemLocales.first.toString() == "es_ES"
                      ? "Nombre de Usuario:"
                      : "USERNAME:",
                  style: GoogleFonts.aboreto(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: maxwidth * 0.7,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        maxLength: 15,
                        controller: widget.myEditingController,
                        style: GoogleFonts.aboreto(
                            textStyle: const TextStyle(
                                color: Colors.teal, fontSize: 25)),
                        decoration: InputDecoration(
                            counterText: '',
                            labelText: sc.getUserName(context),
                            labelStyle: const TextStyle(color: Colors.teal),
                            floatingLabelStyle: const TextStyle(
                                color: Colors.teal,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            focusColor: myBackgroundColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: myBackgroundColor, width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.teal, width: 3),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: maxwidth * 0.14,
                      height: maxwidth * 0.14,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: myBackgroundColor, width: 2),
                        color: widget.myEditingController.text.isNotEmpty
                            ? Colors.teal
                            : containerColor,
                      ),
                      child: TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          onPressed: widget.myEditingController.text.isNotEmpty
                              ? () {
                                  sc.changeUserName(
                                      context, widget.myEditingController.text);

                                  final snackbar = SnackBar(
                                    content: Text(
                                        systemLocales.first.toString() ==
                                                "es_ES"
                                            ? "Nombre de usuario cambiado a ${widget.myEditingController.text}"
                                            : "Username succesfuly changed to ${widget.myEditingController.text} ",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.aboreto(
                                            textStyle: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ))),
                                    backgroundColor: Colors.teal,
                                    duration: const Duration(seconds: 3),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                  widget.myEditingController.text = "";
                                }
                              : null,
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  systemLocales.first.toString() == "es_ES"
                      ? "Notificaciones:"
                      : "NOTIFICATIONS:",
                  style: GoogleFonts.aboreto(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: maxwidth * 0.7,
                      child: OutlinedButton(
                          onPressed: () async {
                            var newTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour:
                                      int.parse(notificationTime.split(":")[0]),
                                  minute:
                                      int.parse(notificationTime.split(":")[1]),
                                ),
                                initialEntryMode: TimePickerEntryMode.dialOnly);
                            if (newTime != null) {
                              // ignore: use_build_context_synchronously
                              sc.changeTime(context,
                                  "${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}");
                              setState(() {
                                changedTime = true;
                              });
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              side: const BorderSide(
                                  width: 2.0, color: myBackgroundColor),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 18.0, bottom: 18.0),
                            child: Text(notificationTime,
                                style: GoogleFonts.aboreto(
                                    textStyle: const TextStyle(
                                        fontSize: 25,
                                        color: myBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1))),
                          )),
                    ),
                    const Spacer(),
                    Container(
                      width: maxwidth * 0.14,
                      height: maxwidth * 0.14,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: myBackgroundColor, width: 2),
                        color: changedTime ? Colors.teal : containerColor,
                      ),
                      child: TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          onPressed: changedTime
                              ? () {
                                  sc.changeNotification(context);
                                  setState(() {
                                    changedTime = false;
                                  });
                                  String time =
                                      sc.getCurrentNotificationTime(context);
                                  final snackbar = SnackBar(
                                    content: Text(
                                        systemLocales.first.toString() ==
                                                "es_ES"
                                            ? "Tiempo de las notificaciones cambiado a $time"
                                            : "Time of notifications succesfuly changed to $time ",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.aboreto(
                                            textStyle: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ))),
                                    backgroundColor: Colors.teal,
                                    duration: const Duration(seconds: 3),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }
                              : null,
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: maxheight * 0.25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "--",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aboreto(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        color: containerColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Text(
                            systemLocales.first.toString() == "es_ES"
                                ? "Versión"
                                : "Version",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aboreto(
                                textStyle: const TextStyle(
                              fontSize: 18,
                              color: containerColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            )),
                          ),
                          Text(
                            "1.0.1",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aboreto(
                                textStyle: const TextStyle(
                              fontSize: 14,
                              color: containerColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "--",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aboreto(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        color: containerColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
          //AUTHOR
          Container(
            width: maxwidth,
            height: maxheight,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height:
                        maxheight > 600 ? maxheight * 0.77 : maxheight * 0.70,
                    child: Stack(children: [
                      Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            ListView(
                              //TEXT IS CONTAINED IN THIS LISTVIEW ALLOWING THE USER TO SCROLL.

                              children: [
                                SizedBox(
                                  height: maxheight * 0.23,
                                ),
                                SizedBox(
                                  width: maxwidth,
                                  child: Center(
                                    child: Text(
                                      systemLocales.first.toString() == "es_ES"
                                          ? "Para ${SettingsController().getUserName(context)}"
                                          : " To ${SettingsController().getUserName(context)}:",
                                      style: GoogleFonts.aboreto(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23,
                                              color: Colors.teal)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: GoogleFonts.aboreto(
                                          textStyle: const TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              height: 1.8)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "Muchísimas gracias por probar MOOD. Este es un"
                                                : "Thank you very much for trying MOOD. This is a"),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "Proyecto sin ánimo de lucro"
                                                : " NON PROFIT PROJECT.",
                                            style: const TextStyle(
                                                color: Colors.teal)),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "El propósito de este es facilitar a las personas el"
                                                : " The purpose of it is to make it easier for people to"),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "detectar problemas relacionados con la salud mental mediante el seguimiento de los estados de ánimo."
                                                : " detect issues related to mental health by monitoring their mood.",
                                            style: const TextStyle(
                                                color: Colors.teal))
                                      ]),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: maxwidth,
                                  child: Center(
                                    child: Text(
                                      systemLocales.first.toString() == "es_ES"
                                          ? "El Autor"
                                          : "The Author",
                                      style: GoogleFonts.aboreto(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23,
                                              color: Colors.teal)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: GoogleFonts.aboreto(
                                          textStyle: const TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              height: 1.8)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "Encantado de conocerte! "
                                                : "Nice to meet you! ",
                                            style: const TextStyle(
                                                color: Colors.teal)),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "Soy un estudiante de ingeniería informática "
                                                : "I am a software engineer student "),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "(En este momento)"
                                                : "(at the moment)",
                                            style: const TextStyle(
                                                color: containerColor)),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? " de A Coruña, una pequeña ciudad en el norte de España."
                                                : " based in A Coruña, a small city in north-west Spain.")
                                      ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: GoogleFonts.aboreto(
                                          textStyle: const TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              height: 1.8)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: systemLocales.first
                                                      .toString() ==
                                                  "es_ES"
                                              ? "Actualmente estoy creando mi portfolio y MOOD. es mi primer proyecto."
                                              : "I am currently creating my portfolio and MOOD. is actually my first ever project.",
                                        ),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? " Espero que estés disfrutando mi aplicación y que la mayoría de tus días sean dias felices!"
                                                : " I hope you are enjoying my app and that most of your days are HappyDays!",
                                            style: const TextStyle(
                                                color: Colors.teal)),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: GoogleFonts.aboreto(
                                          textStyle: const TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              height: 1.8)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "Como he mencionado antes,"
                                                : "As I mentioned before,"),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? " No busco hacer dinero con este proyecto, "
                                                : " I am not aiming to make money with this project, ",
                                            style: const TextStyle(
                                                color: Colors.teal)),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "pero, si quieres "
                                                : "but, if you want to "),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? " contribuir a mis futuros proyectos,"
                                                : " contribute to my future projects,",
                                            style: const TextStyle(
                                                color: Colors.teal)),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? " Hay un botón debajo de este párrafo que te permitirá "
                                                : " there is a button down this paragraph "
                                                    "that will allow you to "),
                                        TextSpan(
                                            text: systemLocales.first
                                                        .toString() ==
                                                    "es_ES"
                                                ? "donarme el valor de un té matcha."
                                                : "donate me the value of a matcha tea.",
                                            style: const TextStyle(
                                                color: Colors.teal)),
                                      ]),
                                ),
                                SizedBox(
                                  height: maxheight * 0.15,
                                )
                              ],
                            ),
                            Container(
                                height: maxheight * 0.1,
                                width: maxwidth,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        myBackgroundColor,
                                        Colors.teal,
                                        Colors.teal,
                                        myBackgroundColor,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 100.0,
                                          spreadRadius: 30),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    )),
                                child: TextButton(
                                  onPressed: () {
                                    _buyProduct(_products.first);
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.transparent)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          systemLocales.first.toString() ==
                                                  "es_ES"
                                              ? "Té Matcha para el Autor "
                                              : "Matcha for the Author  ",
                                          style: GoogleFonts.aboreto(
                                            textStyle: const TextStyle(
                                                fontSize: 19,
                                                color: Colors.white),
                                          )),
                                      const Icon(
                                        Icons.coffee_rounded,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ))
                          ]),
                      Container(
                        height: maxheight * 0.10,
                        color: Colors.white,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: maxheight <= 600
                            ? maxheight * 0.20
                            : maxheight * 0.22,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: containerColor, width: 2),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const CircleAvatar(
                                radius: 75,
                                backgroundImage: AssetImage(
                                  "assets/myFace.png",
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CRISTIAN",
                                  style: GoogleFonts.aboreto(
                                      textStyle: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal)),
                                ),
                                Text(
                                  "GONZÁLEZ TRILLO",
                                  style: GoogleFonts.aboreto(
                                      textStyle: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: textColor)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class IAPConnection {
  static InAppPurchase? _instance;
  static set instance(InAppPurchase value) {
    _instance = value;
  }

  static InAppPurchase get instance {
    _instance ??= InAppPurchase.instance;
    return _instance!;
  }
}
