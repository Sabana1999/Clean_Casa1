import 'package:casa_example/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({super.key});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  final String phoneNo = '8547413384';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional Information'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: Text('Contact Us'),
              subtitle: Text('(854)741-3384'),
              // leading: Icon(Icons.call_end_outlined),
              trailing: IconButton(
                  onPressed: () async {
                    // ignore: unnecessary_brace_in_string_interps
                    launchUrlString("tel://${phoneNo}");
                  },
                  icon: Icon(
                    Icons.call,
                    color: primary,
                  )),
            ),
            Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  'Additional Settings',
                  style: TextStyle(
                    fontSize: 16,
                    color: primary,
                  ),
                ),
              ],
            ),SizedBox(height: 22,),
            ListTile(
              title: Text('Settings'),
              leading: Icon(
                Icons.settings,
                color: primary,
              ),
            ),
            ListTile(
              title: Text('Refer friends'),
              leading: Icon(
                Icons.share,
                color: primary,
              ),
            ),
            ListTile(
              title: Text('About App'),
              leading: Icon(
                Icons.info_outlined,
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
