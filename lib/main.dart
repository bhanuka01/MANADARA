
// import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:async';

// import 'package:appwrite/appwrite.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:sinbook/pagesnew/homenew.dart';


// const apiKey = 'AIzaSyCqAOl9jE9WsL4PmrulKnP3p8jODpFzcZg';
Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // Client client = Client();
  // client
  //     .setEndpoint('https://cloud.appwrite.io/v1')
  //     .setProject('6474dc02a9dbd07ef9c9')
  //     .setSelfSigned(status: true);
  //
  // AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: Color(0xFF9D50DD),
  //       ledColor: Colors.white,
  //     ),
  //   ],
  // );



  runApp( const MyApp());
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.blue,
  //   statusBarColor: Colors.blue,// Set your desired color here
  //   statusBarIconBrightness: Brightness.light, // Example for icon brightness
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,

      home: Homenew(),
    );
  }
}

