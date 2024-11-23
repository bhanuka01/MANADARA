import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../aboutme/aboutmepage.dart';
// import '../aipage/aipage.dart';
// import '../aboutme/newpage.dart';
// import '../aboutme/notion.dart';
// import '../aboutme/notion1.dart';
import 'booknew.dart';

class Homenew extends StatefulWidget {
  const Homenew({super.key});

  @override
  State<Homenew> createState() => _HomenewState();
}

class _HomenewState extends State<Homenew> {
  bool isloadad = false;
  late final BannerAd bannerAd;
  var unitid = "ca-app-pub-6429842662800808/8338070969";

  bool isloadfull = false;
  late final InterstitialAd interstitialAd;
  var interstitialAdUnitId = "ca-app-pub-6429842662800808/3085744287";

  @override
  void initState() {
    super.initState();
    fetchdata();
    initbannerad();
    _loadInterstitialAd();

    if (!isDataLoaded) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        fetchdata();
        if (isDataLoaded) {
          timer.cancel(); // Stop timer once data is loaded
        }
        // print(
        //     "hi");// You might want to remove or replace this with a loading  indicator
      });
    }
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          setState(() {
            isloadfull = true;
          });
          interstitialAd.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            interstitialAd.dispose();
            ad.dispose();
            setState(() {
              isloadfull = false;
            });
          }, onAdFailedToShowFullScreenContent: (ad, err) {
            ad.dispose();
            interstitialAd.dispose();
            setState(() {
              isloadfull = false;
            });
          });
        },
        onAdFailedToLoad: (LoadAdError loadAdError) {
          interstitialAd.dispose();
        },
      ),
    );
  }

  initbannerad() {
    bannerAd = BannerAd(
        size: AdSize.largeBanner,
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

  List<dynamic> users = [];
  bool isDataLoaded = false;

  Future<void> fetchdata() async {
    const url =
        "https://raw.githubusercontent.com/bhanuka01/pothlanthaya/main/books/books.json";
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
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: bannerAd);
    final Container adcontainer = Container(
      alignment: Alignment.center,
      height: bannerAd.size.height.toDouble(),
      width: bannerAd.size.width.toDouble(),
      child: adWidget,
    );

    return isDataLoaded
        ? Scaffold(
            bottomNavigationBar: isloadad
                ? SizedBox(
                    // height: bannerAd.size.height.toDouble(),
                    // width: bannerAd.size.width.toDouble(),
                    // child: AdWidget(ad: bannerAd),
                    child: adcontainer,
                  )
                : const SizedBox(),
            backgroundColor: const Color(0xFF1A1A1A),
            appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.black38,
              actions: [
                IconButton(
                  onPressed: () {
                    if (isloadfull) {
                      // interstitialAd.show();
                    } else {
                      // print("Interstitial ad not loaded yet");
                      // Consider showing a loading indicator or delaying navigation
                    }
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const Aboutmepage()

                          // Notion(notionApiKey: 'secret_ii3cLWpXAxuS8xNg7hupQyqNDjMxAOPwrGfWQViV3iQ', databaseId: '6adad2b85ef941db8d85c220d113a0c1',),
                          ),
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Aboutmepage(),
                    //   ),
                    // );
                  },
                  icon: const Icon(
                    Icons.account_box_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
              title: Text(
                "MANADARA",
                style: GoogleFonts.rosario(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 27,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Book Summery",
                    style: GoogleFonts.rosario(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final head = user['head'];
                      final url = user['url'];
                      final img = user['img'];
                      return GestureDetector(
                        onTap: () {
                          // Navigate first, THEN show the ad if it's loaded
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Booknew(url, img),
                            ),
                          ).then((_) {
                            // .then() executes after returning from Booknew
                            if (isloadfull) {
                              interstitialAd.show();
                              isloadfull =
                                  false; // Reset the flag to prevent multiple ad shows
                            } else {
                              // print("Interstitial ad not loaded yet");
                            }
                          });
                        },
                        // ... rest of your GestureDetector

                        // return GestureDetector(
                        //   onTap: () {
                        //     if (isloadfull) {
                        //       interstitialAd.show();
                        //     } else {
                        //       print("Interstitial ad not loaded yet");
                        //     }
                        //     Navigator.push(
                        //       context,
                        //       PageTransition(
                        //         type: PageTransitionType.fade,
                        //         child: Booknew(url, img),
                        //       ),
                        //     );
                        //   },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.blueAccent,
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Text(
                                          head,
                                          style: GoogleFonts.rosario(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: CachedNetworkImage(
                                              imageUrl: img,
                                              fit: BoxFit.contain,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )
                                            // child: Image.network(img,
                                            //     fit: BoxFit.contain),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xFF1A1A1A),
            body: Center(
              child: Lottie.asset("assets/bh.json"),
            ),
          );
  }
}
