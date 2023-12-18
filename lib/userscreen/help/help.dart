import 'package:casa_example/userscreen/help/additional.dart';
import 'package:casa_example/userscreen/help/firsr.dart';
import 'package:casa_example/userscreen/help/second.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserHelp extends StatefulWidget {
  const UserHelp({Key? key}) : super(key: key);

  @override
  State<UserHelp> createState() => _UserHelpState();
}

class _UserHelpState extends State<UserHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Help Centre'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            buildHelpCard(
              'How do I book a service?',
              Icons.arrow_forward_ios_outlined,
              FirstHelp(),
            ),
            SizedBox(height: 30),
            buildHelpCard(
              'How to add another account?',
              Icons.arrow_forward_ios_outlined,
              SecondHelp(),
            ),
            SizedBox(height: 30),
            buildHelpCard(
              'How to edit email id?',
              Icons.arrow_forward_ios_outlined,
              FirstHelp(),
            ),
            SizedBox(height: 30),
            buildHelpCardWithLink(
              'Privacy Policy',
              Icons.arrow_forward_ios_outlined,
              'https://www.freeprivacypolicy.com/live/7f3d755a-c97c-4f68-9d11-06f165f0bc22',
            ),
            SizedBox(height: 30),
            buildHelpCard(
              'Additional Information',
              Icons.arrow_forward_ios_outlined,
              AdditionalInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHelpCard(String title, IconData icon, Widget route) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(255, 28, 27, 27), width: 0.5),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 255, 255, 255),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => route));
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  icon,
                  size: 28,
                  color: Colors.grey[700],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHelpCardWithLink(String title, IconData icon, String url) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(255, 11, 11, 11), width: 0.5),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            launchUrl(Uri.parse(url));
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  icon,
                  size: 28,
                  color: Colors.grey[700],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
