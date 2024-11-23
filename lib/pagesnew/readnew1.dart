import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Readnew1 extends StatelessWidget {
  const Readnew1({super.key});

  @override
  Widget build(BuildContext context) {

    final List<String> items = [
      'ඔබේ උසස් නිලධාරීන් වඩා දක්ෂ ලෙස පෙනෙන්න සලස්වන්න: \nඔබේ සාර්ථකත්වයන් සඳහා ඔවුන්ගේ මඟ පෙන්වීම සහ ප්‍රඥාව හේතු කොටගෙන ඇති බවට සියුම් ලෙස ඉඟි කරන්න.ඔබට උපදෙස් අවශ්‍ය නොවුනත්, ඔවුන්ගෙන් උපදෙස් ඉල්ලා සිටින්න,ඔබේම අදහස් ඔවුන්ගේ අදහස්වල දිගුවක් ලෙස ඉදිරිපත් කරන්න.',
      'ඔබේම දක්ෂතා අවතක්සේරු කරන්න: \nඋපායමාර්ගිකව නිහතමානී වන්න.ඔබේ ජයග්‍රහණ ගැන පුරසාරම් දෙඩීමෙන් හෝ අවධානය ආකර්ෂණය කර ගැනීමෙන් වළකින්න.ඔබේ වැඩ කතා කිරීමට ඉඩ දෙන්න, නමුත් බලයේ සිටින අයට යටපත් නොවන්න.',
      'ඉවසිලිවන්ත වන්න, ඔබේ මොහොත එනතෙක් බලා සිටින්න:\nඔබේ කාලය ගත කිරීම සහ බල ගතිකයේ සියුම්කම් ඉගෙනීම අත්‍යවශ්‍ය වේ.නොමේරූ ලෙස ඉදිරියට නොයන්න.',
      'බලයේ මනෝවිද්‍යාව තේරුම් ගන්න: \nබලයේ සිටින අය බොහෝ විට අනාරක්ෂිත වන අතර ඔවුන්ගේ ස්ථානය අහිමි වේ යැයි බිය වෙති.ඔබේ ඉලක්කය විය යුත්තේ ඔවුන්ට ආරක්ෂිත සහ පාලනයක් දැනෙන බවක් ඇති කිරීම මිස ඔවුන්ට තර්ජනයක් දැනෙන බවක් ඇති කිරීම නොවේ.',
    ];
    final List<Widget> textWidgets = items.map((item) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Law 1",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        backgroundColor: Colors.white10,
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "Never outshine the master",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Key Point:\n උඩින් ඉන්න අයට හැමවිටම උසස් බවක් දැනෙන්න සලස්වන්න. ඔබේ දක්ෂතා ප්‍රදර්ශනය නොකරන්න, එසේ නොමැතිනම් ඔබේ උසස් නිලධාරීන් තුළ බිය හා අනාරක්ෂිත බව ඇති විය හැක.",
                style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "How to Apply:",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                textWidgets,

              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Summary:",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "බල ගතිකය හැසිරවීමේදී උපායමාර්ගික ගෞරවයේ වැදගත්කම 1 වන නීතියෙන් අවධාරණය කෙරේ.\n\nමෙම නීතිය දක්ෂතාවය පමණක් සාර්ථකත්වයට මග පාදයි යන බොළඳ උපකල්පනයට එරෙහිව අනතුරු ඇඟවීමකි. ඒ වෙනුවට, එය බලධාරීන්ගේ ආත්මාර්ථකාමීත්වය සහ අනාරක්ෂිත බව කළමනාකරණය කිරීමේ ඉතා වැදගත් කාර්යභාරය ඉස්මතු කරයි.\n\nඔබේ උසස් නිලධාරීන්ට සුවපහසු සහ උසස් බවක් දැනෙන්නට සැලැස්වීමෙන්, ඔවුන්ගේ බිය හෝ ඊර්ෂ්‍යාව අවුස්සන්නේ නැතිව ඔබේම දියුණුව සඳහා මාර්ගයක් නිර්මාණය කළ හැකිය.\n\nසටහන: මෙම නීතිය යටත් වීම හෝ ඔබේම අරමුණු කැප කිරීම වෙනුවෙන් පෙනී සිටින බව අර්ථ නිරූපණය නොකළ යුතුය. ඒ වෙනුවට, එය උපායමාර්ගික වීම ගැන සහ බලයේ සංකීර්ණතාවයන් හැසිරවීමට සියුම් බව සහ ඉවසීම අවශ්‍ය බව තේරුම් ගැනීම ගැනයි.\n\nසරලව කිවහොත්:\n\nඔබේ දක්ෂතා ප්‍රදර්ශනය කිරීමේදී බුද්ධිමත් වන්න.ඔබේ උසස් නිලධාරීන්ට තර්ජනයක් දැනෙන්නට ඉඩ නොතබන්න.ඔවුන්ට ගෞරවයෙන් සලකන්න, ඔවුන්ගේ හැඟීම් තේරුම් ගන්න.ඉවසිලිවන්ත වන්න, නියම වේලාව එනතෙක් බලා සිටින්න.බලය යනු සියුම් ක්‍රීඩාවකි, එය බුද්ධිමත්ව හැසිරවිය යුතුය.",

                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(

                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:http/http.dart' as http;
//
//
// class Readnew extends StatefulWidget {
//   final String url1;
//   const Readnew(this.url1, {super.key});
//
//   @override
//   State<Readnew> createState() => _ReadnewState();
// }
//
// class _ReadnewState extends State<Readnew> {
//   bool isloadad = false;
//   late final BannerAd bannerAd;
//   var unitid = "ca-app-pub-3940256099942544/6300978111";
//
//
//   List<dynamic> users = [];
//   bool isDataLoaded = false;
//   Future<void> fetchdata() async {
//     var url = widget.url1;
//     final uri = Uri.parse(url);
//     var response = await http.get(uri);
//     if (response.statusCode == 200) {
//       final body = response.body;
//       setState(() {
//         isDataLoaded = true;
//       });
//       final json = jsonDecode(body);
//       setState(() {
//         users = json['data'];
//       });
//     } else {}
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the counter
//     fetchdata();
//     initbannerad();
//   }
//   initbannerad() {
//     bannerAd = BannerAd(
//         size: AdSize.banner,
//         adUnitId: unitid,
//         listener: BannerAdListener(
//           onAdLoaded: (ad) {
//             setState(() {
//               isloadad = true;
//             });
//           },
//           onAdFailedToLoad: (ad, error) {
//             ad.dispose();
//             print(error);
//           },
//         ),
//         request: const AdRequest());
//     bannerAd.load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final AdWidget adWidget=AdWidget(ad: bannerAd);
//     final Container adcontainer=Container(
//       alignment: Alignment.center,
//       height: bannerAd.size.height.toDouble(),
//       width: bannerAd.size.width.toDouble(),
//       child: adWidget,
//     );
//     return isDataLoaded
//         ? Scaffold(
//         bottomNavigationBar: isloadad
//             ? SizedBox(
//           // height: bannerAd.size.height.toDouble(),
//           // width: bannerAd.size.width.toDouble(),
//           // child: AdWidget(ad: bannerAd),
//           child: adcontainer,
//         )
//             : const SizedBox(),
//         backgroundColor: const Color(0xFF1A1A1A),
//             // appBar: AppBar(
//             //   foregroundColor: Colors.white,
//             //   backgroundColor: Colors.white10,
//             //   title: Text(
//             //     users[0]['subtitle'],
//             //     style: GoogleFonts.poppins(
//             //       textStyle: const TextStyle(
//             //         fontWeight: FontWeight.w800,
//             //         color: Colors.white,
//             //         fontSize: 25,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//         appBar: AppBar(
//           backgroundColor: Colors.black38.withOpacity(0.5),
//           foregroundColor: Colors.white,// Adjust opacity as needed
//           flexibleSpace: ClipRect( // Use ClipRect to clip the blur effect
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 3), // Adjust blur intensity
//               child: Container(
//                 color: Colors.transparent, // Transparent background for the blur
//               ),
//             ),
//           ),
//           title: Text(
//             users[0]['subtitle'],
//             style: GoogleFonts.poppins(
//               textStyle: const TextStyle(
//                 fontWeight: FontWeight.w800,
//                 color: Colors.white,
//                 fontSize: 25,
//               ),
//             ),
//           ),
//         ),
//             body: ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 final user = users[index];
//                 final head = user['head'];
//                 final body = user['body'];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 10),
//                   child: ListTile(
//                     title: Column(
//                       children: [
//                         Text(
//                           head,
//                           style: GoogleFonts.poppins(
//                             textStyle: const TextStyle(
//                               fontWeight: FontWeight.w800,
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10,),
//                         Text(
//                           body,
//                           style: GoogleFonts.poppins(
//                             textStyle: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                   ),
//                 );
//               },
//             ))
//         : const Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A),
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//   }
// }


