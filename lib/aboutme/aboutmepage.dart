import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:sinbook/aboutme/todopage.dart';
import 'package:url_launcher/url_launcher.dart';


// import 'package:awesome_notifications/awesome_notifications.dart';

class Aboutmepage extends StatefulWidget {
  const Aboutmepage({super.key});

  @override
  State<Aboutmepage> createState() => _AboutmepageState();
}

class _AboutmepageState extends State<Aboutmepage> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("About me",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                color:  Colors.white,
                fontSize: 25,
              ),
            )),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor:const Color(0xFF1A1A1A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1A), // Lighter top color
              Color(0xFF000000), // Darker bottom color
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Circle avatar for the image with a subtle border
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF656565), // White border
                    width: 4.0, // Border width
                  ),
                ),
                child: const CircleAvatar(
                  radius: 70, // Slightly smaller avatar
                  backgroundImage: AssetImage('assets/imgab.jpg'),
                ),
              ),
              const SizedBox(height: 40),
              // Information displayed in a card for visual separation
              Card(
                color: Color(0xFF656565),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                elevation: 4, // Card shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Shrink-wrap card content
                    children: [
                      _buildInfoRow("Name", "Bhanuka Dilshan"),
                      const SizedBox(height: 20),

                      _buildInfoRow("Study", "Statistics(UOR)"),
                      const SizedBox(height: 20),
                      _buildInfoRow("Developer", "Flutter Mobile"),
                      const SizedBox(height: 20),
                      // _buildInfoRow("Version", "0.8.1"),
                      // const SizedBox(height: 20),
                      _buildWebsiteButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  Widget _buildInfoRow(String label, String value) { // Inside _AboutmepageState
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: buildTextStyle()),
        Text(value, style: buildTextStyle1()),
      ],
    );
  }
  Widget _buildWebsiteButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final url = Uri.parse('https://bhanu.eu.org');
        if (!await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        )) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $url')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 3, // No button shadow, card provides elevation
      ),
      child: Text(
        "Visit Website", // Button label instead of full URL
        style: GoogleFonts.poppins(
          textStyle: buildTextStyle1().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}




  TextStyle buildTextStyle() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white, // Softer label color
      ),
    );
  }
  TextStyle buildTextStyle1() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
    );
  }

// }

