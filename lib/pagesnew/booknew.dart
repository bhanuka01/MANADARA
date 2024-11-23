import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sinbook/pagesnew/readnew.dart';

import 'package:http/http.dart' as http;

class Booknew extends StatefulWidget {
  final String url1;
  final String img;
  const Booknew(this.url1, this.img, {super.key});

  @override
  State<Booknew> createState() => _BooknewState();
}

class _BooknewState extends State<Booknew> {


  bool isloadfull = false;
  late final InterstitialAd interstitialAd;
  var interstitialAdUnitId = "ca-app-pub-xxxxxxx/xxxxxxx";
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

  List<dynamic> users = [];
  bool isDataLoaded = false;

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
    // Initialize the counter
    fetchdata();
    _loadInterstitialAd();
    if (!isDataLoaded) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        fetchdata();
        if (isDataLoaded) {
          timer.cancel(); // Stop timer once data is loaded
        }
        // print("hi"); // You might want to remove or replace this with a loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded
        ? Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              title: Text(
                users[0]['title'],
                style: GoogleFonts.rosario(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              backgroundColor: Colors.black38,
            ),
            backgroundColor: const Color(0xFF1A1A1A),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                     child:  CachedNetworkImage(
                       height: MediaQuery.of(context).size.height / 3,
                        imageUrl: widget.img,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      )
                    // child: Image.network(
                    //     height: MediaQuery.of(context).size.height / 3,
                    //     widget.img,
                    //     fit: BoxFit.contain),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final head = user['head'];

                    final subtitle = user['subtitle'];
                    final url1 = user['url'];
                    return ListTile(
                      title: InkWell(
                        onTap: ()  {
                          // Navigate first, THEN show the ad if it's loaded
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Readnew(url1),
                            ),
                          ).then((_) { // .then() executes after returning from Booknew
                            if (isloadfull) {
                              interstitialAd.show();
                              isloadfull = false; // Reset the flag to prevent multiple ad shows
                            } else {
                              // print("Interstitial ad not loaded yet");
                            }
                          });
                        },
                        // {
                        //   Navigator.push(
                        //     context,
                        //     PageTransition(
                        //       type: PageTransitionType.fade,
                        //       child: Readnew(url1),
                        //     ),
                        //   );
                        //
                        //   // Navigator.push(
                        //   //   context,
                        //   //   MaterialPageRoute(
                        //   //     builder: (context) => Readnew(url1),
                        //   //   ),
                        //   // );
                        // },
                        child: Container(
                          // color: Colors.blueAccent,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subtitle,
                                      // textAlign: TextAlign.start,
                                      style: GoogleFonts.rosario(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.blueAccent,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        head,
                                        overflow: TextOverflow.fade,
                                        style: GoogleFonts.notoSerifSinhala(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        :  Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
            body: Center(
                child: Lottie.asset("assets/bh.json")
            ),
          );
  }
}
