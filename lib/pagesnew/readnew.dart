import 'dart:async';
import 'dart:convert';
import 'dart:ui';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MyController extends GetxController {
  var head = 20.obs;
  var sub = 18.obs;
  var switchdark = true.obs;
}

// Future<void> sendNotification() async {
  // await AwesomeNotifications().initialize(
  //   // 'resource://drawable/res_app_icon', // Use your app icon here
  //   null, // Or null if you don't have a notification icon yet
  //   [
  //     NotificationChannel(
  //       channelGroupKey: 'basic_channel_group',
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: Color(0xFF9D50DD),
  //       ledColor: Colors.white,
  //       importance: NotificationImportance.High,
  //     ),
  //   ],
  //   channelGroups: [
  //     NotificationChannelGroup(
  //       channelGroupKey: 'basic_channel_group',
  //       channelGroupName: 'Basic group',
  //     )
  //   ],
  //   debug: true,
  // );

//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 10,
//       channelKey: 'basic_channel',
//       title: 'Simple Notification',
//       body: 'This is a simple notification example.',
//     ),
//   );
// }


class Readnew extends StatefulWidget {
  final String url1;
  const Readnew(this.url1, {super.key});

  @override
  State<Readnew> createState() => _ReadnewState();
}

class _ReadnewState extends State<Readnew> {
  final MyController c = Get.put(MyController());
  bool isloadad = false;
  late final BannerAd bannerAd;
  var unitid = "ca-app-pub-xxxxxx/xxxxxxxx";

  List<dynamic> users = [];
  bool isDataLoaded = false;
  // double _fontSize = 18.0;
  // double _fontSizeh = 20.0;

  // bool _isDarkMode = true; // Add a variable to track dark mode

  Future<void> fetchdata() async {
    var url = widget.url1;
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      setState(() {
        isDataLoaded = true;
      });
      final json = jsonDecode(body);
      setState(() {
        users = json['data'];
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
    initbannerad();
    if (!isDataLoaded) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        fetchdata();
        if (isDataLoaded) {
          timer.cancel(); // Stop timer once data is loaded
        }
        // print(
        //     "hi"); // You might want to remove or replace this with a loading indicator
      });
    }

    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
  }

  initbannerad() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: unitid,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isloadad = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            // print(error);
          },
        ),
        request: const AdRequest());
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: bannerAd);
    final Container adcontainer = Container(
      alignment: Alignment.center,
      height: bannerAd.size.height.toDouble(),
      width: bannerAd.size.width.toDouble(),
      child: adWidget,
    );

    // Define colors based on dark mode
    Color backgroundColor =
        c.switchdark.value ? const Color(0xFF1A1A1A) : Colors.white;
    Color textColor = c.switchdark.value ? Colors.white : Colors.black;
    Color appBarColor = c.switchdark.value
        ? Colors.black38.withOpacity(0.5)
        : Colors.white38; // Or any light color

    return isDataLoaded
        ? Scaffold(
            bottomNavigationBar: isloadad ? adcontainer : const SizedBox(),
            backgroundColor: backgroundColor,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            //   child: Icon(Icons.ac_unit_outlined),
            // ),
            appBar: AppBar(
              backgroundColor: appBarColor, // Apply app bar color
              foregroundColor: textColor, // Apply text color
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 3),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              title: Text(
                users[0]['subtitle'],
                style: GoogleFonts.rosario(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor, // Apply text color
                    fontSize: 25,
                  ),
                ),
              ),
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.add),
              //     onPressed: () {
              //       setState(() {
              //         // _fontSize++;
              //         // _fontSizeh++;
              //         c.head++;
              //         c.sub++;
              //       });
              //     },
              //   ),
              //   IconButton(
              //     icon: const Icon(Icons.remove),
              //     onPressed: () {
              //       // sendNotification;
              //       // sendNotification();
              //
              //       setState(() {
              //         // _fontSize--;
              //         // _fontSizeh--;
              //         c.head--;
              //         c.sub--;
              //       });
              //     },
              //   ),
              //   Switch(
              //     // activeColor: Colors.redAccent,
              //     activeTrackColor: Colors.white38,
              //     value: c.switchdark.value,
              //     onChanged: (value) {
              //       setState(() {
              //         c.switchdark.value = value;
              //       });
              //     },
              //   ),
              // ],
            ),
            body: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final head = user['head'];
                final body = user['body'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Column(
                      children: [
                        Text(
                          head,
                          style: GoogleFonts.notoSerifSinhala(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w800,

                              color: textColor, // Apply text color
                              fontSize: c.head.toDouble(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          body,
                          style: GoogleFonts.notoSerifSinhala(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: textColor, // Apply text color
                              // fontSize: _fontSize,
                              fontSize: c.sub.toDouble(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // subtitle: const SizedBox(
                    //   height: 70,
                    // ),
                  ),
                );
              },
            ))
        : Scaffold(
            backgroundColor: backgroundColor, // Apply background color
            body: Center(
              child: Lottie.asset("assets/bh.json"),
            ),
          );
  }
}
